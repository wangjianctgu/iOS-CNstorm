//
//  AllWayViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-16.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "ASIRequestImport.h"
#import "Customer.h"
#import "BadgeKeyValue.h"

//上拉下拉刷新
#import "MJRefresh.h"

#import "AllWayDetailViewController.h"
#import "AllWayTableViewCell.h"
#import "WayPayViewController.h"

#import "Package.h"
#import "BuyPackage.h"
#import "SelfPackage.h"
#import "Goods.h"

@interface AllWayViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *allWayTableView;
@property (nonatomic, strong) NSMutableArray *allWayList;

@property (nonatomic, readwrite) int downUp;
@property (nonatomic, readwrite) int value;

@end
