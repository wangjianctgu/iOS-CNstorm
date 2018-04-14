//
//  WayPayViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "ASIRequestImport.h"
#import "Customer.h"

#import "RechargeViewController.h"
#import "ThirdPayViewController.h"
#import "PayComViewController.h"

@interface WayPayViewController : UIViewController

@property (nonatomic, readwrite) int inputType;//进入方式

@property (nonatomic, strong) NSString *wayIdStr;
@property (nonatomic, readwrite) float wayTotalCost;
@property (nonatomic, readwrite) double yuer;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *yuerInfoLabel;
@property (nonatomic, strong) UIButton *yuerButton;
@property (nonatomic, strong) UIButton *thirdPayButton;

@property (nonatomic, strong) UIAlertView *rechargeAlertView;
@property (nonatomic, strong) UIAlertView *yuerPayAlertView;

@end
