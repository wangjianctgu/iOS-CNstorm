//
//  HomeViewController.h
//  CNstormUI
//
//  Created by EBS1 on 14-3-31.
//  Copyright (c) 2014年 CNstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewController.h"

#import "Reachability.h"
#import "UIdefine.h"

//上拉下拉刷新
#import "MJRefresh.h"

//图片轮播
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#import "MessageViewController.h"
#import "ToolboxViewController.h"
#import "SearchViewController.h"
#import "GoodsListTableViewCell.h"
#import "GoodsDetailViewController.h"
#import "SpecialViewController.h"

#import "ReplaceBuyViewController.h"
#import "SelfBuyViewController.h"
#import "TransportViewController.h"
#import "MyStorageViewController.h"
#import "EvaluationViewController.h"

#import "LoginViewController.h"
#import "MJNavigationController.h"

//圆角数字
#import "UIBarButtonItem+Badge.h"

@class HomeViewController;

@protocol HomeViewControllerDelegate <NSObject>

@optional

- (void)didFinishedOpenDrawer:(HomeViewController *) homeViewController;

- (void)didFinishedHideTabBar:(BOOL) hidden;

@end

@interface HomeViewController : UIViewController <UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate,LoginViewControllerDelegate>

@property (nonatomic, assign) id <HomeViewControllerDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;

//图片轮播
@property (nonatomic, strong) UIScrollView *scrollImageView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *urlArray;
@property (nonatomic, strong) NSMutableArray *placeholderArray;

//TableView 首页商品列表
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *goodsList;

//下拉/分类id
@property (nonatomic, readwrite) int downUp;
@property (nonatomic, readwrite) int value;
@property (nonatomic, readwrite) long long categoryId;

//登录类型
@property (nonatomic, readwrite) int loginType;

@end
