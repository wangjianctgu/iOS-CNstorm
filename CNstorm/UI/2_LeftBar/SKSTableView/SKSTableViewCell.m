//
//  SKSTableViewCell.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "SKSTableViewCell.h"
#import "SKSTableViewCellIndicator.h"

#define kIndicatorViewTag -1
#define kArrowViewTag -2

@interface SKSTableViewCell ()

@end

@implementation SKSTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setIsExpandable:NO];
        [self setIsExpanded:NO];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.isExpanded) {
        
        if (![self containsIndicatorView]) {
            [self addIndicatorView];
        }
        else {
            [self removeIndicatorView];
            [self addIndicatorView];
        }
    }
}

static UIImage *_image = nil;
- (UIView *)expandableView
{
    if (!_image) {
        _image = [UIImage imageNamed:@"expandableImage.png"];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, _image.size.width, _image.size.height);
    button.frame = frame;
    
    [button setBackgroundImage:_image forState:UIControlStateNormal];
    
    return button;
}

- (void)setIsExpandable:(BOOL)isExpandable
{
    if (isExpandable)
        [self setAccessoryView:[self expandableView]];
    
    _isExpandable = isExpandable;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)addIndicatorView
{
    CGPoint point = self.accessoryView.center;
    CGRect bounds = self.accessoryView.bounds;
    
    //修改cell 阴影箭头位置和大小
    CGRect frame = CGRectMake((point.x - CGRectGetWidth(bounds) * 20), point.y * 1.7, CGRectGetWidth(bounds) * 1.7, CGRectGetHeight(self.bounds) - point.y * 1.7);
    
    SKSTableViewCellIndicator *indicatorView = [[SKSTableViewCellIndicator alloc] initWithFrame:frame];
    
    indicatorView.tag = kIndicatorViewTag;
    
    [self.contentView addSubview:indicatorView];
}

- (void)removeIndicatorView
{
    id indicatorView = [self.contentView viewWithTag:kIndicatorViewTag];
    [indicatorView removeFromSuperview];
}

- (BOOL)containsIndicatorView
{
    return [self.contentView viewWithTag:kIndicatorViewTag] ? YES : NO;
}

- (void)addArrowView
{
    CGPoint point = self.accessoryView.center;
    CGRect bounds = self.accessoryView.bounds;
    
    //修改cell 箭头位置
    if (!_image) {
        _image = [UIImage imageNamed:@"expandableImage.png"];
    }
    
    UIButton *arrowView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGRect arrowViewframe = CGRectMake((point.x - CGRectGetWidth(bounds) * 30), point.y * 1.0, _image.size.width, _image.size.height);
    
    arrowView.frame = arrowViewframe;
    
    [arrowView setBackgroundImage:_image forState:UIControlStateNormal];
    
    arrowView.tag = kArrowViewTag;
    
    [self.contentView addSubview:arrowView];

}

- (void)removeArrowView
{
    id arrowView = [self.contentView viewWithTag:kArrowViewTag];
    [arrowView removeFromSuperview];
}

- (BOOL)containsArrowView
{
    return [self.contentView viewWithTag:kArrowViewTag] ? YES : NO;
}

@end
