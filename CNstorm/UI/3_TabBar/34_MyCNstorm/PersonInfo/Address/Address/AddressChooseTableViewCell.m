//
//  AddressChooseTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-23.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "AddressChooseTableViewCell.h"

@implementation AddressChooseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.recevicerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 5.0f, 140.0f, 23.0f)];
        self.recevicerLabel.text = @"Recevicer Name";
        self.recevicerLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.recevicerLabel.font = [UIFont systemFontOfSize:15.0f];
        self.recevicerLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.recevicerLabel.numberOfLines = 1;
        self.recevicerLabel.textAlignment = NSTextAlignmentLeft;
        self.recevicerLabel.adjustsFontSizeToFitWidth = YES;
        self.recevicerLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.recevicerLabel];
        
        self.telePhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(150.0f, 5.0f, 140.0f, 23.0f)];
        self.telePhoneLabel.text = @"TelePhone";
        self.telePhoneLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.telePhoneLabel.font = [UIFont systemFontOfSize:14.0f];
        self.telePhoneLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.telePhoneLabel.numberOfLines = 1;
        self.telePhoneLabel.textAlignment = NSTextAlignmentRight;
        self.telePhoneLabel.adjustsFontSizeToFitWidth = YES;
        self.telePhoneLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.telePhoneLabel];
        
        self.addressDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 28.0f, 280.0f, 69.0f)];
        self.addressDetailLabel.text = @"Recevicer Detailed Address";
        self.addressDetailLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.addressDetailLabel.font = [UIFont systemFontOfSize:13.0f];
        self.addressDetailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.addressDetailLabel.numberOfLines = 3;
        self.addressDetailLabel.textAlignment = NSTextAlignmentLeft;
        self.addressDetailLabel.adjustsFontSizeToFitWidth = YES;
        self.addressDetailLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.addressDetailLabel];
        
        self.isDefaultButton = [[UIButton alloc]initWithFrame:CGRectMake(295.0f,38.5f, 20.0f, 20.0f)];
        self.isDefaultButton.userInteractionEnabled = NO;//则用户不用触发该UIButton Action方法
        [self.contentView addSubview:self.isDefaultButton];
    }
    return self;
}

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.recevicerLabel.text = self.address.recevicer;
    
    self.telePhoneLabel.text = self.address.telePhone;
    
    self.addressDetailLabel.text = [NSString stringWithFormat:@"%@, %@, %@, %@",self.address.addressDetail,self.address.province,self.address.country,self.address.mailCode];
    
    if (self.address.isDefault)
    {
        self.recevicerLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f];
        self.telePhoneLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f];
        self.addressDetailLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f];
    }
    else
    {
        self.recevicerLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.telePhoneLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.addressDetailLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    }
    
    [self.isDefaultButton setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    [self.isDefaultButton setBackgroundImage:[UIImage imageNamed:@"uncheck_selected"] forState:UIControlStateSelected];
    self.isDefaultButton.selected = self.address.isDefault;
}

@end
