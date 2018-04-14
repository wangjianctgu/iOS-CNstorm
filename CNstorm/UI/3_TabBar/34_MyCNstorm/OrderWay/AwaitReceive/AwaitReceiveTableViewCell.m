//
//  AwaitReceiveTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-17.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "AwaitReceiveTableViewCell.h"

@implementation AwaitReceiveTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.wayTitelLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 5.0f, 250.0f, 40.0f)];
        self.wayTitelLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:(1.0f)];
        self.wayTitelLabel.font = [UIFont systemFontOfSize:14.0f];
        self.wayTitelLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.wayTitelLabel.numberOfLines = 2;
        self.wayTitelLabel.textAlignment = NSTextAlignmentLeft;
        self.wayTitelLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.wayTitelLabel];
        
        self.isCancelButton = [[UIButton alloc]initWithFrame:CGRectMake(280.0f, 10.0f, 30.0f, 25.0f)];
        self.isCancelButton.hidden = YES;
        [self.isCancelButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.isCancelButton setTitleColor:[UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        self.isCancelButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:self.isCancelButton];
        
        self.wayPackageCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 45.0f, 200.0f, 18.0f)];
        self.wayPackageCountLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.wayPackageCountLabel.font = [UIFont systemFontOfSize:13.0f];
        self.wayPackageCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.wayPackageCountLabel.numberOfLines = 1;
        self.wayPackageCountLabel.textAlignment = NSTextAlignmentLeft;
        self.wayPackageCountLabel.adjustsFontSizeToFitWidth = YES;
        self.wayPackageCountLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.wayPackageCountLabel];
        
        self.yunfeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 63.0f, 40.0f, 18.0f)];
        self.yunfeiLabel.text = @"运费:";
        self.yunfeiLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.yunfeiLabel.font = [UIFont systemFontOfSize:13.0f];
        self.yunfeiLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.yunfeiLabel.numberOfLines = 1;
        self.yunfeiLabel.textAlignment = NSTextAlignmentLeft;
        self.yunfeiLabel.adjustsFontSizeToFitWidth = YES;
        self.yunfeiLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.yunfeiLabel];
        
        self.yunfeiInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(50.0f, 63.0f, 150.0f, 18.0f)];
        self.yunfeiInfoLabel.textColor = [UIColor colorWithRed:(253.0f/255.0f) green:(78.0f/255.0f) blue:(46.0f/255.0f) alpha:1.0f];
        self.yunfeiInfoLabel.font = [UIFont systemFontOfSize:13.0f];
        self.yunfeiInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.yunfeiInfoLabel.numberOfLines = 1;
        self.yunfeiInfoLabel.textAlignment = NSTextAlignmentLeft;
        self.yunfeiInfoLabel.adjustsFontSizeToFitWidth = YES;
        self.yunfeiInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.yunfeiInfoLabel];
        
        self.wayStatusButton = [[UIButton alloc]initWithFrame:CGRectMake(240.0f, 45.0f, 70.0f, 30.0f)];
        [self.wayStatusButton setTitle:@"" forState:UIControlStateNormal];
        self.wayStatusButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [self.wayStatusButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        self.wayStatusButton.backgroundColor = [UIColor colorWithRed:(240.0f)/255.0f green:(240.0f)/255.0f blue:(240.0f)/255.0f alpha:1];
        [self.wayStatusButton.layer setCornerRadius:3.0f];
        self.wayStatusButton.layer.borderWidth = 0.5f;
        self.wayStatusButton.layer.borderColor = [UIColor colorWithRed:(200.0f)/255.0f green:(200.0f)/255.0f blue:(200.0f)/255.0f alpha:1].CGColor;
        [self.contentView addSubview:self.wayStatusButton];
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
    
    self.wayTitelLabel.text = self.way.wayTitel;
    
    self.yunfeiInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",self.way.yunfei];
    
    self.wayPackageCountLabel.text = [NSString stringWithFormat:@"%d个订单/共%d件商品",self.way.wayPackageCount,self.way.wayGoodsTypeCount];
    
    
    NSString *wayStatusButtonTitle = nil;
    
    if (self.way.wayStatus == 0)
    {
        wayStatusButtonTitle = @"立即付款";
    }
    else if (self.way.wayStatus == 1)
    {
        wayStatusButtonTitle = @"待发货";
    }
    else if (self.way.wayStatus == 2)
    {
        wayStatusButtonTitle = @"待收货";
    }
    else if (self.way.wayStatus == 3)
    {
        wayStatusButtonTitle = @"已确认收货";
    }
    else if (self.way.wayStatus == 4)
    {
        wayStatusButtonTitle = @"无效订单";
    }
    else if (self.way.wayStatus == 5)
    {
        wayStatusButtonTitle = @"待发货";
    }
    else if (self.way.wayStatus == 6)
    {
        wayStatusButtonTitle = @"待补交运费";
    }
    else if (self.way.wayStatus == 7)
    {
        wayStatusButtonTitle = @"信息不全";
    }
    else
    {
        wayStatusButtonTitle = @"已评价";
    }
    
    [self.wayStatusButton setTitle:wayStatusButtonTitle forState:UIControlStateNormal];
    
    if (self.way.wayStatus == 0)
    {
        [self.wayStatusButton setTitleColor:[UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        self.wayStatusButton.backgroundColor = [UIColor colorWithRed:(255.0f)/255.0f green:(219.0f)/255.0f blue:(61.0f)/255.0f alpha:1];
        self.wayStatusButton.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(195.0f)/255.0f blue:(39.0f)/255.0f alpha:1].CGColor;
    }
    else
    {
        [self.wayStatusButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        self.wayStatusButton.backgroundColor = [UIColor colorWithRed:(240.0f)/255.0f green:(240.0f)/255.0f blue:(240.0f)/255.0f alpha:1];
        self.wayStatusButton.layer.borderColor = [UIColor colorWithRed:(200.0f)/255.0f green:(200.0f)/255.0f blue:(200.0f)/255.0f alpha:1].CGColor;
    }
}

@end