//
//  BuyPackageTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-18.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyLabel.h"

#import "BuyPackage.h"

@interface BuyPackageTableViewCell : UITableViewCell

@property (nonatomic, strong) BuyPackage *buyPackage;

@property (nonatomic, strong) UIButton *isSensitiveButton;

@property (nonatomic, strong) UIButton *isSelectedButton;

@property (nonatomic, strong) MyLabel *packageTitelLabel;

@property (nonatomic, strong) MyLabel *packageGoodTypeCountLabel;//订单的商品个数

@property (nonatomic, strong) UILabel *packageWeightLabel;

@property (nonatomic, strong) UIButton *detailButton;


@end
