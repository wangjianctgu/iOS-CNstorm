//
//  CostimatingListViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-30.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"

#import "CostimatingTableViewCell.h"
#import "CostimatingHeaderView.h"

@interface CostimatingListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *costimatingList;

@end
