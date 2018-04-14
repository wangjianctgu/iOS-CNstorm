//
//  AddressManageViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
//上拉下拉刷新
#import "MJRefresh.h"
//接口
#import "ASIRequestImport.h"

#import "AddressTableViewCell.h"

#import "AddressUpdateViewController.h"

#import "AddressAddViewController.h"

#import "Customer.h"

//收货地址信息管理页面
@interface AddressManageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,AddressAddViewControllerDelegate,AddressUpdateViewControllerDelegate>

//收货地址信息 TableView
@property (nonatomic, strong) UITableView *addressTableView;

//收货地址信息 List
@property (nonatomic, strong) NSMutableArray *addressList;

@end
