//
//  EvaluationViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

//上拉下拉刷新
#import "MJRefresh.h"
#import "UIdefine.h"
#import "ASIRequestImport.h"
#import "EvaluationTableViewCell.h"

@interface EvaluationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *evaluationList;

@property (nonatomic, readwrite) int downUp;
@property (nonatomic, readwrite) int value;


@end
