//
//  CostimatingTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-31.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

//图片下载并显示
#import "UIImageView+MJWebCache.h"

#import "Costimating.h"

@interface CostimatingTableViewCell : UITableViewCell

@property (nonatomic, strong) Costimating *costimating;

@property (nonatomic, strong) UIImageView *carrierLogoImageView;

@property (nonatomic, strong) UILabel *customsFeeLabel;

@property (nonatomic, strong) UILabel *deliveryNameLabel;

@property (nonatomic, strong) UILabel *deliveryTimeLabel;

@property (nonatomic, strong) UILabel *freightLabel;

@property (nonatomic, strong) UILabel *servefeeLabel;

@property (nonatomic, strong) UILabel *totalLabel;

@end
