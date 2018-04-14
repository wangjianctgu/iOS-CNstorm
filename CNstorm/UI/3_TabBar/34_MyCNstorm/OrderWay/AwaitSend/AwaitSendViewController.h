//
//  AwaitSendViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-16.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"

//上拉下拉刷新
#import "MJRefresh.h"

//orderTableView
#import "AwaitSendOrderTableViewCell.h"
#import "AwaitSendOrderViewTableViewHeaderView.h"
#import "AwaitSendOrderDetailViewController.h"

//wayTableView
#import "AllWayTableViewCell.h"
#import "AwaitSendWayTableViewCell.h"
#import "AwaitSendWayDetailViewController.h"
#import "AllWayDetailViewController.h"

//接口
#import "ASIRequestImport.h"
#import "Customer.h"

//待发货 代购订单、国际运单
@interface AwaitSendViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *orderTableView;
@property (nonatomic, strong) NSMutableArray *orderList;

@property (nonatomic, readwrite) int downUp;
@property (nonatomic, readwrite) int value;

@property (nonatomic, strong) UITableView *wayTableView;
@property (nonatomic, strong) NSMutableArray *wayList;

@property (nonatomic, readwrite) int downUp2;
@property (nonatomic, readwrite) int value2;

@property (nonatomic, strong) UIAlertView *orderAlertView;
@property (nonatomic, strong) UIAlertView *wayAlertView;

@end
