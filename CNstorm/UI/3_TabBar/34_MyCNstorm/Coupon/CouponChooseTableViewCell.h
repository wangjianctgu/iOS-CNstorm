//
//  CouponChooseTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-27.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Coupon.h"

@interface CouponChooseTableViewCell : UITableViewCell

@property (nonatomic, strong) Coupon *coupon;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UILabel *addEndTimeLabel;//有效期

@property (nonatomic, strong) UILabel *yLabel;

@property (nonatomic, strong) UILabel *moneyLabel;//优惠面值

@property (nonatomic, strong) UILabel *sellmoneyLabel;//满足销售价格使用

@property (nonatomic, strong) UILabel *stateLabel;//是否使用

@end
