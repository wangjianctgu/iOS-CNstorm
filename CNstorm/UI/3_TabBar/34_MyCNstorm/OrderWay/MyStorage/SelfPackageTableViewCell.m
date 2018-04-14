//
//  SelfPackageTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-17.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "SelfPackageTableViewCell.h"

@implementation SelfPackageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.isSensitiveButton = [[UIButton alloc]initWithFrame:CGRectMake(14.0f, 10.0f, 12.5f, 14.0f)];
        [self.isSensitiveButton setImage:[UIImage imageNamed:@"sensitive"] forState:UIControlStateNormal];
        self.isSensitiveButton.hidden = YES;
        [self.contentView addSubview:self.isSensitiveButton];
        
        self.isSelectedButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 32.5f, 20.0f, 20.0f)];
        [self.isSelectedButton setBackgroundImage:[UIImage imageNamed:@"uncheck_selected"] forState:UIControlStateSelected];
        [self.isSelectedButton setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        self.isSelectedButton.selected = NO;
        self.isSelectedButton.userInteractionEnabled = YES;
        [self.contentView addSubview: self.isSelectedButton];
        
        self.packageTitelLabel = [[UILabel alloc]initWithFrame:CGRectMake(40.0f, 0.0f, 215.0f, 30.0f)];
        self.packageTitelLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.packageTitelLabel.font = [UIFont systemFontOfSize:14.0f];
        self.packageTitelLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.packageTitelLabel.numberOfLines = 1;
        self.packageTitelLabel.textAlignment = NSTextAlignmentLeft;
        self.packageTitelLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.packageTitelLabel];
        
        self.packageWeightLabel = [[UILabel alloc]initWithFrame:CGRectMake(255.0f, 8.0f, 60.0f, 30.0f)];
        self.packageWeightLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.packageWeightLabel.font = [UIFont systemFontOfSize:12.0f];
        self.packageWeightLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.packageWeightLabel.numberOfLines = 2;
        self.packageWeightLabel.textAlignment = NSTextAlignmentRight;
        self.packageWeightLabel.adjustsFontSizeToFitWidth = YES;
        self.packageWeightLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.packageWeightLabel];
        
        self.packageRemarkLabel = [[MyLabel alloc]initWithFrame:CGRectMake(40.0f, 30.0f, 215.0f, 55.0f)];
        self.packageRemarkLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.packageRemarkLabel.font = [UIFont systemFontOfSize:13.0f];
        self.packageRemarkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.packageRemarkLabel.numberOfLines = 3;
        self.packageRemarkLabel.textAlignment = NSTextAlignmentLeft;
        [self.packageRemarkLabel setVerticalAlignment:VerticalAlignmentTop];
        self.packageRemarkLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.packageRemarkLabel];
        
        self.detailButton = [[UIButton alloc]initWithFrame:CGRectMake(265.0f, 50.0f, 45.0f, 25.0f)];
        [self.detailButton setTitle:@"详情" forState:UIControlStateNormal];
        self.detailButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [self.detailButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        self.detailButton.backgroundColor = [UIColor colorWithRed:(240.0f)/255.0f green:(240.0f)/255.0f blue:(240.0f)/255.0f alpha:1];
        [self.detailButton.layer setCornerRadius:3.0f];
        self.detailButton.layer.borderWidth = 0.5f;
        self.detailButton.layer.borderColor = [UIColor colorWithRed:(200.0f)/255.0f green:(200.0f)/255.0f blue:(200.0f)/255.0f alpha:1].CGColor;
        [self.contentView addSubview:self.detailButton];
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
    
    self.isSensitiveButton.hidden = !self.selfPackage.isSensitive;
    
    self.isSelectedButton.selected = self.selfPackage.isSelected;
    
    self.packageTitelLabel.text = self.selfPackage.packageTitle;
    
    self.packageWeightLabel.text = [NSString stringWithFormat:@"%.2fg",self.selfPackage.packageWeight];
    
    self.packageRemarkLabel.text = [NSString stringWithFormat:@"%@",self.selfPackage.packageRemark];
}

@end