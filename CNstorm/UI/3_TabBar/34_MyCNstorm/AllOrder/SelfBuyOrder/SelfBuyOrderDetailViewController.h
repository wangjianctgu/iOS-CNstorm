//
//  SelfBuyOrderDetailViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-14.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"

#import "SelfBuyOrder.h"
#import "AllOrderDetailHeaderView.h"
#import "SelfBuyOrderDetailTableViewCell.h"

#import "ExpressShowViewController.h"
#import "MJNavigationController.h"
#import "ExpressAddViewController.h"

@interface SelfBuyOrderDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,ExpressAddViewControllerDelegate>

@property (nonatomic, strong) SelfBuyOrder *selfBuyOrder;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *goodsListTableView;

@property (nonatomic, readwrite) float scrollViewHeight;

@end
