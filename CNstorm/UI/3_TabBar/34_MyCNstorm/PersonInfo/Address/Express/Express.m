//
//  Express.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-15.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "Express.h"

@implementation Express

- (id)init
{
	if((self = [super init]))
    {
        self.expressId = 0;
        self.name_en = @"";
        self.name_cn = @"";
    }
    return self;
}

@end
