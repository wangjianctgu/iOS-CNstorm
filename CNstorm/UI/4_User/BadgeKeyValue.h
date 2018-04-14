//
//  BadgeKeyValue.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-9-30.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XubModel.h"

@interface BadgeKeyValue : XubModel <NSCoding>

@property (nonatomic, readwrite) int tabBadge4;
@property (nonatomic, readwrite) int myStorageBadge;
@property (nonatomic, readwrite) int awaitReceiveBadge;
@property (nonatomic, readwrite) int allWayBadge;
@property (nonatomic, readwrite) int messageBadge;

- (id)init;

@end
