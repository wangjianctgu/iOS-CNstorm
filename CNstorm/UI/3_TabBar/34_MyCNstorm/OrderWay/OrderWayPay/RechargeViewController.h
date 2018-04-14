//
//  RechargeViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"

#import "ThirdPayViewController.h"

@interface RechargeViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextField *rechargeTextField;

@property (nonatomic, strong) UIButton *commitButton;

@end
