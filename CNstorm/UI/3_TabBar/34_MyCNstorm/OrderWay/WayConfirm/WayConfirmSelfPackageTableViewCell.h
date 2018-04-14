//
//  WayConfirmSelfPackageTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelfPackage.h"
#import "MyLabel.h"

@interface WayConfirmSelfPackageTableViewCell : UITableViewCell

@property (nonatomic, strong) SelfPackage *selfPackage;

@property (nonatomic, strong) UILabel *packageTitelLabel;
@property (nonatomic, strong) MyLabel *packageRemarkLabel;//订单的备注
@property (nonatomic, strong) UILabel *packageWeightLabel;

@end
