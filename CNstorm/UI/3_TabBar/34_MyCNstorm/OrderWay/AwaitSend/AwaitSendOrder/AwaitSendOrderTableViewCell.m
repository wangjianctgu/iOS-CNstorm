//
//  AwaitSendOrderTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-16.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "AwaitSendOrderTableViewCell.h"

@implementation AwaitSendOrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.orderImageView = [[UIImageView alloc] initWithFrame: CGRectMake(10.0f, 11.5f, 75.0f, 75.0f)];
        [self.contentView addSubview: self.orderImageView];
        
        self.orderTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 8.0f, 220.0f, 40.0f)];
        self.orderTitleLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:(1.0f)];
        self.orderTitleLabel.font = [UIFont systemFontOfSize:14.0f];
        self.orderTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.orderTitleLabel.numberOfLines = 2;
        self.orderTitleLabel.textAlignment = NSTextAlignmentLeft;
        self.orderTitleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.orderTitleLabel];
        
        self.orderGoodTypeCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 52.0f, 120.0f, 18.0f)];
        self.orderGoodTypeCountLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:(1.0f)];
        self.orderGoodTypeCountLabel.font = [UIFont systemFontOfSize:13.0f];
        self.orderGoodTypeCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.orderGoodTypeCountLabel.numberOfLines = 1;
        self.orderGoodTypeCountLabel.textAlignment = NSTextAlignmentLeft;
        self.orderGoodTypeCountLabel.adjustsFontSizeToFitWidth = YES;
        self.orderGoodTypeCountLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.orderGoodTypeCountLabel];
        
        self.orderAllCostLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 71.0f, 120.0f, 17.0f)];
        self.orderAllCostLabel.textColor = [UIColor colorWithRed:(253.0f/255.0f) green:(78.0f/255.0f) blue:(46.0f/255.0f) alpha:(1.0f)];
        self.orderAllCostLabel.font = [UIFont systemFontOfSize:13.0f];
        self.orderAllCostLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.orderAllCostLabel.numberOfLines = 1;
        self.orderAllCostLabel.textAlignment = NSTextAlignmentLeft;
        self.orderAllCostLabel.adjustsFontSizeToFitWidth = YES;
        self.orderAllCostLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.orderAllCostLabel];
        
        self.orderStatusButton = [[UIButton alloc]initWithFrame:CGRectMake(240.0f, 55.0f, 70.0f, 30.0f)];
        [self.orderStatusButton setTitle:@"" forState:UIControlStateNormal];
        self.orderStatusButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [self.orderStatusButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        self.orderStatusButton.backgroundColor = [UIColor colorWithRed:(240.0f)/255.0f green:(240.0f)/255.0f blue:(240.0f)/255.0f alpha:1];
        [self.orderStatusButton.layer setCornerRadius:3.0f];
        self.orderStatusButton.layer.borderWidth = 0.5f;
        self.orderStatusButton.layer.borderColor = [UIColor colorWithRed:(200.0f)/255.0f green:(200.0f)/255.0f blue:(200.0f)/255.0f alpha:1].CGColor;
        [self.contentView addSubview:self.orderStatusButton];
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 98.0f, 320.0f, 12.0f)];
        footerView.backgroundColor = [UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:(1.0f)];
        [self.contentView addSubview:footerView];
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
    
    [self.orderImageView setImageURLStr:self.replaceBuyOrder.orderImage  placeholder:[UIImage imageNamed:@"default75.png"]];
    self.orderImageView.clipsToBounds = YES;
    self.orderImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.orderTitleLabel.text = self.replaceBuyOrder.orderTitle;
    
    self.orderAllCostLabel.text = [NSString stringWithFormat:@"￥%.2f",self.replaceBuyOrder.orderAllCost];
    
    self.orderGoodTypeCountLabel.text = [NSString stringWithFormat:@"共%d件商品",self.replaceBuyOrder.orderGoodTypeCount];
    
    NSString *orderStatusButtonTitle = @"";
    if (self.replaceBuyOrder.orderStatus == 1)
    {
        orderStatusButtonTitle = @"立即付款";//待付款
    }
    else if (self.replaceBuyOrder.orderStatus == 2)
    {
        orderStatusButtonTitle = @"待发货";//已付款
    }
    else if (self.replaceBuyOrder.orderStatus == 3)
    {
        orderStatusButtonTitle = @"待发货";
    }
    else if (self.replaceBuyOrder.orderStatus ==4)
    {
        orderStatusButtonTitle = @"待收货";//已发货
    }
    else if (self.replaceBuyOrder.orderStatus ==5)
    {
        orderStatusButtonTitle = @"待收货";//待入库
    }
    else if (self.replaceBuyOrder.orderStatus ==6)
    {
        orderStatusButtonTitle = @"已确认收货";//已入库
    }
    else if (self.replaceBuyOrder.orderStatus ==7)
    {
        orderStatusButtonTitle = @"缺货";
    }
    else if (self.replaceBuyOrder.orderStatus ==8)
    {
        orderStatusButtonTitle = @"已提交运送";
    }
    else if (self.replaceBuyOrder.orderStatus ==9)
    {
        orderStatusButtonTitle = @"待确认费用";
    }
    
    [self.orderStatusButton setTitle:orderStatusButtonTitle forState:UIControlStateNormal];
    
    if (self.replaceBuyOrder.orderStatus == 1)
    {
        [self.orderStatusButton setTitleColor:[UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        self.orderStatusButton.backgroundColor = [UIColor colorWithRed:(255.0f)/255.0f green:(219.0f)/255.0f blue:(61.0f)/255.0f alpha:1];
        self.orderStatusButton.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(195.0f)/255.0f blue:(39.0f)/255.0f alpha:1].CGColor;
    }
    else
    {
        [self.orderStatusButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        self.orderStatusButton.backgroundColor = [UIColor colorWithRed:(240.0f)/255.0f green:(240.0f)/255.0f blue:(240.0f)/255.0f alpha:1];
        self.orderStatusButton.layer.borderColor = [UIColor colorWithRed:(200.0f)/255.0f green:(200.0f)/255.0f blue:(200.0f)/255.0f alpha:1].CGColor;
    }
}

@end
