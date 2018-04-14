//
//  JSBadgeButton.m
//  NGTabBarController
//
//  Created by EBS1 on 13-5-18.
//  Copyright (c) 2013年 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "JSBadgeButton.h"

@implementation JSBadgeButton

@synthesize badgeView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.badgeView = [[JSBadgeView alloc] initWithFrame:CGRectZero];
        self.badgeView.badgeAlignment = JSBadgeViewAlignmentTopRight;
        [self addSubview:self.badgeView];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.badgeView = [[JSBadgeView alloc] initWithFrame:CGRectZero];
    self.badgeView.badgeAlignment = JSBadgeViewAlignmentTopRight;
    [self addSubview:self.badgeView];
}

@end
