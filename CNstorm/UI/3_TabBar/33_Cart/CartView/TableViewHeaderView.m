//
//  TableViewHeaderView.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "TableViewHeaderView.h"

@implementation TableViewHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor colorWithRed:(255.0f)/255.0f green:(255.0f)/255.0f blue:(255.0f)/255.0f alpha:(1.0f)];
        self.contentView.layer.borderWidth = 0.5f;
        self.contentView.layer.borderColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)].CGColor;
        
        self.selectedButton = [[UIButton alloc]initWithFrame:CGRectMake(5.0f, 8.75f, 20.0f, 20.0f)];
        self.selectedButton.selected = YES;
        [self addSubview:self.selectedButton];
        
        self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 5.0f, 185.0f, 25.0f)];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
