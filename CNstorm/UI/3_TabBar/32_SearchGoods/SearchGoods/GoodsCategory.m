//
//  GoodsCategory.m
//  InfiniteTreeView
//
//  Created by Zhang Lisheng on 14-6-3.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "GoodsCategory.h"

@implementation GoodsCategory

- (id) init
{
	if((self = [super init]))
    {
        self.goodsCategoryArray = [[NSMutableArray alloc]init];
        
        self.imagefram = CGRectMake(5.0f, 0.0f, 90.0f, 90.0f);
        self.namefram = CGRectMake(105.0f, 20.0f, 200.0f, 20.0f);
        self.nameColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.isHiddenNextCategoryName = NO;
        self.isHiddenIndicator = YES;
        self.isHiddenLineView = NO;
	}
	return self;
}

@end
