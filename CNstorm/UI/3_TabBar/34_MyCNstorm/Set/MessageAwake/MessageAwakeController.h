//
//  MessageAwakeController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-23.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "KxMenu.h"

#import "MessageAwakeTableViewCell.h"

@class MessageAwakeController;

@protocol MessageAwakeControllerDelegate <NSObject>

@optional

- (void)didFinishedReturnTabBar:(NSUInteger) selectedIndex;

@end

@interface MessageAwakeController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id<MessageAwakeControllerDelegate> delegate;

@property (nonatomic, strong) UITableView *tableView;

@end
