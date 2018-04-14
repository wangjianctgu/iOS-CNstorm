//
//  Cart.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-22.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "Cart.h"

@implementation Cart

- (id) init
{
	if((self = [super init]))
    {
        self.storeGoodsArray = [[NSMutableArray alloc]init];
        
        self.isAllSelected = YES;
	}
	return self;
}

@end
