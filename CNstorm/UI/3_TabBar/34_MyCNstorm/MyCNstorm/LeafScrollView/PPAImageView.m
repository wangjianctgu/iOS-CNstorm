//
//  PPAImageView.m
//  AvatarImageView
//
//  Created by Zhang Lisheng on 14-6-7.
//  Copyright (c) 2014年 <https://github.com/cheng534078182>. All rights reserved.
//

#import "PPAImageView.h"

#pragma mark - Utils

#define rad(degrees) ((degrees) / (180.0 / M_PI))
#define kLineWidth 3.f

@interface PPAImageView ()

@property (nonatomic, strong) CAShapeLayer *backgroundLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, strong) UIImageView *containerImageView;
@property (nonatomic, strong) UIView      *progressContainer;

@end

@implementation PPAImageView

- (id)initWithFrame:(CGRect)frame
{
    return [[PPAImageView alloc] initWithFrame:frame
                      backgroundProgressColor:[UIColor whiteColor]
                                progressColor:[UIColor colorWithRed:240/255.f green:85/255.f blue:97/255.f alpha:1.f]];
}

- (id)initWithFrame:(CGRect)frame backgroundProgressColor:(UIColor *)backgroundProgresscolor progressColor:(UIColor *)progressColor
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius     = CGRectGetWidth(self.bounds)/2.f;
        self.layer.masksToBounds    = NO;
        self.clipsToBounds          = YES;
        
        CGPoint arcCenter           = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGFloat radius              = MIN(CGRectGetMidX(self.bounds)-1, CGRectGetMidY(self.bounds)-1);
        
        UIBezierPath *circlePath    = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                                     radius:radius
                                                                 startAngle:-rad(90)
                                                                   endAngle:rad(360-90)
                                                                  clockwise:YES];
        
        _backgroundLayer = [CAShapeLayer layer];
        _backgroundLayer.path           = circlePath.CGPath;
        _backgroundLayer.strokeColor    = [backgroundProgresscolor CGColor];
        _backgroundLayer.fillColor      = [[UIColor clearColor] CGColor];
        _backgroundLayer.lineWidth      = kLineWidth;
        
        
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.path         = _backgroundLayer.path;
        _progressLayer.strokeColor  = [progressColor CGColor];
        _progressLayer.fillColor    = _backgroundLayer.fillColor;
        _progressLayer.lineWidth    = _backgroundLayer.lineWidth;
        _progressLayer.strokeEnd    = 0.f;
        
        
        _progressContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _progressContainer.layer.cornerRadius   = CGRectGetWidth(self.bounds)/2.f;
        _progressContainer.layer.masksToBounds  = NO;
        _progressContainer.clipsToBounds        = YES;
        _progressContainer.backgroundColor      = [UIColor clearColor];
        
        _containerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, frame.size.width-2, frame.size.height-2)];
        _containerImageView.layer.cornerRadius = CGRectGetWidth(self.bounds)/2.f;
        _containerImageView.layer.masksToBounds = NO;
        _containerImageView.clipsToBounds = YES;
        _containerImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [_progressContainer.layer addSublayer:_backgroundLayer];
        [_progressContainer.layer addSublayer:_progressLayer];
        
        [self addSubview:_containerImageView];
        [self addSubview:_progressContainer];
    }
    return self;
}

- (void)setImageURL:(NSString *)imageUrl
{
    [_containerImageView setImageURLStr:imageUrl placeholder:[UIImage imageNamed:@"default60.png"]];
}

@end
