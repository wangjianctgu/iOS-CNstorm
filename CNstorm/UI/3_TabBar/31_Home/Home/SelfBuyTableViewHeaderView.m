//
//  SelfBuyTableViewHeaderView.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-13.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "SelfBuyTableViewHeaderView.h"

@implementation SelfBuyTableViewHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:(255.0f)/255.0f green:(255.0f)/255.0f blue:(255.0f)/255.0f alpha:(1.0f)];
        self.contentView.layer.borderWidth = 0.5f;
        self.contentView.layer.borderColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)].CGColor;
        
        self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 5.0f, 200.0f, 25.0f)];
        self.headerLabel.font = [UIFont systemFontOfSize:15.0];
        self.headerLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:(1.0f)];
        self.headerLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:self.headerLabel];
        
        //运费
        self.yunfeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(215.0f, 5.0f, 100.0f, 25.0f)];
        self.yunfeiLabel.textAlignment = NSTextAlignmentRight;
        self.yunfeiLabel.textColor = [UIColor colorWithRed:(253.0f)/255.0f green:(78.0f)/255.0f blue:(46.0f)/255.0f alpha:1];
        self.yunfeiLabel.font = [UIFont systemFontOfSize:13.0f];
        self.yunfeiLabel.numberOfLines = 1;
        [self addSubview:self.yunfeiLabel];
    }
    return self;
}

@end
