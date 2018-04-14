//
//  DealTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DealMessage.h"

@interface DealTableViewCell : UITableViewCell

@property (nonatomic, strong) DealMessage *dealMessage;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@end
