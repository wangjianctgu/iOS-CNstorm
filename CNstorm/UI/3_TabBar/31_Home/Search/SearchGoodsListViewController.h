//
//  SearchGoodsListViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-11.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

//上拉下拉刷新
#import "MJRefresh.h"
#import "UIdefine.h"
#import "ASIRequestImport.h"

#import "GoodsListTableViewCell.h"
#import "GoodsDetailViewController.h"

@interface SearchGoodsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;//商品列表tableView
@property (nonatomic, strong) NSMutableArray *goodsList;

@property (nonatomic, strong) NSString *keyWord;
@property (nonatomic, readwrite) int downUp;
@property (nonatomic, readwrite) int value;

@end
