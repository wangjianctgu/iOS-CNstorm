//
//  AskTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-9-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "AskTableViewCell.h"

@implementation AskTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.askContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f,0.0f, 300.0f, 30.0f)];
        self.askContentLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.askContentLabel.font = [UIFont systemFontOfSize:13.0];
        self.askContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.askContentLabel.numberOfLines = 2;
        self.askContentLabel.textAlignment = NSTextAlignmentLeft;
        self.askContentLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.askContentLabel];
        
        self.answerContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 30.0f, 300.0f, 30.0f)];
        self.answerContentLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f];
        self.answerContentLabel.font = [UIFont systemFontOfSize:13.0];
        self.answerContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.answerContentLabel.numberOfLines = 1;
        self.answerContentLabel.textAlignment = NSTextAlignmentLeft;
        self.answerContentLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.answerContentLabel];
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
    
    self.askContentLabel.text = self.askMessage.askContent;
    self.answerContentLabel.text = self.askMessage.answerContent;
    
    CGSize askContentSize = [self.askMessage.askContent sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]}];
    
    if(askContentSize.width > 2*300.0f)
    {
        NSInteger addNumberOfLines = 0;
        
        double yushu = fmod(askContentSize.width-2*300.0f,300.0f);
        
        if (yushu == 0.0f)
        {
            addNumberOfLines = (NSInteger)((askContentSize.width-2*300.0f)/300.0f);
        }
        else
        {
            addNumberOfLines = (NSInteger)((askContentSize.width-2*300.0f)/300.0f+1);
        }
        
        self.askContentLabel.numberOfLines = 2+addNumberOfLines;
        self.askContentLabel.frame = CGRectMake(10.0f, 0.0f, 300.0f, self.askContentLabel.numberOfLines*askContentSize.height);
    }
    else
    {
        self.askContentLabel.numberOfLines = 2;
        self.askContentLabel.frame = CGRectMake(10.0f, 0.0f, 300.0f,askContentSize.height*2);
    }
    
    CGSize answerContentSize = [self.askMessage.answerContent sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]}];
    
    if(answerContentSize.width > 300.0f)
    {
        NSInteger addNumberOfLines = 0;
        
        double yushu = fmod(answerContentSize.width-300.0f,300.0f);
        
        if (yushu == 0.0f)
        {
            addNumberOfLines = (NSInteger)((answerContentSize.width-300.0f)/300.0f);
        }
        else
        {
            addNumberOfLines = (NSInteger)((answerContentSize.width-300.0f)/300.0f+1);
        }
        
        self.answerContentLabel.numberOfLines = 2+addNumberOfLines;
        
        self.answerContentLabel.frame = CGRectMake(10.0f, self.askContentLabel.frame.size.height, 300.0f, self.answerContentLabel.numberOfLines*answerContentSize.height);
    }
    else
    {
        self.answerContentLabel.numberOfLines = 2;
        self.answerContentLabel.frame = CGRectMake(10.0f, self.askContentLabel.frame.size.height, 300.0f, answerContentSize.height);
    }
}

@end

