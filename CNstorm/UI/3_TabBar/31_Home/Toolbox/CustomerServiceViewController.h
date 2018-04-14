//
//  CustomerServiceViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-12-1.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "MBProgressHUD+Add.h"

@interface CustomerServiceViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end
