//
//  TransportViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-22.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "ASIRequestImport.h"
#import "Customer.h"
#import "Express.h"

#import "LoginViewController.h"
#import "MJNavigationController.h"

#import "CPTextViewPlaceholder.h"
#import "ExpressViewController.h"

//我要代寄页面
@interface TransportViewController : UIViewController <UITextViewDelegate,UITextFieldDelegate,ExpressViewControllerDelegate,LoginViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *expressesLabel;
@property (nonatomic, strong) UITextField *expressesNoTextField;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) CPTextViewPlaceholder *remarkTextView;
@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, strong) Express *selectedExpress;


@end
