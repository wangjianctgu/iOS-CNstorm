//
//  BuyPackage.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-17.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "BuyPackage.h"

@implementation BuyPackage

- (id) init
{
	if((self = [super init]))
    {
        self.goodsList = [NSMutableArray arrayWithCapacity:0];
	}
	return self;
}

@end
