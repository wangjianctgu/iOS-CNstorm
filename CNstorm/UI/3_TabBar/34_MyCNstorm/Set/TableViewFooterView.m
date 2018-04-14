//
//  TableViewFooterView.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-12.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "TableViewFooterView.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@implementation TableViewFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.loginOutButton = [[UIButton alloc]initWithFrame:CGRectMake(11.0f, 100.0f, 298.0f, 40.0f)];
        self.loginOutButton.backgroundColor = RGBCOLOR(233.0f,64.0f,86.0f);
        [self.loginOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        self.loginOutButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.loginOutButton.layer setCornerRadius:3.0f];
        [self addSubview:self.loginOutButton];
        
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
