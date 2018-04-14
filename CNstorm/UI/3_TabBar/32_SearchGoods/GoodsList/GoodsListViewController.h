//
//  GoodsListViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-8.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

//上拉下拉刷新
#import "MJRefresh.h"
#import "UIdefine.h"
#import "ASIRequestImport.h"

#import "GoodsListTableViewCell.h"

#import "GoodsDetailViewController.h"

@class GoodsListViewController;
@protocol GoodsListViewControllerDelegate <NSObject>

@optional
- (void)didFinishedReturn:(GoodsListViewController *) goodsListViewController;

@end


//商品列表页面
@interface GoodsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id <GoodsListViewControllerDelegate> delegate;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *goodsList;

@property (nonatomic, readwrite) int downUp;
@property (nonatomic, readwrite) int value;

@property (nonatomic, readwrite) long long categoryId;
@property (nonatomic, strong) NSString *categoryName;

@end
