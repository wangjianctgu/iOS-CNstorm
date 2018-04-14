//
//  ColunmInfo.h
//  travelApp
//
//  Created by 徐彪 on 13-8-27.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableInfo.h"
@interface ColunmInfo : NSObject
@property(nonatomic,copy)NSString* colName;
@property(nonatomic,copy)NSString* type;
@property(nonatomic,assign)NSInteger colid;
@property(nonatomic,copy)NSString* referenceTable;
-(id)init:(NSString*)colname type:(NSString*)_type colid:(NSInteger)_colid;
@end
