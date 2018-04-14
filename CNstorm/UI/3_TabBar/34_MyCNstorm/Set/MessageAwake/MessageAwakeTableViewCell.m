//
//  MessageAwakeTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-23.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "MessageAwakeTableViewCell.h"

@implementation MessageAwakeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(25.0f, 14.0f, 100.0f, 16.0f)];
        self.nameLabel.textColor = [UIColor colorWithRed:(51.0f)/255.0f green:(51.0f)/255.0f blue:(51.0f)/255.0f alpha:(1.0f)];
        self.nameLabel.font = [UIFont systemFontOfSize:14.0f];
        self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.nameLabel.numberOfLines = 1;
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.nameLabel];
        
        self.rowDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(185.0f, 7.0f, 100.0f, 30.0f)];
        self.rowDetailLabel.textColor = [UIColor colorWithRed:(200.0f)/255.0f green:(200.0f)/255.0f blue:(200.0f)/255.0f alpha:(1.0f)];;
        self.rowDetailLabel.font = [UIFont systemFontOfSize:13.0f];
        self.rowDetailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.rowDetailLabel.numberOfLines = 1;
        self.rowDetailLabel.textAlignment = NSTextAlignmentRight;
        self.rowDetailLabel.adjustsFontSizeToFitWidth = YES;
        self.rowDetailLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.rowDetailLabel];

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
    
    self.nameLabel.text = @"新消息订阅";
    self.nameLabel.highlightedTextColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:(1.0f)];
    
    self.rowDetailLabel.text = @"已开启";
}

@end
