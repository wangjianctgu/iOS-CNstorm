//
//  AwaitSendWayDetailViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-17.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIdefine.h"
#import "AwaitSendWayDetailTableViewCell.h"
#import "Way.h"
#import "Package.h"
#import "BuyPackage.h"

@interface AwaitSendWayDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Way *way;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *goodsListTableView;

@property (nonatomic, readwrite) float scrollViewHeight;

@end
