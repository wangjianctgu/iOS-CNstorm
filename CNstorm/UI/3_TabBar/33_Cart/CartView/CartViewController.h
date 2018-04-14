//
//  CartViewController.h
//  CNstormUI
//
//  Created by EBS1 on 14-3-31.
//  Copyright (c) 2014年 CNstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"

#import "LoginViewController.h"
#import "MJNavigationController.h"

#import "Goods.h"
#import "StoreGoods.h"
#import "Cart.h"

#import "CartTableViewCell.h"
#import "OrderPayViewController.h"
#import "TableViewHeaderView.h"

#import "ZSYPopoverListView.h"
#import "ZSYPopoverView.h"

@interface CartViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate,LoginViewControllerDelegate,OrderPayViewControllerDelegate>

@property (nonatomic, strong) UIView *myView;
@property (nonatomic, strong) UIView *nullView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UILabel *totalCostLabel;
@property (nonatomic, strong) Cart *cart;

@end
