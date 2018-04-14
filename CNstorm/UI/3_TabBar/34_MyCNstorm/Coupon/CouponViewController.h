//
//  CouponViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

//导航栏选择消费类型
#import "DropDownListView.h"
#import "DropDownChooseProtocol.h"

#import "UIdefine.h"

//上拉下拉刷新
#import "MJRefresh.h"

//接口
#import "ASIRequestImport.h"

#import "Coupon.h"

#import "CouponTableViewCell.h"

#import "Customer.h"

@interface CouponViewController : UIViewController<DropDownChooseDelegate,DropDownChooseDataSource,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, readwrite) int state;

//导航栏选择
@property (nonatomic, readwrite) NSInteger defaultSelectedRow;

@property (nonatomic, strong) NSMutableArray *chooseArray;

@property (nonatomic, strong) UITableView *couponTableView;

@property (nonatomic, strong) NSMutableArray *couponList;


@end
