//
//  GoodsListTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-2.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "GoodsListTableViewCell.h"

@implementation GoodsListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.goodsImageView = [[UIImageView alloc] initWithFrame: CGRectMake(11.0f, 12.5f, 75.0f, 75.0f)];
        [self.contentView addSubview: self.goodsImageView];
        
        self.goodsNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(91.0f, 8.0f, 220.0f, 40.0f)];
        self.goodsNameLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.goodsNameLabel.font = [UIFont systemFontOfSize:14.0f];
        self.goodsNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.goodsNameLabel.numberOfLines = 2;
        self.goodsNameLabel.textAlignment = NSTextAlignmentLeft;
        self.goodsNameLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.goodsNameLabel];
        
        self.realPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(91.0f, 55.0f, 110.0f, 20.0f)];
        self.realPriceLabel.textColor = [UIColor colorWithRed:(253.0f/255.0f) green:(78.0f/255.0f) blue:(46.0f/255.0f) alpha:1.0f];
        self.realPriceLabel.font = [UIFont systemFontOfSize:14.0f];
        self.realPriceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.realPriceLabel.numberOfLines = 1;
        self.realPriceLabel.textAlignment = NSTextAlignmentLeft;
        self.realPriceLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.realPriceLabel];
        
        self.yunfeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(201.0f, 55.0f, 110.0f, 20.0f)];
        self.yunfeiLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.yunfeiLabel.font = [UIFont systemFontOfSize:13.0f];
        self.yunfeiLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.yunfeiLabel.numberOfLines = 1;
        self.yunfeiLabel.textAlignment = NSTextAlignmentRight;
        self.yunfeiLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.yunfeiLabel];
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
    
    [self.goodsImageView setImageURLStr:self.product.image placeholder:[UIImage imageNamed:@"default75.png"]];
    self.goodsImageView.clipsToBounds = YES;
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.goodsNameLabel.text = self.product.name;
    
    self.realPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.product.price];
    
    if(self.product.isbn == 0.00f)
    {
        self.yunfeiLabel.text = [NSString stringWithFormat:@"包邮"];
    }
    else
    {
        self.yunfeiLabel.text = [NSString stringWithFormat:@"运费:￥%.2f",self.product.isbn];
    }
}

@end
