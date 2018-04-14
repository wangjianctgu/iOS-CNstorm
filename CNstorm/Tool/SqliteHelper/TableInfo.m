//
//  TableInfo.m
//  travelApp
//
//  Created by 徐彪 on 13-8-27.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import "TableInfo.h"

@implementation TableInfo
@synthesize referencedtables,tableName,colunmInfos,pkcolid;
-(id)init:(NSString*)tablename{
    if(self=[super init]){
        referencedtables=[[NSMutableDictionary alloc]init];
        colunmInfos=[[NSMutableArray alloc]init];
        self.tableName=tablename;
    }
    return self;
}
@end
