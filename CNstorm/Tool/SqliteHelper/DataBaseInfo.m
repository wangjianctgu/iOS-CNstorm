//
//  DataBaseInfo.m
//  travelApp
//
//  Created by 徐彪 on 13-8-27.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import "DataBaseInfo.h"


@implementation DataBaseInfo

@synthesize tablesInfos,dbpath;

static DataBaseInfo* databaseInfo;

+(DataBaseInfo*)defaultDataBaseInfo
{
    return databaseInfo;
}

+(ColunmInfo*)getPkColunmInfo:(NSString*)tableName{
    TableInfo* table=[[DataBaseInfo defaultDataBaseInfo].tablesInfos objectForKey:tableName];
    return  table.colunmInfos[table.pkcolid-1];
}
+(ColunmInfo*)getColunmInfo:(NSString*)tableName colname:(NSString*)colname{
    
    TableInfo* table=[[DataBaseInfo defaultDataBaseInfo].tablesInfos objectForKey:tableName];
    for (ColunmInfo *col in table.colunmInfos) {
        if([col.colName compare:colname]==NSOrderedSame)
            return col;
    }
    return nil;
}

+(void)InitDefaultDataBaseInfo:(NSString *)dbinfoPath DBPath:(NSString *)dbpath
{
    if(databaseInfo==nil)
    {
        databaseInfo = [[DataBaseInfo alloc]init];
    }
   
    NSDictionary* tables=[[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dbinfoPath] options:NSJSONReadingMutableContainers error:nil] objectForKey:@"tables"];
    
    databaseInfo.tablesInfos=[[NSMutableDictionary alloc]init];
    
    for (NSString* tablename in tables.allKeys)
    {
        [DataBaseInfo createTableInfo:tablename tables:tables];
    }
    
    databaseInfo.dbpath = dbpath;
    
//     for (NSString* tablename in databaseInfo.tablesInfos.allKeys) {
//         NSLog(@"表名:%@",tablename);
//         TableInfo *table=[databaseInfo.tablesInfos objectForKey:tablename];
//         ColunmInfo* pkcol=table.colunmInfos[table.pkcolid-1];
//         NSLog(@"主键:%@",pkcol.colName);
//         NSLog(@"引用该主键的表");
//         for (NSString *fktablename in table.referencedtables.allKeys) {
//             NSLog(fktablename);
//         }
//         
//         for (ColunmInfo * col in table.colunmInfos) {
//             NSLog(@"列名:%@ 类型:%@",col.colName,col.type);
//             if(col.referenceTable)
//                 NSLog(@"该列引用了:%@",col.referenceTable);
//         }
//          NSLog(@"____________________________");
//               
//     }
}

+(void)createTableInfo:(NSString*)tablename tables:(NSDictionary*) tables{
    if([databaseInfo.tablesInfos objectForKey:tablename]==nil){//判断这张表是否生成
        TableInfo *table=[[TableInfo alloc]init:tablename];
        [databaseInfo.tablesInfos setObject:table forKey:tablename];
        NSDictionary* tabledic=[tables objectForKey:tablename];//得到表的属性
        NSDictionary *cols=[tabledic objectForKey:@"colunms"];//得到所有的列
        for (NSString * colname in cols.allKeys) {
            NSDictionary* coldic=[cols objectForKey:colname];//得到列的属性
            NSNumber *number=[coldic objectForKey:@"colid"];
            
            ColunmInfo *col=[[ColunmInfo alloc]init:colname type:[coldic objectForKey:@"type"] colid:[number integerValue]];
            NSString* refentablename=[coldic objectForKey:@"referencedtable"];//列有没有引用表
            if( refentablename){
                
                if([databaseInfo.tablesInfos objectForKey:refentablename]==nil)//检查引用表是否已经生成
                    [DataBaseInfo createTableInfo:refentablename tables:tables];
               TableInfo* referenceTable=[databaseInfo.tablesInfos objectForKey:refentablename];//得到引用表
                [referenceTable.referencedtables setObject:table forKey:tablename];//将指定表加入引用表的被引用表集合
                col.referenceTable=refentablename;
                
            }
            [table.colunmInfos addObject:col];
            if([colname compare:[tabledic objectForKey:@"pk"]]==NSOrderedSame){
                table.pkcolid=col.colid;
                
            }
        }
        [table.colunmInfos sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            ColunmInfo *col1=obj1;
            ColunmInfo *col2=obj2;
            if(col1.colid<=col2.colid)
                return NSOrderedAscending;
            else
                return NSOrderedDescending;
        }];
    }
}

@end
