//
//  ReplaceBuyViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-22.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "UrlGoodsDetailViewController.h"

@interface ReplaceBuyViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextView *urlTextView;

@property (nonatomic, strong) UIButton *commitButton;

@end
