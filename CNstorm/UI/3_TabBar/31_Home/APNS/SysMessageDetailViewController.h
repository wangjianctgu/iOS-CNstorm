//
//  SysMessageDetailViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "ASIRequestImport.h"
#import "Customer.h"

#import "CPTextViewPlaceholder.h"
#import "SysMessage.h"

@interface SysMessageDetailViewController : UIViewController

@property (nonatomic, strong) SysMessage *sysMessage;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) CPTextViewPlaceholder *textView;

@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, readwrite) int mid;

@end
