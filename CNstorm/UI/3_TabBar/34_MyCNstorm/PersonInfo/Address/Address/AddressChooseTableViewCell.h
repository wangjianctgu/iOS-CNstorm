//
//  AddressChooseTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-23.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Address.h"

@interface AddressChooseTableViewCell : UITableViewCell

@property (nonatomic, strong) Address *address;

@property (nonatomic, strong) UILabel *recevicerLabel;

@property (nonatomic, strong) UILabel *telePhoneLabel;

@property (nonatomic, strong) UILabel *addressDetailLabel;

@property (nonatomic, strong) UIButton *isDefaultButton;

@end
