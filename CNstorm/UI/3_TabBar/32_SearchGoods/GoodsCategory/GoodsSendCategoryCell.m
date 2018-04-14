//
//  GoodsSendCategoryCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-11.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "GoodsSendCategoryCell.h"

@implementation GoodsSendCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.contentView.backgroundColor = [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1.0f];
        
        self.goodsCategoryImageView = [[UIImageView alloc] initWithFrame: CGRectMake(25.0f, 0.0f, 59.0f, 59.0f)];
        [self.contentView addSubview: self.goodsCategoryImageView];
        
        self.goodsCategoryNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 20.0f, 150.0f, 20.0f)];
        self.goodsCategoryNameLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.goodsCategoryNameLabel.font = [UIFont systemFontOfSize:15.0f];
        self.goodsCategoryNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.goodsCategoryNameLabel.numberOfLines = 1;
        self.goodsCategoryNameLabel.textAlignment = NSTextAlignmentLeft;
        self.goodsCategoryNameLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.goodsCategoryNameLabel];
        
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(15.0f, 59.0f, 190.0f, 1.0f)];
        self.lineView.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
        [self.contentView addSubview:self.lineView];
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
    
    [self.goodsCategoryImageView setImageURLStr:self.goodsCategory.image placeholder:[UIImage imageNamed:self.goodsCategory.image]];
    self.goodsCategoryImageView.clipsToBounds = YES;
    self.goodsCategoryImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.goodsCategoryNameLabel.text = self.goodsCategory.name;
}


@end
