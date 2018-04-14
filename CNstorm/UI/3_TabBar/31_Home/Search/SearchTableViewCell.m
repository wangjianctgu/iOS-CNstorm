//
//  SearchTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-15.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.contentView.backgroundColor = [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1.0f];
        self.contentView.tintColor = [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1.0f];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 2.0f, 280.0f, 40.0f)];
        self.titleLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:(1.0f)];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.titleLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 43.0f, 300.0f, 1.0f)];
        lineView.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
        [self.contentView addSubview:lineView];
        
        //箭头类型、图片
        UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(295.0f,16.75f, 6.0f, 10.5f)];
        [arrowImageView setImage:[UIImage imageNamed:@"accessoryView"]];
        [self.contentView addSubview:arrowImageView];
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
