//
//  SearchTableViewFooterView.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-15.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "SearchTableViewFooterView.h"

@implementation SearchTableViewFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1.0f];
        
        self.btn = [[UIButton alloc]initWithFrame:CGRectMake(110.0f, 20.0f, 100.0f,30.0f)];
        [self.contentView addSubview:self.btn];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
