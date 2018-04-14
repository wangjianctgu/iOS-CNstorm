//
//  OrderPayViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-29.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KxMenu.h"
#import "UIdefine.h"
#import "ASIRequestImport.h"
#import "Customer.h"

#import "RechargeViewController.h"
#import "ThirdPayViewController.h"
#import "PayComViewController.h"

@class OrderPayViewController;

@protocol OrderPayViewControllerDelegate <NSObject>

@optional

- (void)didFinishedToBeforeHideTabBar:(BOOL) hidden;

@end


@interface OrderPayViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, assign) id<OrderPayViewControllerDelegate> delegate;

@property (nonatomic, strong) NSString *orderIdsStr;
@property (nonatomic, readwrite) float orderTotalCost;
@property (nonatomic, readwrite) double yuer;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *yuerInfoLabel;
@property (nonatomic, strong) UIButton *yuerButton;
@property (nonatomic, strong) UIButton *thirdPayButton;

@property (nonatomic, strong) UIAlertView *rechargeAlertView;
@property (nonatomic, strong) UIAlertView *yuerPayAlertView;

@end
