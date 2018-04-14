//
//  PayRecordTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-25.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Record.h"

@interface PayRecordTableViewCell : UITableViewCell

@property (nonatomic, strong) Record *record;

@property (nonatomic, strong) UILabel *addTimeLabel;

@property (nonatomic, strong) UILabel *actionLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *accountmoneyLabel;

@end
