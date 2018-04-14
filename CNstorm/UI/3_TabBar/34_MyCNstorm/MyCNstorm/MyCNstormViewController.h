//
//  MyCNstormViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-4-11.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginViewController.h"

#import "MJNavigationController.h"

//第二级页面
#import "SetViewController.h"
#import "PersonInfoViewController.h"
#import "AwaitPayViewController.h"
#import "AwaitSendViewController.h"
#import "AwaitReceiveViewController.h"
#import "MyStorageViewController.h"
#import "AllOrderViewController.h"
#import "AllWayViewController.h"
#import "FavoriteViewController.h"
#import "CouponViewController.h"

//个人中心背景页面和原形头像
#import "LeafScrollView.h"
#import "PPAImageView.h"

#import "MyCNstormTableViewCell.h"
#import "MySection.h"
#import "MyRow.h"

#import "JSBadgeButton.h"

@class MyCNstormViewController;

@protocol MyCNstormViewControllerDelegate <NSObject>

@optional
- (void)didFinishedLoginOut:(MyCNstormViewController *)myCNstormViewController;

- (void)didFinishedLogin:(MyCNstormViewController *)myCNstormViewController;

@end

@interface MyCNstormViewController : UIViewController <UIAlertViewDelegate, LoginViewControllerDelegate, SetViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id<MyCNstormViewControllerDelegate> delegate;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) Customer *customer;


@property (nonatomic, strong) PPAImageView *avaterImageView;
@property (nonatomic, strong) UILabel *userNameLable;
@property (nonatomic, strong) UILabel *userJiFenLable;
@property (nonatomic, strong) UILabel *userYuerLable;

@property (nonatomic, strong) JSBadgeButton *awaitReceiveButton;
@property (nonatomic, strong) JSBadgeButton *myStorageButton;

@end
