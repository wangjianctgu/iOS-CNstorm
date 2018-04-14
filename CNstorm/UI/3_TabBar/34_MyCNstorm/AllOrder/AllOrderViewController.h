//
//  AllOrderViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-13.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"

//导航栏选择订单部分
#import "DropDownListView.h"
#import "DropDownChooseProtocol.h"

//上拉下拉刷新
#import "MJRefresh.h"

//代购、自助购、国际转运TableViewCell
#import "ReplaceBuyOrder.h"
#import "ReplaceBuyOrderTableViewCell.h"
#import "ReplaceBuyOrderTableViewHeaderView.h"

#import "SelfBuyOrder.h"
#import "SelfBuyOrderTableViewCell.h"
#import "SelfBuyOrderTableViewHeaderView.h"

#import "TransportOrder.h"
#import "TransportOrderTableViewCell.h"

#import "Goods.h"
#import "Customer.h"

//二级页面视图
#import "replaceBuyOrderDetailViewController.h"
#import "SelfBuyOrderDetailViewController.h"
#import "TransportOrderDetailViewController.h"
#import "OrderPayViewController.h"

//接口
#import "ASIRequestImport.h"

@interface AllOrderViewController : UIViewController <DropDownChooseDelegate,DropDownChooseDataSource,UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>

//导航栏选择订单部分
@property (nonatomic, readwrite) NSInteger defaultSelectedRow;
@property (nonatomic, strong) NSMutableArray *chooseArray;

//订单TableView:代购订单、自助购订单、代寄订单（不需要付款）
//状态:待付款、待发货、待接收
@property (nonatomic, strong) UITableView *replaceBuyOrderTableView;
@property (nonatomic, strong) UITableView *selfBuyOrderTableView;
@property (nonatomic, strong) UITableView *transportOrderTableView;

//订单:代购订单、自助购订单、代寄订单列表数据
@property (nonatomic, strong) NSMutableArray *replaceBuyOrderList;
@property (nonatomic, strong) NSMutableArray *selfBuyOrderList;
@property (nonatomic, strong) NSMutableArray *transportOrderList;

@property (nonatomic, strong) UIAlertView *rOrderAlertView;
@property (nonatomic, strong) UIAlertView *sOrderAlertView;
@property (nonatomic, strong) UIAlertView *tOrderAlertView;

@property (nonatomic, readwrite) int downUp;
@property (nonatomic, readwrite) int value;
@property (nonatomic, readwrite) int downUp2;
@property (nonatomic, readwrite) int value2;
@property (nonatomic, readwrite) int downUp3;
@property (nonatomic, readwrite) int value3;

@end
