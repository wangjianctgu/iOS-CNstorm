//
//  AllWayDetail2TableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-23.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyLabel.h"

#import "SelfPackage.h"

@interface AllWayDetail2TableViewCell : UITableViewCell

@property (nonatomic, strong) SelfPackage *selfPackage;

@property (nonatomic, strong) MyLabel *packageTitelLabel;

@property (nonatomic, strong) MyLabel *packageRemarkLabel;

@end
