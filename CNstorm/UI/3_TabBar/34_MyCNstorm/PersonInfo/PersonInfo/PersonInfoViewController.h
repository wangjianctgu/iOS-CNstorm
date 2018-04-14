//
//  PersonInfoViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-12.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"

#import "MyCNstormTableViewCell.h"
#import "MySection.h"
#import "MyRow.h"
#import "Customer.h"

#import "RMBAccountViewController.h"
#import "PayRecordViewController.h"
#import "AddressManageViewController.h"
#import "NickNameViewController.h"
#import "UpdatePswViewController.h"

@interface PersonInfoViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *sectionArray;

@end
