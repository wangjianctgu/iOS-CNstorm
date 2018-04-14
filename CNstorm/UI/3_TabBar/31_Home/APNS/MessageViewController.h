//
//  MessageViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-18.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "MJRefresh.h"
#import "ASIRequestImport.h"
#import "Customer.h"
#import "BadgeKeyValue.h"

#import "SysTableViewCell.h"
#import "DealTableViewCell.h"
#import "AskTableViewCell.h"

#import "SysMessageDetailViewController.h"

@interface MessageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *sysView;
@property (nonatomic, strong) UIView *dealView;
@property (nonatomic, strong) UIView *askView;

@property (nonatomic, strong) UITableView *sysTableView;
@property (nonatomic, strong) UITableView *dealTableView;
@property (nonatomic, strong) UITableView *askTableView;

@property (nonatomic, strong) UIView *sysNullView;
@property (nonatomic, strong) UIView *dealNullView;
@property (nonatomic, strong) UIView *askNullView;

@property (nonatomic, strong) NSMutableArray *sysMessageList;
@property (nonatomic, strong) NSMutableArray *dealMessageList;
@property (nonatomic, strong) NSMutableArray *askMessageList;

@property (nonatomic, readwrite) int index;//推送消息需要用到锁定那一段

@property (nonatomic, readwrite) int downUp;
@property (nonatomic, readwrite) int value;

@property (nonatomic, readwrite) int downUp2;
@property (nonatomic, readwrite) int value2;

@property (nonatomic, readwrite) int downUp3;
@property (nonatomic, readwrite) int value3;

@end
