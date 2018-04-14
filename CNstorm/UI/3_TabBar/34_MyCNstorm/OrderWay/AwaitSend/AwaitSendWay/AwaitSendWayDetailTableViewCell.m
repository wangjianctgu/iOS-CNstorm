//
//  AwaitSendWayDetailTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-17.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "AwaitSendWayDetailTableViewCell.h"

@implementation AwaitSendWayDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.goodsImageView = [[UIImageView alloc] initWithFrame: CGRectMake(15.0f, 10.0f, 80.0f, 80.0f)];
        [self.contentView addSubview: self.goodsImageView];
        
        self.goodsNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 10.0f, 150.0f, 40.0f)];
        self.goodsNameLabel.textColor = [UIColor blackColor];
        self.goodsNameLabel.font = [UIFont systemFontOfSize:13.0f];
        self.goodsNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.goodsNameLabel.numberOfLines = 2;
        self.goodsNameLabel.textAlignment = NSTextAlignmentLeft;
        self.goodsNameLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.goodsNameLabel];
        
        self.realPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(265.0f, 15.0f, 50.0f, 20.0f)];
        self.realPriceLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:(1.0f)];
        self.realPriceLabel.font = [UIFont systemFontOfSize:12.0f];
        self.realPriceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.realPriceLabel.numberOfLines = 1;
        self.realPriceLabel.textAlignment = NSTextAlignmentCenter;
        self.realPriceLabel.adjustsFontSizeToFitWidth = YES;
        self.realPriceLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.realPriceLabel];
        
        self.colorSizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 50.0f, 150.0f, 25.0f)];
        self.colorSizeLabel.textColor = [UIColor darkGrayColor];
        self.colorSizeLabel.font = [UIFont systemFontOfSize:12.0f];
        self.colorSizeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.colorSizeLabel.numberOfLines = 2;
        self.colorSizeLabel.textAlignment = NSTextAlignmentLeft;
        self.colorSizeLabel.adjustsFontSizeToFitWidth = YES;
        self.colorSizeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.colorSizeLabel];
        
        self.remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 75.0f, 150.0f, 25.0f)];
        self.remarkLabel.textColor = [UIColor darkGrayColor];
        self.remarkLabel.font = [UIFont systemFontOfSize:12.0f];
        self.remarkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.remarkLabel.numberOfLines = 1;
        self.remarkLabel.textAlignment = NSTextAlignmentLeft;
        self.remarkLabel.adjustsFontSizeToFitWidth = YES;
        self.remarkLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.remarkLabel];
        
        self.buyQuantityLabel = [[UILabel alloc]initWithFrame:CGRectMake(265.0f, 65.0f, 50.0f, 20.0f)];
        self.buyQuantityLabel.textColor = [UIColor darkGrayColor];
        self.buyQuantityLabel.font = [UIFont systemFontOfSize:12.0f];
        self.buyQuantityLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.buyQuantityLabel.numberOfLines = 1;
        self.buyQuantityLabel.textAlignment = NSTextAlignmentCenter;
        self.buyQuantityLabel.adjustsFontSizeToFitWidth = YES;
        self.buyQuantityLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.buyQuantityLabel];
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
    
    [self.goodsImageView setImageURLStr:self.goods.goodsImage placeholder:[UIImage imageNamed:@"default80.png"]];
    self.goodsImageView.clipsToBounds = YES;
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.goodsNameLabel.text = self.goods.name;
    
    self.realPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.goods.realPrice];
    
    self.colorSizeLabel.text = [NSString stringWithFormat:@"%@;%@",self.goods.color,self.goods.buySize];
    
    self.remarkLabel.text = [NSString stringWithFormat:@"%@",self.goods.remark];
    
    self.buyQuantityLabel.text = [NSString stringWithFormat:@"X%d",self.goods.buyQuantity];
}

@end

