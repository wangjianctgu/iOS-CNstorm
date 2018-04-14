//
//  GoodsCategoryCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-4.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+MJWebCache.h"//图片下载并显示
#import "InfiniteTreeBaseCell.h"
#import "GoodsCategory.h"

@interface GoodsCategoryCell : InfiniteTreeBaseCell

@property (nonatomic, strong) GoodsCategory *goodsCategory;

@property (nonatomic, strong) UIImageView *goodsCategoryImageView;

@property (nonatomic, strong) UILabel *goodsCategoryNameLabel;

@property (nonatomic, strong) UILabel *nextCategoryNameLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIImageView *shadowImageView;

@property (nonatomic, readwrite) NSInteger sitePoint;

@end
