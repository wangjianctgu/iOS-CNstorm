//
//  AwaitPayViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-9.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"

//上拉下拉刷新
#import "MJRefresh.h"

//orderTableView
#import "AwaitPayOrderTableViewCell.h"
#import "AwaitPayOrderTableViewHeaderView.h"
#import "AwaitPayOrderDetailViewController.h"
#import "OrderPayViewController.h"

//wayTableView
#import "AllWayTableViewCell.h"
#import "AwaitPayWayTableViewCell.h"
#import "AwaitPayWayDetailViewController.h"
#import "WayPayViewController.h"

//接口
#import "ASIRequestImport.h"

#import "Customer.h"
#import "Package.h"
#import "BuyPackage.h"
#import "SelfPackage.h"

@interface AwaitPayViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

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
