//
//  WayConfirmViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-18.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"

//底部弹出ActionSheet
#import "AHKActionSheet.h"

#import "AddressChooseViewController.h"
#import "WayConfirmPackageViewController.h"
#import "DeliveryViewController.h"
#import "CouponChooseViewController.h"
#import "ScoreRecordUsedViewController.h"

#import "WayPayViewController.h"

#import "Way.h"
#import "Package.h"
#import "WayValue.h"

@interface WayConfirmViewController : UIViewController <UITextViewDelegate, DeliveryViewControllerDelegate,CouponChooseViewControllerDelegate,ScoreRecordUsedViewControllerDelegate,AddressChooseViewControllerDelegate,AddressAddViewControllerDelegate>

//收货地址信息List
@property (nonatomic, strong) NSMutableArray *addressList;

@property (nonatomic, strong) Way *way;
@property (nonatomic, strong) WayValue *wayVaue;
@property (nonatomic, readwrite) int isSensitive;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, readwrite) float scrollViewHeight;

@property (nonatomic, strong) UIView *receviceAddressView;
@property (nonatomic, strong) UILabel *transportTypeLabel;
@property (nonatomic, strong) UITextView *remarkTextView;
@property (nonatomic, strong) UIButton *couponButton;
@property (nonatomic, strong) UILabel *couponLabel;
@property (nonatomic, strong) UIButton *scoreButton;
@property (nonatomic, strong) UILabel *scoreLabel;

//自选服务
@property (nonatomic, strong) UILabel *packagingValueLabel;
@property (nonatomic, strong) UILabel *orderDealValueLabel;
@property (nonatomic, strong) UILabel *packageMaterialValueLabel;
@property (nonatomic, strong) UILabel *valueServiceValueLabel;

//费用
@property (nonatomic, strong) UILabel *yunfeiInfoLabel;
@property (nonatomic, strong) UILabel *tariffInfoLabel;
@property (nonatomic, strong) UILabel *serviceInfoLabel;
@property (nonatomic, strong) UILabel *preferentialInfoLabel;
@property (nonatomic, strong) UILabel *allCostInfoLabel;

@end
