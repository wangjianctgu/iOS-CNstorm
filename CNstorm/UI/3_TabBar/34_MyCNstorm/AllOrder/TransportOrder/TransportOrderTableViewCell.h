//
//  TransportOrderTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-14.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TransportOrder.h"
#import "MyLabel.h"

@interface TransportOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) TransportOrder *transportOrder;

@property (nonatomic, strong) UILabel *orderTitleLabel;//订单标题Label

@property (nonatomic, strong) MyLabel *orderRemarkLabel;//订单商品种类Label

@property (nonatomic, strong) UIButton *orderStatusButton;//订单状态Button

@property (nonatomic, strong) UIButton *isCancelButton;

@end
