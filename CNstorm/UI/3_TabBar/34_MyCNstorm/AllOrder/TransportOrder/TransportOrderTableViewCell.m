//
//  TransportOrderTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-14.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "TransportOrderTableViewCell.h"

@implementation TransportOrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.orderTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 225.0f, 30.0f)];
        self.orderTitleLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:(1.0f)];
        self.orderTitleLabel.font = [UIFont systemFontOfSize:14.0f];
        self.orderTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.orderTitleLabel.numberOfLines = 1;
        self.orderTitleLabel.textAlignment = NSTextAlignmentLeft;
        self.orderTitleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.orderTitleLabel];
        
        self.isCancelButton = [[UIButton alloc]initWithFrame:CGRectMake(280.0f, 10.0f, 30.0f, 25.0f)];
        [self.isCancelButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.isCancelButton setTitleColor:[UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        self.isCancelButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        self.isCancelButton.hidden = YES;
        [self.contentView addSubview:self.isCancelButton];
        
        self.orderRemarkLabel = [[MyLabel alloc]initWithFrame:CGRectMake(20.0f, 30.0f, 200.0f, 60.0f)];
        self.orderRemarkLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.orderRemarkLabel.font = [UIFont systemFontOfSize:13.0f];
        self.orderRemarkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.orderRemarkLabel.numberOfLines = 3;
        self.orderRemarkLabel.textAlignment = NSTextAlignmentLeft;
        [self.orderRemarkLabel setVerticalAlignment:VerticalAlignmentTop];
        self.orderRemarkLabel.adjustsFontSizeToFitWidth = YES;
        self.orderRemarkLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.orderRemarkLabel];
        
        self.orderStatusButton = [[UIButton alloc]initWithFrame:CGRectMake(240.0f, 50.0f, 70.0f, 30.0f)];
        [self.orderStatusButton setTitle:@"" forState:UIControlStateNormal];
        self.orderStatusButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [self.orderStatusButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        self.orderStatusButton.backgroundColor = [UIColor colorWithRed:(240.0f)/255.0f green:(240.0f)/255.0f blue:(240.0f)/255.0f alpha:1];
        [self.orderStatusButton.layer setCornerRadius:3.0f];
        self.orderStatusButton.layer.borderWidth = 0.5f;
        self.orderStatusButton.layer.borderColor = [UIColor colorWithRed:(200.0f)/255.0f green:(200.0f)/255.0f blue:(200.0f)/255.0f alpha:1].CGColor;
        [self.contentView addSubview:self.orderStatusButton];
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
    
    self.orderTitleLabel.text = self.transportOrder.orderTitle;
    self.orderRemarkLabel.text = self.transportOrder.orderRemark;
    
    NSString *orderStatusButtonTitle = @"";
    if (self.transportOrder.orderStatus == 1)
    {
        orderStatusButtonTitle = @"立即付款";//待付款
    }
    else if (self.transportOrder.orderStatus == 2)
    {
        orderStatusButtonTitle = @"待发货";//已付款
    }
    else if (self.transportOrder.orderStatus == 3)
    {
        orderStatusButtonTitle = @"待发货";
    }
    else if (self.transportOrder.orderStatus ==4)
    {
        orderStatusButtonTitle = @"待收货";//已发货
    }
    else if (self.transportOrder.orderStatus ==5)
    {
        orderStatusButtonTitle = @"待收货";//待入库
    }
    else if (self.transportOrder.orderStatus ==6)
    {
        orderStatusButtonTitle = @"已确认收货";//已入库
    }
    else if (self.transportOrder.orderStatus ==7)
    {
        orderStatusButtonTitle = @"缺货";
    }
    else if (self.transportOrder.orderStatus ==8)
    {
        orderStatusButtonTitle = @"已提交运送";
    }
    else if (self.transportOrder.orderStatus ==9)
    {
        orderStatusButtonTitle = @"待确认费用";
    }
    [self.orderStatusButton setTitle:orderStatusButtonTitle forState:UIControlStateNormal];
    
    if (self.transportOrder.orderStatus == 1)
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
