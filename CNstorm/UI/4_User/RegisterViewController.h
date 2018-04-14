//
//  RegisterViewController.h
//  LoginTest
//
//  Created by EBS1 on 14-3-17.
//  Copyright (c) 2014年 Foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "ZJSwitch.h"

//接口.h
#import "ASIRequestImport.h"

@class RegisterViewController;

@protocol RegisterViewControllerDelegate <NSObject>

@optional

- (void)didFinishedRegisterSuccess:(RegisterViewController *) registerViewController andHud:(MBProgressHUD *)hud;

@end

@interface RegisterViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, assign) id<RegisterViewControllerDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextField *emailTextField;

@property (nonatomic, strong) UITextField *userNameTextField;//昵称

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) UIButton *agreeButton;

@property (nonatomic, strong) UILabel *agreeLabel;

@property (nonatomic, readwrite) int registerType;//0表示CNstorm注册 1QQ、Weibo注册
//QQ、Weibo注册
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *tname;
@property (nonatomic, strong) NSString *image;


@end
