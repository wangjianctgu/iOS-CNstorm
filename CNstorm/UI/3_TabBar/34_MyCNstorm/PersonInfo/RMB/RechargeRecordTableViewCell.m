//
//  RechargeRecordTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "RechargeRecordTableViewCell.h"

@implementation RechargeRecordTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.addTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 5.0f, 150.0f, 23.0f)];
        self.addTimeLabel.text = @"addTime";
        self.addTimeLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.addTimeLabel.font = [UIFont systemFontOfSize:13.0f];
        self.addTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.addTimeLabel.numberOfLines = 1;
        self.addTimeLabel.textAlignment = NSTextAlignmentLeft;
        self.addTimeLabel.adjustsFontSizeToFitWidth = YES;
        self.addTimeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.addTimeLabel];
        
        self.accountmoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(160.0f, 5.0f, 150.0f, 23.0f)];
        self.accountmoneyLabel.text = @"accountmoney";
        self.accountmoneyLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.accountmoneyLabel.font = [UIFont systemFontOfSize:13.0f];
        self.accountmoneyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.accountmoneyLabel.numberOfLines = 1;
        self.accountmoneyLabel.textAlignment = NSTextAlignmentRight;
        self.accountmoneyLabel.adjustsFontSizeToFitWidth = YES;
        self.accountmoneyLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.accountmoneyLabel];
        
        self.paytypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 32.0f, 130.0f, 23.0f)];
        self.paytypeLabel.text = @"paytype";
        self.paytypeLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.paytypeLabel.font = [UIFont systemFontOfSize:13.0f];
        self.paytypeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.paytypeLabel.numberOfLines = 2;
        self.paytypeLabel.textAlignment = NSTextAlignmentLeft;
        self.paytypeLabel.adjustsFontSizeToFitWidth = YES;
        self.paytypeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.paytypeLabel];
        
        self.amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(130.0f, 32.0f, 90.0f, 23.0f)];
        self.amountLabel.text = @"amount";
        self.amountLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.amountLabel.font = [UIFont systemFontOfSize:13.0f];
        self.amountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.amountLabel.numberOfLines = 1;
        self.amountLabel.textAlignment = NSTextAlignmentLeft;
        self.amountLabel.adjustsFontSizeToFitWidth = YES;
        self.amountLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.amountLabel];
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(220.0f, 32.0f, 90.0f, 23.0f)];
        self.moneyLabel.text = @"money";
        self.moneyLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f];
        self.moneyLabel.font = [UIFont systemFontOfSize:13.0f];
        self.moneyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.moneyLabel.numberOfLines = 1;
        self.moneyLabel.textAlignment = NSTextAlignmentRight;
        self.moneyLabel.adjustsFontSizeToFitWidth = YES;
        self.moneyLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.moneyLabel];
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
    
    if (self.rechargeRecord)
    {
        //时间戳转成时间
        NSTimeInterval timeInterval = [[NSString stringWithFormat:@"%lld", self.rechargeRecord.addtime] doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        self.addTimeLabel.text = [self stringFromDate:date];
        
        //0转账,1paypal,2支付宝，3支付宝国际信用卡,4其他
        
        if (self.rechargeRecord.paytype == 0)
        {
            self.paytypeLabel.text = @"转账";
        }
        else if(self.rechargeRecord.paytype == 1)
        {
            self.paytypeLabel.text = @"PayPal充值";
        }
        else if(self.rechargeRecord.paytype == 2)
        {
            self.paytypeLabel.text = @"支付宝充值";
        }
        else if(self.rechargeRecord.paytype == 3)
        {
            self.paytypeLabel.text = @"国际信用卡充值";
        }
        else
        {
            self.paytypeLabel.text = @"其他";
        }
        
        self.accountmoneyLabel.text = [NSString stringWithFormat:@"余额:¥%.2f", self.rechargeRecord.accountmoney];
        
        self.amountLabel.text = [NSString stringWithFormat:@"充值:¥%.2f", self.rechargeRecord.amount];
        
        self.moneyLabel.text = [NSString stringWithFormat:@"到账:¥%.2f", self.rechargeRecord.money];
    }
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