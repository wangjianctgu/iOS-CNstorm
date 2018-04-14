//
//  CostimatingTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-31.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "CostimatingTableViewCell.h"

@implementation CostimatingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.carrierLogoImageView = [[UIImageView alloc] initWithFrame: CGRectMake(10.0f, 5.0f, 80.0f, 40.0f)];
        [self.contentView addSubview: self.carrierLogoImageView];
        
        self.deliveryNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 10.0f, 110.0f, 30.0f)];
        self.deliveryNameLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.deliveryNameLabel.font = [UIFont systemFontOfSize:15.0f];
        self.deliveryNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.deliveryNameLabel.numberOfLines = 1;
        self.deliveryNameLabel.textAlignment = NSTextAlignmentLeft;
        self.deliveryNameLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.deliveryNameLabel];
        
        self.totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(210.0f, 10.0f, 100.0f, 30.0f)];
        self.totalLabel.textColor = [UIColor colorWithRed:(253.0f/255.0f) green:(78.0f/255.0f) blue:(46.0f/255.0f) alpha:1.0f];
        self.totalLabel.font = [UIFont systemFontOfSize:14.0f];
        self.totalLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.totalLabel.numberOfLines = 1;
        self.totalLabel.textAlignment = NSTextAlignmentRight;
        self.totalLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.totalLabel];
        
        self.freightLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 50.0f, 100.0f, 25.0f)];
        self.freightLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.freightLabel.font = [UIFont systemFontOfSize:13.0f];
        self.freightLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.freightLabel.numberOfLines = 1;
        self.freightLabel.textAlignment = NSTextAlignmentLeft;
        self.freightLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.freightLabel];

        self.servefeeLabel = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 50.0f, 100.0f, 25.0f)];
        self.servefeeLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.servefeeLabel.font = [UIFont systemFontOfSize:13.0f];
        self.servefeeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.servefeeLabel.numberOfLines = 1;
        self.servefeeLabel.textAlignment = NSTextAlignmentLeft;
        self.servefeeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.servefeeLabel];
        
        self.customsFeeLabel = [[UILabel alloc]initWithFrame:CGRectMake(210.0f, 50.0f, 100.0f, 25.0f)];
        self.customsFeeLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.customsFeeLabel.font = [UIFont systemFontOfSize:13.0f];
        self.customsFeeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.customsFeeLabel.numberOfLines = 1;
        self.customsFeeLabel.textAlignment = NSTextAlignmentLeft;
        self.customsFeeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.customsFeeLabel];
        
        self.deliveryTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 75.0f, 300.0f, 25.0f)];
        self.deliveryTimeLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.deliveryTimeLabel.font = [UIFont systemFontOfSize:13.0f];
        self.deliveryTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.deliveryTimeLabel.numberOfLines = 1;
        self.deliveryTimeLabel.textAlignment = NSTextAlignmentLeft;
        self.deliveryTimeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.deliveryTimeLabel];
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
    
    [self.carrierLogoImageView setImageURLStr:self.costimating.carrierLogo placeholder:[UIImage imageNamed:@"default60.png"]];
    self.carrierLogoImageView.clipsToBounds = YES;
    self.carrierLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.deliveryNameLabel.text = self.costimating.deliveryName;
    self.deliveryTimeLabel.text = [NSString stringWithFormat:@"时效(工作日):%@天",self.costimating.deliveryTime];
    
    self.totalLabel.text = [NSString stringWithFormat:@"总计:￥%.2f",self.costimating.total];
    self.freightLabel.text = [NSString stringWithFormat:@"运费:￥%.2f",self.costimating.freight];
    self.servefeeLabel.text = [NSString stringWithFormat:@"服务费:￥%.2f",self.costimating.servefee];
    self.customsFeeLabel.text = [NSString stringWithFormat:@"报关费:￥%.2f",self.costimating.customsFee];
   }

@end
