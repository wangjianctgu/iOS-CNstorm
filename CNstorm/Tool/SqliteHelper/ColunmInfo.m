//
//  ColunmInfo.m
//  travelApp
//
//  Created by 徐彪 on 13-8-27.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import "ColunmInfo.h"

@implementation ColunmInfo
@synthesize colName,type,colid,referenceTable;
-(id)init:(NSString*)colname type:(NSString*)_type colid:(NSInteger)_colid{
    if(self=[super init]){
        self.colName=colname;
        self.type=_type;
        self.colid=_colid;
    }
    return self;
}
@end
