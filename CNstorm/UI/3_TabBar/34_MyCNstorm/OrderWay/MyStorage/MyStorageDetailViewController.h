//
//  MyStorageDetailViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-17.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIDefine.h"

#import "BuyPackage.h"
#import "SelfPackage.h"
#import "Package.h"
#import "MyLabel.h"

#import "MyStorageDetailTableViewCell.h"

@interface MyStorageDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Package *package;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *goodsListTableView;

@property (nonatomic, readwrite) float scrollViewHeight;

@end
