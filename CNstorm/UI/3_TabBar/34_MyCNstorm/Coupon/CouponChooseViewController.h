//
//  CouponChooseViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-27.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"

//上拉下拉刷新
#import "MJRefresh.h"

//接口
#import "ASIRequestImport.h"

#import "Coupon.h"

#import "CouponChooseTableViewCell.h"

#import "Customer.h"

@class CouponChooseViewController;
@protocol CouponChooseViewControllerDelegate <NSObject>

@optional
- (void)didFinishedReturnCoupon:(Coupon *)selectedCoupon;

@end

@interface CouponChooseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id<CouponChooseViewControllerDelegate> delegate;

@property (nonatomic, strong) UITableView *couponTableView;

@property (nonatomic, strong) NSMutableArray *couponList;

@end
