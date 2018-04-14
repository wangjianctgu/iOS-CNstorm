//
//  AddressChooseViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-23.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
//上拉下拉刷新
#import "MJRefresh.h"
//接口
#import "ASIRequestImport.h"

#import "AddressChooseTableViewCell.h"

#import "AddressManageViewController.h"

#import "Customer.h"

@class AddressChooseViewController;

@protocol AddressChooseViewControllerDelegate <NSObject>

@optional
- (void)didFinishedReturnChoose:(AddressChooseViewController *)addressChooseViewController;

@end

@interface AddressChooseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id<AddressChooseViewControllerDelegate> delegate;

//收货地址信息 TableView
@property (nonatomic, strong) UITableView *addressTableView;

//收货地址信息 List
@property (nonatomic, strong) NSMutableArray *addressList;

@end
