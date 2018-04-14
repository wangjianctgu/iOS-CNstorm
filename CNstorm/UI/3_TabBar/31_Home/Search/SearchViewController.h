//
//  SearchViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-8.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
//搜索拼音匹配
#import "ChineseInclude.h"
#import "PinYinForObjc.h"

#import "SearchTableViewCell.h"
#import "SearchTableViewFooterView.h"
#import "SearchGoodsListViewController.h"

@interface SearchViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

//搜索部分
@property (nonatomic, strong) UITableView *searchHistoryTableView;
@property (nonatomic, strong) UITableView *searchResultsTableView;
@property (nonatomic, strong) UISearchBar *mySearchBar;
@property (nonatomic, strong) NSMutableArray *seachHistoryArray;
@property (nonatomic, strong) NSMutableArray *searchResultArray;

@end
