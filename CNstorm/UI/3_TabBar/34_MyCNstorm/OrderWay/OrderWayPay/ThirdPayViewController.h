//
//  ThirdPayViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KxMenu.h"
#import "UIdefine.h"
#import "ASIRequestImport.h"

#import "MBProgressHUD+Add.h"
#import "PayComViewController.h"
#import "Customer.h"

//PayPal
#import "PayPalMobile.h"

//支付宝
#import "AlixLibService.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"


@interface ThirdPayViewController : UIViewController <PayPalPaymentDelegate>

@property (nonatomic, readwrite) int payType;
@property (nonatomic, readwrite) int type;//第三方付款名称

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) UIView *paypalView;
@property (nonatomic, strong) UIView *alipayView;
@property (nonatomic, strong) UIView *creditView;

@property (nonatomic, readwrite) double totalCost;
@property (nonatomic, strong) NSString *idsStr;

@property (nonatomic, readwrite) double palTotalCost;
@property (nonatomic, readwrite) double aliTotalCost;

@property (nonatomic, readwrite) double payRate;
//----------------------------------------------------------//
//payPal
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) NSString *resultText;

//支付宝
@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。
@property(nonatomic, strong) NSString *aliName;
@property(nonatomic, strong) NSString *aliInfo;
@property(nonatomic, strong) NSString *aliPrice;

- (void)thirdPayWebService;
- (void)thirdRechargeWebService;

+ (id)shareInstance;

@end
