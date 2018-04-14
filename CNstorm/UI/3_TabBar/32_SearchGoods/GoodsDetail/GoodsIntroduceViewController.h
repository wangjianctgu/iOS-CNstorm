//
//  GoodsIntroduceViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-21.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIdefine.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface GoodsIntroduceViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) NSMutableArray *propImageArray;

@end
