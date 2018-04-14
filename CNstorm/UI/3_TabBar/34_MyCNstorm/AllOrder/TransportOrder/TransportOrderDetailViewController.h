//
//  TransportOrderDetailViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-14.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIDefine.h"
#import "MyLabel.h"
#import "TransportOrder.h"

#import "ExpressShowViewController.h"
#import "ExpressAddViewController.h"
#import "MJNavigationController.h"

@interface TransportOrderDetailViewController : UIViewController <ExpressAddViewControllerDelegate>

@property (nonatomic, strong) TransportOrder *transportOrder;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, readwrite) float scrollViewHeight;

@end
