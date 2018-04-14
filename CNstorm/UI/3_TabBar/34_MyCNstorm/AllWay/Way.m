//
//  Way.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-12.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "Way.h"

@implementation Way

- (id) init
{
	if((self = [super init]))
    {
        self.packageList = [NSMutableArray arrayWithCapacity:0];
        
        self.isCancel = NO;
	}
	return self;
}

@end
