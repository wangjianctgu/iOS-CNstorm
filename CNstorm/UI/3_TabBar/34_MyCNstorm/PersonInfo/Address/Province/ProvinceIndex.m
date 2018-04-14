//
//  ProvinceIndex.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-25.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "ProvinceIndex.h"

@implementation ProvinceIndex

- (id)init
{
	if((self = [super init]))
    {
        self.provinceList = [NSMutableArray arrayWithCapacity:0];
	}
	return self;
}

@end
