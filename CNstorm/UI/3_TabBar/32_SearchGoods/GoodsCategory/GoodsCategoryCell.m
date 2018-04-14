//
//  GoodsCategoryCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-4.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "GoodsCategoryCell.h"

#define kIndicatorViewTag -1
#define kShadowImageViewTag -2

@implementation GoodsCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self)
    {
        self.contentView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
        
        self.goodsCategoryImageView = [[UIImageView alloc] initWithFrame: CGRectMake(5.0f, 0.0f, 89.0f, 89.0f)];
        [self.contentView addSubview: self.goodsCategoryImageView];
        
        self.goodsCategoryNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(105.0f, 20.0f, 200.0f, 20.0f)];
        self.goodsCategoryNameLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.goodsCategoryNameLabel.font = [UIFont systemFontOfSize:17.0f];
        self.goodsCategoryNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.goodsCategoryNameLabel.numberOfLines = 1;
        self.goodsCategoryNameLabel.textAlignment = NSTextAlignmentLeft;
        self.goodsCategoryNameLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.goodsCategoryNameLabel];
        
        self.nextCategoryNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(105.0f, 42.0f, 200.0f, 40.0f)];
        self.nextCategoryNameLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        self.nextCategoryNameLabel.font = [UIFont systemFontOfSize:14.0f];
        self.nextCategoryNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.nextCategoryNameLabel.numberOfLines = 1;
        self.nextCategoryNameLabel.textAlignment = NSTextAlignmentLeft;
        self.nextCategoryNameLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.nextCategoryNameLabel];
        
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 89.0f, 320.0f, 1.0f)];
        self.lineView.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
        [self.contentView addSubview:self.lineView];
        
        self.shadowImageView = [[UIImageView alloc] initWithFrame: CGRectMake(85.0f,0.0f, 15.0f, 90.0f)];
        [self.shadowImageView setImage:[UIImage imageNamed:@"shadow"]];
        self.shadowImageView.tag = kShadowImageViewTag;
        [self.contentView addSubview: self.shadowImageView];

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
    
    [self.goodsCategoryImageView setFrame:self.goodsCategory.imagefram];
    [self.goodsCategoryImageView setImageURLStr:self.goodsCategory.image placeholder:[UIImage imageNamed:self.goodsCategory.image]];
    self.goodsCategoryImageView.clipsToBounds = YES;
    self.goodsCategoryImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.goodsCategoryNameLabel.text = self.goodsCategory.name;
    [self.goodsCategoryNameLabel setFrame:self.goodsCategory.namefram];
    self.goodsCategoryNameLabel.textColor = self.goodsCategory.nameColor;
    
    //拼接二级分类
    NSString *nextCategoryName;
    for (int i = 0; i<self.goodsCategory.goodsCategoryArray.count; i++)
    {
        if (i == 0)
        {
            nextCategoryName = ((GoodsCategory*)[self.goodsCategory.goodsCategoryArray objectAtIndex:i]).name;
        }
        else
        {
            nextCategoryName = [nextCategoryName stringByAppendingString:[NSString stringWithFormat:@"/%@", ((GoodsCategory*)[self.goodsCategory.goodsCategoryArray objectAtIndex:i]).name]];
        }
    }
    
    self.nextCategoryNameLabel.text = nextCategoryName;
    self.nextCategoryNameLabel.hidden = self.goodsCategory.isHiddenNextCategoryName;
    self.lineView.hidden = self.goodsCategory.isHiddenLineView;
    self.shadowImageView.hidden = !self.goodsCategory.isHiddenLineView;
    
    if (self.goodsCategory.isHiddenIndicator)
    {
        [self removeIndicatorView];
    }
    else
    {
        [self addIndicatorView];
    }
    
    if (self.sitePoint == -1)
    {
        [self.shadowImageView setFrame:CGRectMake(85.0f,-500.0f, 15.0f, 590.0f)];
    }
    else if (self.sitePoint == 1)
    {
        [self.shadowImageView setFrame:CGRectMake(85.0f,0.0f, 15.0f, 590.0f)];
    }
}

+ (id)cellFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)addIndicatorView
{
    //修改cell 阴影箭头位置和大小
    UIImageView *indicatorImageView = [[UIImageView alloc] initWithFrame: CGRectMake(85.0f, 0.0f, 15.0f, 90.0f)];
    [indicatorImageView setImage:[UIImage imageNamed:@"indicator"]];
    indicatorImageView.tag = kIndicatorViewTag;
    
    if (self.sitePoint == -1)
    {
        //设置向上延伸
        UIImage *img=[UIImage imageNamed:@"indicator"];
        img = [img stretchableImageWithLeftCapWidth:15.0f topCapHeight:1.0f];
        [indicatorImageView setFrame:CGRectMake(85.0f,-500.0f, 15.0f, 590.0f)];
        [indicatorImageView setImage:img];
    }
    else if (self.sitePoint == 1)
    {
        //设置向下延伸
        UIImage *img=[UIImage imageNamed:@"indicator"];
        img = [img stretchableImageWithLeftCapWidth:15.0f topCapHeight:89.0f];
        [indicatorImageView setFrame:CGRectMake(85.0f,0.0f, 15.0f, 590.0f)];
        [indicatorImageView setImage:img];
    }
    
    CATransition* transition = [CATransition animation];
    transition.duration = 1.0;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    //kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromRight;
    //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [indicatorImageView.layer addAnimation:transition forKey:nil];
    [self.contentView addSubview:indicatorImageView];
    
    UIImageView *shadowImageView = (UIImageView *)[self.contentView viewWithTag:kShadowImageViewTag];
    [shadowImageView.layer addAnimation:transition forKey:nil];
    [shadowImageView removeFromSuperview];
}

- (void)removeIndicatorView
{
    id indicatorView = [self.contentView viewWithTag:kIndicatorViewTag];
    [indicatorView removeFromSuperview];
}

@end
