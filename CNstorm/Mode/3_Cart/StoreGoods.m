//
//  StoreGoods.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-23.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "StoreGoods.h"

@implementation StoreGoods

- (id) init
{
	if((self = [super init]))
    {
        self.goodsArray = [[NSMutableArray alloc]init];
        
        self.isSelected = YES;
	}
	return self;
}


@end
