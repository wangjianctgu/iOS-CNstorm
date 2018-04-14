//
//  CheckSqlite.m
//  travelApp
//
//  Created by 徐彪 on 13-8-23.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import "CheckSqlite.h"

#import "SqliteHelper.h"


@implementation CheckSqlite


+ (void)checkSqlite:(NSString*)resourceFile LocalConfigurationPath:(NSString*)Local DBPath:(NSString*) dbpath
{
    NSFileManager* fm = [NSFileManager defaultManager];
    
    //json数据有问题的时候，会转换成null
    NSDictionary *resourcedic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:resourceFile] options:NSJSONReadingMutableContainers error:nil];
    
    if([fm fileExistsAtPath:Local])
    {
        NSLog(@"存在");
        //对比资源文件和本地配置文件的版本号
        NSDictionary *localdic=[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:Local] options:NSJSONReadingMutableContainers error:nil];
        
        NSString *rv = [resourcedic objectForKey:@"version"];
        
        NSString *lv = [localdic objectForKey:@"version"];
        
        //如果版本不同更新数据库;版本相同，本地数据库就不需要更新，本地Json文件也不需要更新
        //更新：增加表、增加列、删除表（不包含修改列、删除列）
        if([rv compare:lv] != NSOrderedSame)
        {
            NSLog(@"版本号不同");
            SqliteHelper *helper=[[SqliteHelper alloc]initWithDataPath:dbpath];
            
            @try
            {
                [helper OpenSqlite];
                
                [helper BeginTransaction];
                
                NSDictionary *tables=[resourcedic objectForKey:@"tables"];
                
                NSDictionary *localtables=[localdic objectForKey:@"tables"];
                
                NSArray *tablenames=[tables allKeys];
                
                for (int i=0; i<tablenames.count; i++)
                {
                    NSString *tablename=tablenames[i];
                    
                    NSDictionary *table=[tables objectForKey:tablename];
                    
                    NSDictionary *localtable=[localtables objectForKey:tablename];
                    
                    if(!localtable)
                    {   //增加表:如果本地没有这张表，插入
                        [CheckSqlite insertTable:table tableName:tablename SqliteHelper:helper];
                    }
                    else
                    {
                        NSDictionary *cols=[table objectForKey:@"colunms"];
                        
                        NSDictionary *localcols=[localtable objectForKey:@"colunms"];
                        
                        NSArray *colnames=[cols allKeys];
                        
                        for (int j=0; j<colnames.count; j++)
                        {
                            NSString *colname=colnames[j];
                            
                            NSDictionary *col=[cols objectForKey:colname];
                            
                            NSString *type=[col objectForKey:@"type"];
                            
                            NSDictionary *localcol=[localcols objectForKey:colname];
                            
                            if(!localcol)
                            {   //增加列:如果本地没有这列，添加
                                NSString *sql=[NSString stringWithFormat:@"alter table %@ add %@ %@",tablename,colname,type];
                                
                                [helper ExecSQL:sql throwEx:NO];
                            }
                        }
                    }
                }
                
                //删除表和修改版本号需要同时进行
                NSArray *localtablenames=[localtables allKeys];
                
                for (int i=0; i<localtablenames.count;i++)
                {
                    NSString *localtablename = localtablenames[i];
                    
                    //NSDictionary *localtable = [localtables objectForKey:localtablename];
                    
                    NSDictionary *table=[tables objectForKey:localtablename];
                    
                    if(!table)
                    {   //删除表:如果新版本中没有这张表删除 注:不进行删除列的动作
                        NSLog(@"删除表");
                        NSString *sql=[NSString stringWithFormat:@"drop table %@" ,localtablename];
                        
                        [helper ExecSQL:sql throwEx:NO];
                    }
                }
                
                
                //更新本地的json文件
                NSLog(@"删除json文件");
                [fm removeItemAtPath:Local error:nil];
                
                [fm copyItemAtPath:resourceFile toPath:Local error:nil];
                
                [helper CommitTransaction];
                
            }
            @catch (NSException *exception)
            {
                [helper RollbackTransaction];
            }
            @finally
            {
                [helper CloseSqlite];
            }
        }
    }
    else
    {
        //创建数据库，并将资源文件复制到本地目录
        SqliteHelper * helper = [[SqliteHelper alloc]initWithDataPath:dbpath];
        
        @try
        {
            [helper OpenSqlite];
            
            [helper BeginTransaction];
            
            NSDictionary *tables=[resourcedic objectForKey:@"tables"];
            
            NSArray *tablenames=[tables allKeys];
            
            for (int i=0; i<tablenames.count;i++)
            {
                NSDictionary *table=[tables objectForKey:tablenames[i]];
                
                [CheckSqlite insertTable:table tableName:tablenames[i] SqliteHelper:helper];
            }
            
            [fm copyItemAtPath:resourceFile toPath:Local error:nil];
            
            [helper CommitTransaction];
        }
        @catch (NSException *exception)
        {
            NSLog(@"[exception reason] = %@",[exception reason]);
            [helper RollbackTransaction];
        }
        @finally
        {
            [helper CloseSqlite];
        }
    }
}

+(void)insertTable:(NSDictionary*)table tableName:(NSString*)tablename SqliteHelper:(SqliteHelper*) helper
{
    NSString* pk=[table objectForKey:@"pk"];
    
    NSDictionary *cols=[table objectForKey:@"colunms"];
    
    NSString* sql=[NSString stringWithFormat:@"create table %@ (",tablename];
    
    NSArray *colnames=[cols allKeys];
    
    colnames=[colnames sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        NSDictionary *dic1=[cols objectForKey:obj1];
        
        NSDictionary *dic2=[cols objectForKey:obj2];
        
        return [[dic1 objectForKey:@"colid"] compare:[dic2 objectForKey:@"colid"]];
    }];
    
    for (int j=0; j<colnames.count; j++)
    {
        NSString* colname=colnames[j];
        
        NSDictionary *dic=[cols objectForKey:colname];
        
        NSString* type=[dic objectForKey:@"type"];
        
        sql=[sql stringByAppendingFormat:@"%@ %@",colname,type];
        
        if([colname compare:pk]==NSOrderedSame)
        {
            sql=[sql stringByAppendingFormat:@" PRIMARY KEY"];
        }
        
        if(j<colnames.count-1)
            sql=[sql stringByAppendingFormat:@" ,"];
        
    }
    
    sql=[sql stringByAppendingFormat:@" )"];
    
    [helper ExecSQL:sql throwEx:NO];
}

@end
