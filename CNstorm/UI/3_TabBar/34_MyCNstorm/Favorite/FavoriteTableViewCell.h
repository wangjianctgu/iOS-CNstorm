//
//  FavoriteTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

//图片下载并显示
#import "UIImageView+MJWebCache.h"

#import "Favorite.h"

@interface FavoriteTableViewCell : UITableViewCell

@property (nonatomic, strong) Favorite *favorite;

@property (nonatomic, strong) UIImageView *goodsImageView;

@property (nonatomic, strong) UILabel *goodsNameLabel;

@property (nonatomic, strong) UILabel *goodspriceLabel;

@property (nonatomic, strong) UILabel *modelLabel;

@end
