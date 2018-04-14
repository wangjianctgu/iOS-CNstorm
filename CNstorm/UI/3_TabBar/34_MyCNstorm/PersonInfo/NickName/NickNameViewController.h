//
//  NickNameViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-23.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "ASIRequestImport.h"
#import "Customer.h"

@interface NickNameViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextField *nickNameTextField;

@property (nonatomic, strong) UIButton *commitButton;

@end
