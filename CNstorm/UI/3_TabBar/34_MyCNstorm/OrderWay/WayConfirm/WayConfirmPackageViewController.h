//
//  WayConfirmPackageViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIDefine.h"

#import "WayConfirmBuyPackageTableViewCell.h"
#import "WayConfirmSelfPackageTableViewCell.h"
#import "AllOrderDetailHeaderView.h"
#import "Way.h"
#import "BuyPackage.h"

@interface WayConfirmPackageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) Way *way;


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *goodsListTableView;

@property (nonatomic, readwrite) float scrollViewHeight;

@end
