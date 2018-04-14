//
//  ExpressViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-15.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIDefine.h"

#import "PinYinForObjc.h"

#import "BATableView.h"
#import "BATableViewCell.h"
#import "BATableViewHeaderView.h"

#import "ExpressIndex.h"
#import "Express.h"

@protocol ExpressViewControllerDelegate <NSObject>

@optional
- (void)didFinishedReturnExpress:(Express *) selectedExpress;

@end

@interface ExpressViewController : UIViewController <BATableViewDelegate>

@property (nonatomic, assign) id<ExpressViewControllerDelegate> delegate;

@property (nonatomic, strong) BATableView *baTableView;

@property (nonatomic, strong) NSMutableArray *expressIndexList;

@end
