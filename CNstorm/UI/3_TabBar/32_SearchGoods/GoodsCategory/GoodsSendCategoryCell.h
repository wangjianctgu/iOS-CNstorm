//
//  GoodsSendCategoryCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-11.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+MJWebCache.h"//图片下载并显示
#import "InfiniteTreeBaseCell.h"
#import "GoodsCategory.h"

@interface GoodsSendCategoryCell : InfiniteTreeBaseCell

@property (nonatomic, strong) GoodsCategory *goodsCategory;

@property (nonatomic, strong) UIImageView *goodsCategoryImageView;

@property (nonatomic, strong) UILabel *goodsCategoryNameLabel;

@property (nonatomic, strong) UIView *lineView;


@end
