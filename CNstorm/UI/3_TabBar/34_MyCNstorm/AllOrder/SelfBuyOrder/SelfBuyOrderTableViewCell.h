//
//  SelfBuyOrderTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-14.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

//图片下载并显示
#import "UIImageView+MJWebCache.h"
#import "SelfBuyOrder.h"

@interface SelfBuyOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) SelfBuyOrder *selfBuyOrder;

@property (nonatomic, strong) UIImageView *orderImageView;//订单图像ImageView

@property (nonatomic, strong) UILabel *orderTitleLabel;//订单标题Label

@property (nonatomic, strong) UILabel *orderGoodTypeCountLabel;//订单商品种类Label

@property (nonatomic, strong) UILabel *orderAllCostLabel;//订单总计Label

@property (nonatomic, strong) UIButton *orderStatusButton;//订单状态Button


@end
