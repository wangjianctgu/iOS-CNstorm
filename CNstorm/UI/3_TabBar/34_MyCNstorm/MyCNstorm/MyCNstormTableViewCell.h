//
//  MyCNstormTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-7.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyRow.h"
#import "JSBadgeView.h"


@interface MyCNstormTableViewCell : UITableViewCell

@property (nonatomic, strong) MyRow *myRow;

@property (nonatomic, readwrite) CGRect rowImageViewFram;

@property (nonatomic, strong) UIImageView *rowImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *rowDetailLabel;

@property (nonatomic, strong) JSBadgeView *jsBadgeView;

@end
