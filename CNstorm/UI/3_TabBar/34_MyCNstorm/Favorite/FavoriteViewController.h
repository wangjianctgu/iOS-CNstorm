//
//  FavoriteViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"

//上拉下拉刷新
#import "MJRefresh.h"

//接口
#import "ASIRequestImport.h"

#import "Favorite.h"

#import "FavoriteTableViewCell.h"

#import "Customer.h"

#import "GoodsDetailViewController.h"


@interface FavoriteViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *favoriteTableView;

@property (nonatomic, strong) NSMutableArray *favoriteList;


@end
