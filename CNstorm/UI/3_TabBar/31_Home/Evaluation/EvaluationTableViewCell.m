//
//  EvaluationTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "EvaluationTableViewCell.h"

@implementation EvaluationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.avaterImageView = [[PPAImageView alloc]initWithFrame:CGRectMake(15.0f, 10.0f, 45.0f, 45.0f) backgroundProgressColor:[UIColor whiteColor] progressColor:[UIColor lightGrayColor]];
        [self.contentView addSubview: self.avaterImageView];
        
        self.nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70.0f, 8.0f, 110.0f, 20.0f)];
        self.nickNameLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.nickNameLabel.font = [UIFont systemFontOfSize:14.0f];
        self.nickNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.nickNameLabel.numberOfLines = 1;
        self.nickNameLabel.textAlignment = NSTextAlignmentLeft;
        self.nickNameLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.nickNameLabel];
        
        self.memberGradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(180.0f, 8.0f, 70.0f, 20.0f)];
        self.memberGradeLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.memberGradeLabel.font = [UIFont systemFontOfSize:14.0f];
        self.memberGradeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.memberGradeLabel.numberOfLines = 1;
        self.memberGradeLabel.textAlignment = NSTextAlignmentLeft;
        self.memberGradeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.memberGradeLabel];
        
        self.countryLabel = [[UILabel alloc]initWithFrame:CGRectMake(238.0f, 8.0f, 78.0f, 20.0f)];
        self.countryLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.countryLabel.font = [UIFont systemFontOfSize:13.0f];
        self.countryLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.countryLabel.numberOfLines = 1;
        self.countryLabel.textAlignment = NSTextAlignmentRight;
        self.countryLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.countryLabel];
        
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(70.0f, 30.0f, 235.0f, 35.0f)];
        self.contentLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.contentLabel.font = [UIFont systemFontOfSize:13.0];
        self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.contentLabel.numberOfLines = 2;
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.contentLabel];
        
        self.replyLabel = [[UILabel alloc]initWithFrame:CGRectMake(70.0f, 65.0f, 235.0f, 35.0f)];
        self.replyLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f];
        self.replyLabel.font = [UIFont systemFontOfSize:13.0];
        self.replyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.replyLabel.numberOfLines = 2;
        self.replyLabel.textAlignment = NSTextAlignmentLeft;
        self.replyLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.replyLabel];
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
    
    [self.avaterImageView setImageURL:self.evaluation.imageUrl];
    self.memberGradeLabel.text = [NSString stringWithFormat:@"等级:V%@",self.evaluation.memberGrade];
    self.nickNameLabel.text = self.evaluation.nickName;
    self.countryLabel.text = self.evaluation.country;
    self.contentLabel.text = self.evaluation.content;
    self.replyLabel.text = self.evaluation.reply;
    
    self.evaluation.content = [self.evaluation.content stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    
    CGSize evaluationContentSize = [self.evaluation.content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]}];
    
    if(evaluationContentSize.width >= 2*235.0f)
    {
        NSInteger addNumberOfLines = 0;
        double yushu = fmod(evaluationContentSize.width-2*235.0f,235.0f);
        if (yushu == 0.0f)
        {
            addNumberOfLines = (NSInteger)((evaluationContentSize.width-2*235.0f)/235.0f);
        }
        else
        {
            addNumberOfLines = (NSInteger)((evaluationContentSize.width-2*235.0f)/235.0f+1);
        }
        self.contentLabel.numberOfLines = 2+addNumberOfLines;
        self.contentLabel.frame = CGRectMake(70.0f, 30.0f, 235.0f, self.contentLabel.numberOfLines*evaluationContentSize.height);
    }
    else
    {
        self.contentLabel.numberOfLines = 2;
        self.contentLabel.frame = CGRectMake(70.0f, 30.0f, 235.0f,evaluationContentSize.height*2);
    }
    
    CGSize evaluationReplySize = [self.evaluation.reply sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]}];
    
    if(evaluationReplySize.width >= 235.0f)
    {
        NSInteger addNumberOfLines = 0;
        double yushu = fmod(evaluationReplySize.width-235.0f,235.0f);
        if (yushu == 0.0f)
        {
            addNumberOfLines = (NSInteger)((evaluationReplySize.width-235.0f)/235.0f);
        }
        else
        {
            addNumberOfLines = (NSInteger)((evaluationReplySize.width-235.0f)/235.0f+1);
        }
        self.replyLabel.numberOfLines = 1+addNumberOfLines;
        self.replyLabel.frame = CGRectMake(70.0f, 35.0f+self.contentLabel.frame.size.height, 235.0f, self.replyLabel.numberOfLines*evaluationReplySize.height);
    }
    else
    {
        self.replyLabel.numberOfLines = 1;
        self.replyLabel.frame = CGRectMake(70.0f, 35.0f+self.contentLabel.frame.size.height, 235.0f, evaluationReplySize.height);
    }
}

@end
