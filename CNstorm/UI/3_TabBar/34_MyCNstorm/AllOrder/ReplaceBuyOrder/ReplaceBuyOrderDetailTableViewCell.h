//
//  ReplaceBuyOrderDetailTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-14.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

//图片下载并显示
#import "UIImageView+MJWebCache.h"
#import "Goods.h"

@interface ReplaceBuyOrderDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) Goods *goods;

@property (nonatomic, strong) UIImageView *goodsImageView;

@property (nonatomic, strong) UILabel *goodsNameLabel;

@property (nonatomic, strong) UILabel *realPriceLabel;

@property (nonatomic, strong) UILabel *remarkInfoLabel;

@property (nonatomic, strong) UILabel *buyQuantityInfoLabel;

@property (nonatomic, strong) UILabel *sizeColorLabel;

@end
