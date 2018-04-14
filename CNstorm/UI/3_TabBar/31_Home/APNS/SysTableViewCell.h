//
//  SysTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SysMessage.h"

@interface SysTableViewCell : UITableViewCell

@property (nonatomic, strong) SysMessage *sysMessage;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@end
