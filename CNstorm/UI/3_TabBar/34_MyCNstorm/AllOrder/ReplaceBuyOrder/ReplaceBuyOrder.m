//
//  ReplaceBuyOrder.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-13.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "ReplaceBuyOrder.h"

@implementation ReplaceBuyOrder

- (id) init
{
	if((self = [super init]))
    {
        self.goodsList = [NSMutableArray arrayWithCapacity:0];
	}
	return self;
}

@end
