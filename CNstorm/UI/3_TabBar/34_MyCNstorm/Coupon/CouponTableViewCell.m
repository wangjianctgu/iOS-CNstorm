//
//  CouponTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "CouponTableViewCell.h"

@implementation CouponTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bgImageView = [[UIImageView alloc] initWithFrame: CGRectMake(10.0f, 0.0f, 300.0f, 130.0f)];
        [self.contentView addSubview: self.bgImageView];
        
        self.addEndTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 15.0f, 250.0f, 23.0f)];
        self.addEndTimeLabel.text = @"有效期";
        self.addEndTimeLabel.textColor = [UIColor colorWithRed:(173.0f/255.0f) green:(22.0f/255.0f) blue:(40.0f/255.0f) alpha:1.0f];
        self.addEndTimeLabel.font = [UIFont systemFontOfSize:14.0f];
        self.addEndTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.addEndTimeLabel.numberOfLines = 1;
        self.addEndTimeLabel.textAlignment = NSTextAlignmentLeft;
        self.addEndTimeLabel.adjustsFontSizeToFitWidth = YES;
        self.addEndTimeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.bgImageView addSubview:self.addEndTimeLabel];
        
        self.yLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 50.0f, 20.0f, 40.0f)];
        self.yLabel.text = @"¥";
        self.yLabel.textColor = [UIColor colorWithRed:(147.0f/255.0f) green:(17.0f/255.0f) blue:(33.0f/255.0f) alpha:1.0f];
        self.yLabel.font = [UIFont boldSystemFontOfSize:25.0f];
        self.yLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.yLabel.numberOfLines = 1;
        self.yLabel.textAlignment = NSTextAlignmentCenter;
        self.yLabel.adjustsFontSizeToFitWidth = YES;
        self.yLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.bgImageView  addSubview:self.yLabel];
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(35.0f, 40.0f, 200.0f, 50.0f)];
        self.moneyLabel.text = @"150";
        self.moneyLabel.textColor = [UIColor colorWithRed:(147.0f/255.0f) green:(17.0f/255.0f) blue:(33.0f/255.0f) alpha:1.0f];
        self.moneyLabel.font = [UIFont boldSystemFontOfSize:40.0f];
        self.moneyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.moneyLabel.numberOfLines = 1;
        self.moneyLabel.textAlignment = NSTextAlignmentLeft;
        self.moneyLabel.adjustsFontSizeToFitWidth = YES;
        self.moneyLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.bgImageView  addSubview:self.moneyLabel];
        
        self.sellmoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 90.0f, 150.0f, 23.0f)];
        self.sellmoneyLabel.text = @"满200使用";
        self.sellmoneyLabel.textColor = [UIColor colorWithRed:(173.0f/255.0f) green:(22.0f/255.0f) blue:(40.0f/255.0f) alpha:1.0f];
        self.sellmoneyLabel.font = [UIFont systemFontOfSize:15.0f];
        self.sellmoneyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.sellmoneyLabel.numberOfLines = 1;
        self.sellmoneyLabel.textAlignment = NSTextAlignmentLeft;
        self.sellmoneyLabel.adjustsFontSizeToFitWidth = YES;
        self.sellmoneyLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.bgImageView  addSubview:self.sellmoneyLabel];
        
        self.stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(185.0f, 90.0f, 100.0f, 23.0f)];
        self.stateLabel.text = @"未使用";
        self.stateLabel.textColor = [UIColor colorWithRed:(173.0f/255.0f) green:(22.0f/255.0f) blue:(40.0f/255.0f) alpha:1.0f];
        self.stateLabel.font = [UIFont systemFontOfSize:15.0f];
        self.stateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.stateLabel.numberOfLines = 1;
        self.stateLabel.textAlignment = NSTextAlignmentRight;
        self.stateLabel.adjustsFontSizeToFitWidth = YES;
        self.stateLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.bgImageView  addSubview:self.stateLabel];
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
    
    if (self.coupon)
    {
        if (self.coupon.state == 1)
        {
            [self.bgImageView setImage:[UIImage imageNamed:@"unuse_coupon"]];
            self.stateLabel.text = [NSString stringWithFormat:@"未使用"];
            self.addEndTimeLabel.textColor = [UIColor colorWithRed:(173.0f/255.0f) green:(22.0f/255.0f) blue:(40.0f/255.0f) alpha:1.0f];
            self.yLabel.textColor = [UIColor colorWithRed:(147.0f/255.0f) green:(17.0f/255.0f) blue:(33.0f/255.0f) alpha:1.0f];
            self.moneyLabel.textColor = [UIColor colorWithRed:(147.0f/255.0f) green:(17.0f/255.0f) blue:(33.0f/255.0f) alpha:1.0f];
            self.sellmoneyLabel.textColor = [UIColor colorWithRed:(173.0f/255.0f) green:(22.0f/255.0f) blue:(40.0f/255.0f) alpha:1.0f];
            self.stateLabel.textColor = [UIColor colorWithRed:(173.0f/255.0f) green:(22.0f/255.0f) blue:(40.0f/255.0f) alpha:1.0f];

        }
        else if (self.coupon.state == 2)
        {
            [self.bgImageView setImage:[UIImage imageNamed:@"use_coupon"]];
            self.stateLabel.text = [NSString stringWithFormat:@"已使用"];
            self.addEndTimeLabel.textColor = [UIColor colorWithRed:(193.0f/255.0f) green:(130.0f/255.0f) blue:(39.0f/255.0f) alpha:1.0f];
            self.yLabel.textColor = [UIColor colorWithRed:(157.0f/255.0f) green:(101.0f/255.0f) blue:(20.0f/255.0f) alpha:1.0f];
            self.moneyLabel.textColor = [UIColor colorWithRed:(157.0f/255.0f) green:(101.0f/255.0f) blue:(20.0f/255.0f) alpha:1.0f];
            self.sellmoneyLabel.textColor = [UIColor colorWithRed:(193.0f/255.0f) green:(130.0f/255.0f) blue:(39.0f/255.0f) alpha:1.0f];
            self.stateLabel.textColor = [UIColor colorWithRed:(193.0f/255.0f) green:(130.0f/255.0f) blue:(39.0f/255.0f) alpha:1.0f];
        }
        else
        {
            [self.bgImageView setImage:[UIImage imageNamed:@"nouse_coupon"]];
            self.stateLabel.text = [NSString stringWithFormat:@"已过期"];
            self.addEndTimeLabel.textColor = [UIColor colorWithRed:(128.0f/255.0f) green:(128.0f/255.0f) blue:(128.0f/255.0f) alpha:1.0f];
            self.yLabel.textColor = [UIColor colorWithRed:(104.0f/255.0f) green:(104.0f/255.0f) blue:(104.0f/255.0f) alpha:1.0f];
            self.moneyLabel.textColor = [UIColor colorWithRed:(104.0f/255.0f) green:(104.0f/255.0f) blue:(104.0f/255.0f) alpha:1.0f];
            self.sellmoneyLabel.textColor = [UIColor colorWithRed:(128.0f/255.0f) green:(128.0f/255.0f) blue:(128.0f/255.0f) alpha:1.0f];
            self.stateLabel.textColor = [UIColor colorWithRed:(128.0f/255.0f) green:(128.0f/255.0f) blue:(128.0f/255.0f) alpha:1.0f];
        }
        
        //时间戳转成时间
        NSTimeInterval addtimeInterval = [[NSString stringWithFormat:@"%lld", self.coupon.addtime] doubleValue];
        NSDate *addDate = [NSDate dateWithTimeIntervalSince1970:addtimeInterval];
        NSTimeInterval endtimeInterval = [[NSString stringWithFormat:@"%lld", self.coupon.endtime] doubleValue];
        NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endtimeInterval];

        self.addEndTimeLabel.text =  [NSString stringWithFormat:@"有效期:%@～%@",[self stringFromDate:addDate],[self stringFromDate:endDate]];
        
        self.moneyLabel.text = [NSString stringWithFormat:@"%d",self.coupon.money];

        self.sellmoneyLabel.text = [NSString stringWithFormat:@"满%d使用",self.coupon.sellmoney];
    }
}

- (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    return [dateFormatter stringFromDate:date];
}

@end