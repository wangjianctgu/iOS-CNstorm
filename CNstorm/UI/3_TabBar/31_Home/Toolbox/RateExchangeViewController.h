//
//  RateExchangeViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "ASIRequestImport.h"
#import "Customer.h"

@interface RateExchangeViewController : UIViewController

@property (nonatomic, readwrite) int rateDirection;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *ownTypeLabel;
@property (nonatomic, strong) UILabel *exchangeLabel;
@property (nonatomic, strong) UILabel *rateLabel;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label3;

@end
