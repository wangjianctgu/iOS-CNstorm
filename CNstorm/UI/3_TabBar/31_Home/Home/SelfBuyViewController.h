//
//  SelfBuyViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-22.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"

#import "LoginViewController.h"
#import "MJNavigationController.h"
#import "UrlGoodsDetailViewController.h"

#import "Goods.h"
#import "StoreGoods.h"
#import "Cart.h"

#import "SelfBuyCartTableViewCell.h"
#import "SelfBuyTableViewHeaderView.h"
#import "SelfBuyComViewController.h"

#import "ZSYPopoverListView.h"
#import "ZSYPopoverView.h"

@interface SelfBuyViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,LoginViewControllerDelegate>

@property (nonatomic, strong) UIView *segmentedControlView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

//scrollView
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextView *urlTextView;
@property (nonatomic, strong) UIButton *commitButton;
//cart
@property (nonatomic, strong) UIView *myView;
@property (nonatomic, strong) UIView *tView;
@property (nonatomic, strong) UIView *nullView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UILabel *totalCostLabel;
@property (nonatomic, strong) Cart *cart;

@end
