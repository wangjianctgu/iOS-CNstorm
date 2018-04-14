//
//  ProvinceViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-21.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIDefine.h"

#import "BATableView.h"
#import "BATableViewCell.h"
#import "BATableViewHeaderView.h"

#import "ProvinceIndex.h"
#import "Province.h"


@class ProvinceViewController;
@protocol ProvinceViewControllerDelegate <NSObject>

@optional
- (void)didFinishedReturnProvince:(Province *)selectedProvince;

@end


@interface ProvinceViewController : UIViewController<BATableViewDelegate>

@property (nonatomic, assign) id<ProvinceViewControllerDelegate> delegate;

@property (nonatomic, strong) BATableView *baTableView;

@property (nonatomic, strong) NSMutableArray *provinceIndexList;

@property (nonatomic, readwrite) int selectedCountryId;

@end

