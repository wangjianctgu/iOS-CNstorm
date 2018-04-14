//
//  AwaitSendOrderDetailViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-16.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "ReplaceBuyOrder.h"
#import "AllOrderDetailHeaderView.h"
#import "AwaitSendOrderDetailTableViewCell.h"

#import "ExpressShowViewController.h"
#import "MJNavigationController.h"

@interface AwaitSendOrderDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ReplaceBuyOrder *replaceBuyOrder;


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *goodsListTableView;

@property (nonatomic, readwrite) float scrollViewHeight;

@end
