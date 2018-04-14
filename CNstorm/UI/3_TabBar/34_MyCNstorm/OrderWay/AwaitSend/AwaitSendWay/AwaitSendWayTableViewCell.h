//
//  AwaitSendWayTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-16.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Way.h"

@interface AwaitSendWayTableViewCell : UITableViewCell

@property (nonatomic, strong) Way *way;

@property (nonatomic, strong) UILabel *wayTitelLabel;

@property (nonatomic, strong) UIButton *isCancelButton;

@property (nonatomic, strong) UILabel *wayPackageCountLabel;//运单中订单的个数Label

@property (nonatomic, strong) UILabel *yunfeiLabel;

@property (nonatomic, strong) UILabel *yunfeiInfoLabel;

@property (nonatomic, strong) UIButton *wayStatusButton;


@end