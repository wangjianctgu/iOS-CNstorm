//
//  BATableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "BATableViewCell.h"

@implementation BATableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 0.0f, 290.0f, 44.0f)];
        self.titleLabel.text = @"title";
        self.titleLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.titleLabel];
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
    
    self.titleLabel.text = self.title;
}

@end
