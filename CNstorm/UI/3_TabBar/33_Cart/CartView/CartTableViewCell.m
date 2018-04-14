//
//  CartTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-23.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "CartTableViewCell.h"

@implementation CartTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectedButton = [[UIButton alloc]initWithFrame:CGRectMake(5.0f, 40.0f, 20.0f, 20.0f)];
        [self.selectedButton setBackgroundImage:[UIImage imageNamed:@"uncheck_selected"] forState:UIControlStateSelected];
        [self.selectedButton setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        self.selectedButton.selected = YES;
        self.selectedButton.userInteractionEnabled = YES;
        [self.contentView addSubview: self.selectedButton];
        
        self.goodsImageView = [[UIImageView alloc] initWithFrame: CGRectMake(30.0f, 10.0f, 80.0f, 80.0f)];
        [self.contentView addSubview: self.goodsImageView];
        
        self.goodsNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(115.0f, 3.0f, 130.0f, 40.0f)];
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
        
        self.sizeColorLabel = [[UILabel alloc]initWithFrame:CGRectMake(115.0f, 43.0f, 200.0f, 20.0f)];
        self.sizeColorLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:(1.0f)];
        self.sizeColorLabel.font = [UIFont systemFontOfSize:12.0f];
        self.sizeColorLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.sizeColorLabel.numberOfLines = 1;
        self.sizeColorLabel.textAlignment = NSTextAlignmentLeft;
        self.sizeColorLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.sizeColorLabel];

        UILabel *remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(115.0f, 67.0f, 33.0f, 25.0f)];
        remarkLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:(1.0f)];
        remarkLabel.text = [NSString stringWithFormat:@"备注:"];
        remarkLabel.font = [UIFont systemFontOfSize:12.0f];
        remarkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        remarkLabel.numberOfLines = 1;
        remarkLabel.textAlignment = NSTextAlignmentLeft;
        remarkLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:remarkLabel];
        
        UIView *remarkView = [[UIView alloc]initWithFrame:CGRectMake(145.0f, 67.0f, 80.0f, 25.0f)];
        [remarkView setBackgroundColor:[UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:(1.0f)]];
        remarkView.layer.cornerRadius= 3.0f;
        remarkView.layer.borderWidth = 0.5f;
        remarkView.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
        [self.contentView  addSubview:remarkView];

        self.remarkInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(2.0f, 0.0f, 76.0f, 25.0f)];
        [self.remarkInfoLabel setBackgroundColor:[UIColor clearColor]];
        self.remarkInfoLabel.font = [UIFont systemFontOfSize:12.0f]; //设置字体名字和字体大小
        self.remarkInfoLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:(1.0f)];
        self.remarkInfoLabel.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
        self.remarkInfoLabel.userInteractionEnabled = YES;
        [remarkView  addSubview:self.remarkInfoLabel];
        
        UIView *mqaView = [[UIView alloc]initWithFrame:CGRectMake(240.0f,67.0f,75.0f,25.0f)];
        mqaView.backgroundColor = [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:(1.0f)];
        mqaView.layer.cornerRadius= 3.0f;
        mqaView.layer.borderWidth = 0.5f;
        mqaView.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
        [self.contentView addSubview:mqaView];
        
        UIButton *minusButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 20.0f, 25.0f)];
        minusButton.backgroundColor = [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:(1.0f)];
        [minusButton setTitle:@"－" forState:UIControlStateNormal];
        minusButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [minusButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        minusButton.tag = 0;
        [mqaView addSubview:minusButton];
        
        UIView *buyQuantityView = [[UIView alloc]initWithFrame:CGRectMake(20.0f, 0.0f, 35.0f, 25.0f)];
        buyQuantityView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:(1.0f)];
        buyQuantityView.layer.borderWidth = 0.5f;
        buyQuantityView.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
        [mqaView addSubview:buyQuantityView];
        
        UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(55.0f, 0.0f, 20.0f, 25.0f)];
        addButton.backgroundColor = [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:(1.0f)];
        addButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [addButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        [addButton setTitle:@"＋" forState:UIControlStateNormal];
        addButton.tag = 1;
        [mqaView addSubview:addButton];
        
        self.buyQuantityInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 75.0f, 25.0f)];
        self.buyQuantityInfoLabel.backgroundColor = [UIColor clearColor];
        self.buyQuantityInfoLabel.font = [UIFont systemFontOfSize:12.0f];
        self.buyQuantityInfoLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:(1.0f)];
        mqaView.layer.cornerRadius= 6.0f;
        self.buyQuantityInfoLabel.textAlignment = NSTextAlignmentCenter;
        self.buyQuantityInfoLabel.userInteractionEnabled = YES;
        [mqaView addSubview:self.buyQuantityInfoLabel];
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
    
    self.selectedButton.selected = self.goods.isSelected;
    
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
        self.remarkInfoLabel.text = [NSString stringWithFormat:@"%@",self.goods.remark];
    }
    else
    {
        self.remarkInfoLabel.text = [NSString stringWithFormat:@""];
    }
    
    self.buyQuantityInfoLabel.text = [NSString stringWithFormat:@"%d",self.goods.buyQuantity];
    
}

@end
