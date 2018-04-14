//
//  DealTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "DealTableViewCell.h"

@implementation DealTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 8.0f, 300.0f, 20.0f)];
        self.titleLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 30.0f, 290.0f, 32.22f)];
        self.contentLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.contentLabel.font = [UIFont systemFontOfSize:14.0];
        self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.contentLabel.numberOfLines = 2;
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.contentLabel];
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
    
    self.titleLabel.text = self.dealMessage.title;
    self.contentLabel.text = self.dealMessage.content;
    
    CGSize dealMessageContentSize = [self.dealMessage.content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]}];
    
    if(dealMessageContentSize.width > 2*300.0f)
    {
        NSInteger addNumberOfLines = 0;
        
        float yushu = fmodf(dealMessageContentSize.width-2*300.0f,300.0f);
        
        if (yushu == 0.0f)
        {
            addNumberOfLines = (NSInteger)((dealMessageContentSize.width-2*300.0f)/300.0f);
        }
        else
        {
            addNumberOfLines = (NSInteger)((dealMessageContentSize.width-2*300.0f)/300.0f+1);
        }
        self.contentLabel.numberOfLines = 2+addNumberOfLines;
        self.contentLabel.frame = CGRectMake(10.0f, 30.0f, 300.0f, self.contentLabel.numberOfLines*15.51f);
    }
    else
    {
        self.contentLabel.numberOfLines = 2;
        self.contentLabel.frame = CGRectMake(10.0f, 30.0f, 300.0f, 31.02f);
    }
}

@end
