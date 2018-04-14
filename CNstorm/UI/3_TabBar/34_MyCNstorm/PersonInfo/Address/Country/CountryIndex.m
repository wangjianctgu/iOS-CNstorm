//
//  CountryIndex.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "CountryIndex.h"

@implementation CountryIndex

- (id)init
{
	if((self = [super init]))
    {
        self.countryList = [NSMutableArray arrayWithCapacity:0];
	}
	return self;
}

@end
