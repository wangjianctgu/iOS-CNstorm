//
//  BATableViewHeaderView.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "BATableViewHeaderView.h"

@implementation BATableViewHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor colorWithRed:(230.0f/255.0f) green:(230.0f/255.0f) blue:(230.0f/255.0f) alpha:1.0f];
        
        self.titleIndexLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 0.0f, 200.0f, 30.0f)];
        self.titleIndexLabel.text = @"titleIndex";
        self.titleIndexLabel.textColor = [UIColor colorWithRed:(128.0f/255.0f) green:(128.0f/255.0f) blue:(128.0f/255.0f) alpha:1.0f];
        self.titleIndexLabel.font = [UIFont systemFontOfSize:15.0f];
        self.titleIndexLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.titleIndexLabel.numberOfLines = 1;
        self.titleIndexLabel.textAlignment = NSTextAlignmentLeft;
        self.titleIndexLabel.adjustsFontSizeToFitWidth = YES;
        self.titleIndexLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.titleIndexLabel];
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
