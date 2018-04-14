//
//  DeliveryIndex.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "DeliveryIndex.h"

@implementation DeliveryIndex

- (id)init
{
	if((self = [super init]))
    {
        self.deliveryList = [NSMutableArray arrayWithCapacity:0];
	}
	return self;
}

@end
