//
//  ExpressShowViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "MBProgressHUD+Add.h"

@interface ExpressShowViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end
