//
//  AwaitPayOrderDetailViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-10.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "ReplaceBuyOrder.h"
#import "AllOrderDetailHeaderView.h"
#import "AwaitPayOrderDetailTableViewCell.h"
#import "OrderPayViewController.h"

#import "ExpressShowViewController.h"
#import "MJNavigationController.h"

@interface AwaitPayOrderDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ReplaceBuyOrder *replaceBuyOrder;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *goodsListTableView;

@property (nonatomic, readwrite) float scrollViewHeight;

@end
