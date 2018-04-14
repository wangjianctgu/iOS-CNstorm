//
//  AllWayDetail2TableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-23.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "AllWayDetail2TableViewCell.h"

@implementation AllWayDetail2TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.packageTitelLabel = [[MyLabel alloc]initWithFrame:CGRectMake(10.0f, 8.0f, 300.0f, 35.0f)];
        [self.packageTitelLabel setVerticalAlignment:VerticalAlignmentTop];
        self.packageTitelLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.packageTitelLabel.font = [UIFont systemFontOfSize:15.0f];
        self.packageTitelLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.packageTitelLabel.numberOfLines = 2;
        self.packageTitelLabel.textAlignment = NSTextAlignmentLeft;
        self.packageTitelLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.packageTitelLabel];
        
        self.packageRemarkLabel = [[MyLabel alloc]initWithFrame:CGRectMake(15.0f, 40.0f, 300.0f, 60.0f)];
        [self.packageRemarkLabel setVerticalAlignment:VerticalAlignmentTop];
        self.packageRemarkLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.packageRemarkLabel.font = [UIFont systemFontOfSize:14.0f];
        self.packageRemarkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.packageRemarkLabel.numberOfLines = 3;
        self.packageRemarkLabel.textAlignment = NSTextAlignmentLeft;
        self.packageRemarkLabel.adjustsFontSizeToFitWidth = YES;
        self.packageRemarkLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.packageRemarkLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 99.0f, 320.0f, 1.0f)];
        lineView.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
        [self.contentView addSubview:lineView];
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
    
    self.packageRemarkLabel.text = [NSString stringWithFormat:@"%@",self.selfPackage.packageRemark];
}

@end