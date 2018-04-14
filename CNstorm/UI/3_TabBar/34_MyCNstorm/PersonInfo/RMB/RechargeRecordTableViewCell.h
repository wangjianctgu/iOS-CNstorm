//
//  RechargeRecordTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RechargeRecord.h"

@interface RechargeRecordTableViewCell : UITableViewCell

@property (nonatomic, strong) RechargeRecord *rechargeRecord;

@property (nonatomic, strong) UILabel *addTimeLabel;

@property (nonatomic, strong) UILabel *paytypeLabel;

@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) UILabel *accountmoneyLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@end
