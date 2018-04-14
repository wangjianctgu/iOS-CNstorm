//
//  PayComViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KxMenu.h"
#import "UIdefine.h"

@interface PayComViewController : UIViewController

@property (nonatomic, readwrite) int payType;

@property (nonatomic, strong) UIScrollView *scrollView;

@end
