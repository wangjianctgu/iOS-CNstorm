//
//  ForgetPasswordViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-30.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "UIdefine.h"

#import "ASIRequestImport.h"

@class ForgetPasswordViewController;

@protocol ForgetPasswordViewControllerDelegate <NSObject>

@optional

- (void)didFinishedModifyPasswordSuccess:(MBProgressHUD *) hud;

@end


@interface ForgetPasswordViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, assign) id<ForgetPasswordViewControllerDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UIButton *resetButton;

@end
