//
//  TableInfo.h
//  travelApp
//
//  Created by 徐彪 on 13-8-27.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColunmInfo.h"
@interface TableInfo : NSObject
@property(nonatomic,copy)NSString* tableName;
@property(nonatomic,assign)NSInteger pkcolid;
@property(nonatomic,retain)NSMutableDictionary* referencedtables;
@property(nonatomic,retain)NSMutableArray* colunmInfos;
-(id)init:(NSString*)tablename;
@end
