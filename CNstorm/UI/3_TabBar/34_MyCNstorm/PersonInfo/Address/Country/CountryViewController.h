//
//  CountryViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-21.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"

#import "BATableView.h"
#import "BATableViewCell.h"
#import "BATableViewHeaderView.h"

#import "Country.h"
#import "CountryIndex.h"


@class CountryViewController;
@protocol CountryViewControllerDelegate <NSObject>

@optional
- (void)didFinishedReturnCountry:(Country *)selectedCountry;

@end

@interface CountryViewController : UIViewController<BATableViewDelegate>

@property (nonatomic, assign) id<CountryViewControllerDelegate> delegate;

@property (nonatomic, strong) BATableView *baTableView;

@property (nonatomic, strong) NSMutableArray *countryIndexList;

@end
