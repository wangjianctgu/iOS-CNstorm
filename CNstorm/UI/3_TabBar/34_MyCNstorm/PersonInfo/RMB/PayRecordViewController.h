//
//  PayRecordViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-25.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "ASIRequestImport.h"
#import "Customer.h"

//导航栏选择消费类型
#import "DropDownListView.h"
#import "DropDownChooseProtocol.h"

//上拉下拉刷新
#import "MJRefresh.h"

#import "PayRecordDetailViewController.h"
#import "PayRecordTableViewCell.h"

@interface PayRecordViewController : UIViewController <DropDownChooseDelegate,DropDownChooseDataSource,UITableViewDataSource, UITableViewDelegate>

//导航栏选择订单部分
@property (nonatomic, readwrite) NSInteger defaultSelectedRow;
@property (nonatomic, strong) NSMutableArray *chooseArray;

@property (nonatomic, strong) UITableView *allPayRecordTableView;
@property (nonatomic, strong) NSMutableArray *allPayRecordList;

@property (nonatomic, readwrite) int scope;
@property (nonatomic, readwrite) int downUp;
@property (nonatomic, readwrite) int value;

@end
