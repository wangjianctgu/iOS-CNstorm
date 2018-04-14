//
//  AddressTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-20.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Address.h"

@interface AddressTableViewCell : UITableViewCell

@property (nonatomic, strong) Address *address;

@property (nonatomic, strong) UILabel *recevicerLabel;

@property (nonatomic, strong) UILabel *telePhoneLabel;

@property (nonatomic, strong) UILabel *addressDetailLabel;

@end
