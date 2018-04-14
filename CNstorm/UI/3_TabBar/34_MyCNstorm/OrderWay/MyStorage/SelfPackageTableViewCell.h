//
//  SelfPackageTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-17.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyLabel.h"

#import "SelfPackage.h"

@interface SelfPackageTableViewCell : UITableViewCell

@property (nonatomic, strong) SelfPackage *selfPackage;

@property (nonatomic, strong) UIButton *isSensitiveButton;

@property (nonatomic, strong) UIButton *isSelectedButton;

@property (nonatomic, strong) UILabel *packageTitelLabel;

@property (nonatomic, strong) MyLabel *packageRemarkLabel;//订单的备注

@property (nonatomic, strong) UILabel *packageWeightLabel;

@property (nonatomic, strong) UIButton *detailButton;

@end
