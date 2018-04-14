//
//  SetViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-4-11.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyCNstormTableViewCell.h"
#import "TableViewFooterView.h"
#import "KKActionSheet.h"
#import "MySection.h"
#import "MyRow.h"

#import "MessageAwakeController.h"
#import "AboutMeViewController.h"
#import "FeedbackViewController.h"

#import <ShareSDK/ShareSDK.h>

@class SetViewController;

@protocol SetViewControllerDelegate <NSObject>

@optional

- (void)didFinishedReturn:(SetViewController *) setViewController;

- (void)didFinishedReturnTabBar:(NSUInteger) selectedIndex;

@end

@interface SetViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

@property (nonatomic, assign) id<SetViewControllerDelegate> delegate;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *sectionArray;

@property (nonatomic, readwrite) BOOL isShow;


@property (nonatomic, strong) UIAlertView *clearCachesAlertView;
@property (nonatomic, strong) UIAlertView *updateAlertView;
@property (nonatomic, strong) UIAlertView *checkAlertView;

@end
