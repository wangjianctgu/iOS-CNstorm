//
//  WayConfirmSelfPackageTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "WayConfirmSelfPackageTableViewCell.h"

@implementation WayConfirmSelfPackageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.packageTitelLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 0.0f, 235.0f, 30.0f)];
        self.packageTitelLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.packageTitelLabel.font = [UIFont systemFontOfSize:14.0f];
        self.packageTitelLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.packageTitelLabel.numberOfLines = 1;
        self.packageTitelLabel.textAlignment = NSTextAlignmentLeft;
        self.packageTitelLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.packageTitelLabel];
        
        self.packageWeightLabel = [[UILabel alloc]initWithFrame:CGRectMake(255.0f, 0.0f, 60.0f, 30.0f)];
        self.packageWeightLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:(1.0f)];
        self.packageWeightLabel.font = [UIFont systemFontOfSize:12.0f];
        self.packageWeightLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.packageWeightLabel.numberOfLines = 2;
        self.packageWeightLabel.textAlignment = NSTextAlignmentRight;
        self.packageWeightLabel.adjustsFontSizeToFitWidth = YES;
        self.packageWeightLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.packageWeightLabel];
        
        self.packageRemarkLabel = [[MyLabel alloc]initWithFrame:CGRectMake(20.0f, 30.0f, 280.0f, 55.0f)];
        self.packageRemarkLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.packageRemarkLabel.font = [UIFont systemFontOfSize:13.0f];
        self.packageRemarkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.packageRemarkLabel.numberOfLines = 3;
        self.packageRemarkLabel.textAlignment = NSTextAlignmentLeft;
        [self.packageRemarkLabel setVerticalAlignment:VerticalAlignmentTop];
        self.packageRemarkLabel.adjustsFontSizeToFitWidth = YES;
        self.packageRemarkLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.packageRemarkLabel];
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
    
    self.packageTitelLabel.text = self.selfPackage.packageTitle;
    
    self.packageWeightLabel.text = [NSString stringWithFormat:@"%.2fg",self.selfPackage.packageWeight];
    
    self.packageRemarkLabel.text = [NSString stringWithFormat:@"%@",self.selfPackage.packageRemark];
}


@end


