//
//  WayConfirmBuyPackageTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "WayConfirmBuyPackageTableViewCell.h"

@implementation WayConfirmBuyPackageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.goodsImageView = [[UIImageView alloc] initWithFrame: CGRectMake(15.0f, 10.0f, 80.0f, 80.0f)];
        [self.contentView addSubview: self.goodsImageView];
        
        self.goodsNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 3.0f, 145.0f, 40.0f)];
        self.goodsNameLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:(1.0f)];
        self.goodsNameLabel.font = [UIFont systemFontOfSize:13.0f];
        self.goodsNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.goodsNameLabel.numberOfLines = 2;
        self.goodsNameLabel.textAlignment = NSTextAlignmentLeft;
        self.goodsNameLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.goodsNameLabel];
        
        self.realPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(245.0f, 5.0f, 70.0f, 40.0f)];
        self.realPriceLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:(1.0f)];
        self.realPriceLabel.font = [UIFont systemFontOfSize:12.0f];
        self.realPriceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.realPriceLabel.numberOfLines = 1;
        self.realPriceLabel.textAlignment = NSTextAlignmentRight;
        self.realPriceLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        self.realPriceLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.realPriceLabel];
        
        self.sizeColorLabel = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 43.0f, 215.0f, 20.0f)];
        self.sizeColorLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:(1.0f)];
        self.sizeColorLabel.font = [UIFont systemFontOfSize:12.0f];
        self.sizeColorLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.sizeColorLabel.numberOfLines = 1;
        self.sizeColorLabel.textAlignment = NSTextAlignmentLeft;
        self.sizeColorLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.sizeColorLabel];
        
        self.remarkInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 67.0f, 240.0f, 25.0f)];
        [self.remarkInfoLabel setBackgroundColor:[UIColor clearColor]];
        self.remarkInfoLabel.font = [UIFont systemFontOfSize:12.0f]; //设置字体名字和字体大小
        self.remarkInfoLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:(1.0f)];
        self.remarkInfoLabel.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
        self.remarkInfoLabel.userInteractionEnabled = YES;
        [self.contentView  addSubview:self.remarkInfoLabel];
        
        self.buyQuantityInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(240.0f, 67.0f, 75.0f, 25.0f)];
        self.buyQuantityInfoLabel.backgroundColor = [UIColor clearColor];
        self.buyQuantityInfoLabel.font = [UIFont systemFontOfSize:12.0f];
        self.buyQuantityInfoLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:(1.0f)];
        self.buyQuantityInfoLabel.textAlignment = NSTextAlignmentRight;
        self.buyQuantityInfoLabel.userInteractionEnabled = YES;
        [self.contentView addSubview:self.buyQuantityInfoLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 99.0f, 320.0f, 1.0f)];
        lineView.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
        [self addSubview:lineView];
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
    
    self.goodsNameLabel.text = [NSString stringWithFormat:@"%@",self.goods.name];
    self.realPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.goods.realPrice];
    
    if((!self.goods.buySize||[self.goods.buySize isEqualToString:@""]||[self.goods.buySize isEqualToString:@"(null)"])&&(!self.goods.color||[self.goods.color isEqualToString:@""]||[self.goods.color isEqualToString:@"(null)"]))
    {
        self.sizeColorLabel.text = [NSString stringWithFormat:@""];
    }
    else if (!self.goods.buySize||[self.goods.buySize isEqualToString:@""]||[self.goods.buySize isEqualToString:@"(null)"])
    {
        self.sizeColorLabel.text = [NSString stringWithFormat:@"颜色:%@",self.goods.color];
    }
    else if (!self.goods.color||[self.goods.color isEqualToString:@""]||[self.goods.color isEqualToString:@"(null)"])
    {
        self.sizeColorLabel.text = [NSString stringWithFormat:@"尺码:%@",self.goods.buySize];
    }
    else
    {
        self.sizeColorLabel.text = [NSString stringWithFormat:@"尺码:%@; 颜色:%@",self.goods.buySize,self.goods.color];
    }
    
    if(self.goods.remark.length != 0)
    {
        self.remarkInfoLabel.text = [NSString stringWithFormat:@"备注:%@",self.goods.remark];
    }
    else
    {
        self.remarkInfoLabel.text = [NSString stringWithFormat:@""];
    }
    
    self.buyQuantityInfoLabel.text = [NSString stringWithFormat:@"x%d",self.goods.buyQuantity];
}

@end
