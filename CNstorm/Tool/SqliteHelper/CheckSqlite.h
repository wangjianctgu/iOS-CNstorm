//
//  CheckSqlite.h
//  travelApp
//
//  Created by 徐彪 on 13-8-23.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckSqlite : NSObject
+(void)checkSqlite:(NSString*)resourceFile LocalConfigurationPath:(NSString*)Local DBPath:(NSString*) dbpath;
@end
