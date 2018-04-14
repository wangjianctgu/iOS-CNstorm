//
//  MyStorageViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-16.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIDefine.h"
#import "MJRefresh.h"
#import "ASIRequestImport.h"
#import "BadgeKeyValue.h"

#import "BuyPackageTableViewCell.h"
#import "SelfPackageTableViewCell.h"
#import "MyStorageDetailViewController.h"
#import "WayConfirmViewController.h"

#import "Goods.h"
#import "Package.h"
#import "BuyPackage.h"
#import "SelfPackage.h"

@interface MyStorageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

//订单 tableView
@property (nonatomic, strong) UITableView *packageTableView;

//订单列表
@property (nonatomic, strong) NSMutableArray *packageList;

@property (nonatomic, readwrite) BOOL isAllSelected;
@property (nonatomic, strong) UIButton *allSelectedButton;

@property (nonatomic, readwrite) float totalWeight;
@property (nonatomic, strong) UILabel *totalWeightLabel;

@property (nonatomic, readwrite) int downUp;
@property (nonatomic, readwrite) int value;

@end
