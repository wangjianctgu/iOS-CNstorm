//
//  PayRecordTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-25.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "PayRecordTableViewCell.h"

@implementation PayRecordTableViewCell

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
        self.accountmoneyLabel.font = [UIFont systemFontOfSize:14.0f];
        self.accountmoneyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.accountmoneyLabel.numberOfLines = 1;
        self.accountmoneyLabel.textAlignment = NSTextAlignmentRight;
        self.accountmoneyLabel.adjustsFontSizeToFitWidth = YES;
        self.accountmoneyLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.accountmoneyLabel];
        
        self.actionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 32.0f, 200.0f, 23.0f)];
        self.actionLabel.text = @"action";
        self.actionLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.actionLabel.font = [UIFont systemFontOfSize:15.0f];
        self.actionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.actionLabel.numberOfLines = 3;
        self.actionLabel.textAlignment = NSTextAlignmentLeft;
        self.actionLabel.adjustsFontSizeToFitWidth = YES;
        self.actionLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.actionLabel];
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(220.0f, 32.0f, 90.0f, 23.0f)];
        self.moneyLabel.text = @"money";
        self.moneyLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f];
        self.moneyLabel.font = [UIFont systemFontOfSize:15.0f];
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
    
    if (self.record)
    {
        //时间戳转成时间
        NSTimeInterval timeInterval = [[NSString stringWithFormat:@"%lld", self.record.addtime] doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        self.addTimeLabel.text = [self stringFromDate:date];
        
        //分类 type == 0全部，1代购，2运单，3调整
        
        //(action 1:购买商品 2:国内运费 3:国际运费 5:价格调整 9:账户充值）
        if (self.record.action == 1)
        {
            self.actionLabel.text = @"购买商品";
        }
        else if(self.record.action == 2)
        {
            self.actionLabel.text = @"代购订单";
        }
        else if(self.record.action == 3)
        {
            self.actionLabel.text = @"国际运单";
        }
        else if(self.record.action == 5)
        {
            self.actionLabel.text = @"价格调整";
        }
        else if(self.record.action == 9)
        {
            self.actionLabel.text = @"账户充值";
        }
        else
        {
            self.actionLabel.text = @"其它";
        }

        self.accountmoneyLabel.text = [NSString stringWithFormat:@"余额:%.2f", self.record.accountmoney];
        
        self.moneyLabel.text = [NSString stringWithFormat:@"%.2f", self.record.money];

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
