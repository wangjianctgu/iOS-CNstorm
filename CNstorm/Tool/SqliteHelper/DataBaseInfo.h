//
//  DataBaseInfo.h
//  travelApp
//
//  Created by 徐彪 on 13-8-27.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableInfo.h"
#import "XubModel.h"
//用来存储表结构信息的类
@interface DataBaseInfo : NSObject
{
    NSDictionary *infoDic;
}

@property(nonatomic,retain)NSMutableDictionary *tablesInfos;

@property(nonatomic,retain)NSString* dbpath;


+ (DataBaseInfo*)defaultDataBaseInfo;

+ (ColunmInfo*)getPkColunmInfo:(NSString*)tableName;

+ (ColunmInfo*)getColunmInfo:(NSString*)tableName colname:(NSString*)colname;

+ (void)InitDefaultDataBaseInfo:(NSString*)dbinfoPath DBPath:(NSString*)dbpath;

@end
