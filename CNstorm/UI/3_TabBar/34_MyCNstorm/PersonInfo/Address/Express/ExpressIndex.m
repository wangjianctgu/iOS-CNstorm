//
//  ExpressIndex.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-15.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "ExpressIndex.h"

@implementation ExpressIndex

- (id)init
{
	if((self = [super init]))
    {
        self.expressList = [NSMutableArray arrayWithCapacity:0];
	}
	return self;
}


@end
