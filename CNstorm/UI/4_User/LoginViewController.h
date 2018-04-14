//
//  LoginViewController.h
//  LoginTest
//
//  Created by EBS1 on 14-3-17.
//  Copyright (c) 2014年 Foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

//数据库
#import "DataBaseInfo.h"
#import "SqliteHelper.h"
#import "Customer.h"
#import "BadgeKeyValue.h"

#import "UIdefine.h"
#import "ASIRequestImport.h"
#import "ZJSwitch.h"

#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"

#import <ShareSDK/ShareSDK.h>

@class LoginViewController;

@protocol LoginViewControllerDelegate <NSObject>

@optional

- (void)didFinishedLogin:(LoginViewController *)loginViewController andHud:(MBProgressHUD *)hud;

- (void)didFinishedCancel:(LoginViewController *) loginViewController;

@end

@interface LoginViewController : UIViewController <UITextFieldDelegate,RegisterViewControllerDelegate,ForgetPasswordViewControllerDelegate>

@property (nonatomic, assign) id<LoginViewControllerDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextField *nameTextField;//Email/用户名

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *loginButton;

//QQ、Weibo注册
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *tname;
@property (nonatomic, strong) NSString *image;

@end
