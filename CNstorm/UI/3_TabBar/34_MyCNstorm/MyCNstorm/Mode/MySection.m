//
//  MySection.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-7.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "MySection.h"

@implementation MySection

- (id) init
{
	if((self = [super init]))
    {
        self.myRowMutableArray = [[NSMutableArray alloc]init];
	}
	return self;
}

@end
