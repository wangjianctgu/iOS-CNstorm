//
//  FavoriteTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "FavoriteTableViewCell.h"

@implementation FavoriteTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.goodsImageView = [[UIImageView alloc] initWithFrame: CGRectMake(11.0f, 12.5f, 75.0f, 75.0f)];
        [self.contentView addSubview: self.goodsImageView];
        
        self.goodsNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(91.0f, 12.5f, 220.0f, 40.0f)];
        self.goodsNameLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.goodsNameLabel.font = [UIFont systemFontOfSize:14.0f];
        self.goodsNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.goodsNameLabel.numberOfLines = 2;
        self.goodsNameLabel.textAlignment = NSTextAlignmentLeft;
        self.goodsNameLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.goodsNameLabel];
        
        self.goodspriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(91.0f, 52.5f, 100.0f, 18.0f)];
        self.goodspriceLabel.textColor = [UIColor colorWithRed:(253.0f/255.0f) green:(78.0f/255.0f) blue:(46.0f/255.0f) alpha:1.0f];
        self.goodspriceLabel.font = [UIFont systemFontOfSize:15.0f];
        self.goodspriceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.goodspriceLabel.numberOfLines = 1;
        self.goodspriceLabel.textAlignment = NSTextAlignmentLeft;
        self.goodspriceLabel.adjustsFontSizeToFitWidth = YES;
        self.goodspriceLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.goodspriceLabel];
        
        self.modelLabel = [[UILabel alloc]initWithFrame:CGRectMake(91.0f, 70.5f, 200.0f, 17.0f)];
        self.modelLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.modelLabel.font = [UIFont systemFontOfSize:13.0f];
        self.modelLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.modelLabel.numberOfLines = 1;
        self.modelLabel.textAlignment = NSTextAlignmentLeft;
        self.modelLabel.adjustsFontSizeToFitWidth = YES;
        self.modelLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.modelLabel];
        
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
    
    [self.goodsImageView setImageURLStr:self.favorite.thumb placeholder:[UIImage imageNamed:@"default75.png"]];
    self.goodsImageView.clipsToBounds = YES;
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.goodsNameLabel.text = self.favorite.name;
    
    self.goodspriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.favorite.price];
    
    //时间戳转成时间
//    NSTimeInterval timeInterval = [[NSString stringWithFormat:@"%lld", self.favorite.addtime] doubleValue];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
//    [self stringFromDate:date]
    
    self.modelLabel.text = [NSString stringWithFormat:@"来源:%@",self.favorite.model];
}

- (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

@end
