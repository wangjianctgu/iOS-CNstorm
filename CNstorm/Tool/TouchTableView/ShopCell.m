//
//  ShopCell.m
//  fanqieDian
//
//  Created by chenzhihui on 13-11-7.
//  Copyright (c) 2013年 chenzhihui. All rights reserved.
//

#import "ShopCell.h"

#import "UIImageView+WebCache.h"

@implementation ShopCell

#define SELECTEDBGCOLOR [UIColor colorWithPatternImage:[UIImage imageNamed:@"cm_center_sv_bg"]]

#define BGCOLOR [UIColor whiteColor]


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        UIView *viewBG=[[UIView alloc]init];
        self.viewBG=viewBG;
        [self addSubview:self.viewBG];
        
        self.myImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 60, 60)];
        self.myImageView.contentMode=UIViewContentModeScaleToFill;
        [self addSubview:self.myImageView];
        
        self.middleView=[[UIView alloc]initWithFrame:CGRectMake(90, 0, 220, self.frame.size.height)];
        self.middleView.backgroundColor=[UIColor clearColor];
        [self addSubview:self.middleView];
        
        self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 200, 30)];
        self.titleLabel.backgroundColor=[UIColor clearColor];
        self.titleLabel.font=[UIFont systemFontOfSize:16];
        [self.middleView addSubview:self.titleLabel];
        
        self.priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 40, 80,20)];
        self.priceLabel.font=[UIFont systemFontOfSize:13];
        self.priceLabel.backgroundColor=[UIColor clearColor];
        [self.middleView addSubview:self.priceLabel];
        
        self.numOfEatLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 40, 80,20)];
        self.numOfEatLabel.font=[UIFont systemFontOfSize:13];
        self.numOfEatLabel.backgroundColor=[UIColor clearColor];
        [self.middleView addSubview:self.numOfEatLabel];
        
        self.buyImageView=[[UIImageView alloc]initWithFrame:CGRectMake(250, 20, 30, 30)];
        self.buyImageView.image=[UIImage imageNamed:@"cm_center_discount"];
        self.buyImageView.contentMode=UIViewContentModeScaleToFill;
        [self addSubview:self.buyImageView];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)setInfoTitle:(NSString *)title andPrice:(NSString *)price andNum:(int)num andImageUrl:(NSString *)imageUrl andBuyed:(BOOL)buyed
{
    self.titleLabel.text=title;
    
    self.priceLabel.text=price;
    
    self.numOfEatLabel.text=[NSString stringWithFormat:@"%d",num];
    
    [self.myImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"cm_center_nutrition_3"]];
    
    self.viewBG.frame=CGRectMake(0, 0, 320, 80);
    
    if (buyed)
    {
        self.buyImageView.alpha=1;
        self.middleView.frame=CGRectMake(80, 0, 220, self.frame.size.height);
        self.contentView.backgroundColor=SELECTEDBGCOLOR;
        
    }
    else
    {
        self.buyImageView.alpha=0;
        self.middleView.frame=CGRectMake(90, 0, 220, self.frame.size.height);
        self.contentView.backgroundColor=[UIColor clearColor];
    }
    
    //重绘Cell
    [self setNeedsDisplay];
   
}
-(void)buyAnimation
{
    [UIView beginAnimations:@"buy" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    self.middleView.frame=CGRectMake(80, 0, 220, self.frame.size.height);
    self.buyImageView.alpha=1;
    [UIView commitAnimations];
    self.contentView.backgroundColor=SELECTEDBGCOLOR;
   
}

-(void)notbuyAnimation
{
    [UIView animateWithDuration:0.5 animations:^{
        self.middleView.frame=CGRectMake(90, 0, 220, self.frame.size.height);
        self.buyImageView.alpha=0;
    } completion:^(BOOL finished) {
        self.contentView.backgroundColor=[UIColor clearColor];
       
    }];
    
}
@end
