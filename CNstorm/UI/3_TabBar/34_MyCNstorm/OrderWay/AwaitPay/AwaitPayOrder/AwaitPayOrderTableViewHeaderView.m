//
//  AwaitPayOrderTableViewHeaderView.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-16.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "AwaitPayOrderTableViewHeaderView.h"

@implementation AwaitPayOrderTableViewHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor colorWithRed:(255.0f)/255.0f green:(255.0f)/255.0f blue:(255.0f)/255.0f alpha:(1.0f)];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 32.0f, 300.0f, 1.0f)];
        lineView.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
        [self addSubview:lineView];
        
        self.storeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 260.0f, 32.0f)];
        self.storeNameLabel.font = [UIFont systemFontOfSize:15.0];
        self.storeNameLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.storeNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:self.storeNameLabel];
        
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(280.0f, 0.0f, 30.0f, 32.0f)];
        [self.cancelButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:[UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:self.cancelButton];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
