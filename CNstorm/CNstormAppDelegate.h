//
//  CNstormAppDelegate.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-4-10.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GuideViewController.h"
#import "OpeningViewController.h"
#import "TabBarViewController.h"
#import "ICSDrawerController.h"
#import "ViewController.h"

#import "MBProgressHUD+Add.h"
#import "MyAlertView.h"

//Sqlite
#import "CheckSqlite.h"
#import "ToolMethod.h"
#import "DataBaseInfo.h"
#import "City.h"
#import "Site.h"
#import "ViewSpot.h"

//第三方支付
#import "ThirdPayViewController.h"
//paypal付款充值
#import "PayPalMobile.h"
#import <ShareSDK/ShareSDK.h>
//支付宝
#import "AlixPayResult.h"
#import "DataVerifier.h"


//App Delegate
@interface CNstormAppDelegate : UIResponder <UIApplicationDelegate, GuideViewControllerDelegate, OpeningViewDelegate, SqliteHelperDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) OpeningViewController *openingViewController;
@property (nonatomic, strong) TabBarViewController *tabBarViewController;
//百度云推送
@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *channelId;
@property (strong, nonatomic) NSString *userId;

@end
