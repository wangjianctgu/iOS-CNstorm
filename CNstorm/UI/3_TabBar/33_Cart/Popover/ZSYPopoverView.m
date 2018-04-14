//
//  ZSYPopoverView.m
//  MyCustomTableViewForSelected
//
//  Created by Zhang Lisheng on 14-7-18.
//  Copyright (c) 2014年 zhu shouyu. All rights reserved.
//

#import "ZSYPopoverView.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static const CGFloat ZSYCustomButtonHeight = 40;

static const char *const kZSYPopoverListButtonClickForCancel = "kZSYPopoverListButtonClickForCancel";
static const char *const kZSYPopoverListButtonClickForDone = "kZSYPopoverListButtonClickForDone";

@interface ZSYPopoverView ()

@property (nonatomic, strong) UIButton *doneButton;                      //确定选择按钮
@property (nonatomic, strong) UIButton *cancelButton;                    //取消选择按钮
@property (nonatomic, strong) UIControl *controlForDismiss;              //没有按钮的时候，才会使用这个


//初始化界面
- (void)initTheInterface;

//动画进入
- (void)animatedIn;

//动画消失
- (void)animatedOut;

//展示界面
- (void)show;

//消失界面
- (void)dismiss;

@end


@implementation ZSYPopoverView

@synthesize doneButton = _doneButton;
@synthesize cancelButton = _cancelButton;
@synthesize titleName = _titleName;
@synthesize controlForDismiss = _controlForDismiss;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initTheInterface];
    }
    return self;
}

- (void)initTheInterface
{
    self.backgroundColor = [UIColor colorWithRed:240.0f/255.0f
                                           green:240.0f/255.0f
                                            blue:240.0f/255.0f
                                           alpha:1.0f];
    
    self.layer.borderColor = [[UIColor colorWithRed:251.0f/255.0f
                                              green:110.0f/255.0f
                                               blue:82.0f/255.0f
                                              alpha:0.5f] CGColor];
    self.layer.borderWidth = 0.5f;
    self.layer.cornerRadius = 6.0f;
    self.clipsToBounds = TRUE;
    
    _titleName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleName.font = [UIFont systemFontOfSize:17.0f];
    self.titleName.backgroundColor = [UIColor colorWithRed:251.0f/255.0f
                                                     green:110.0f/255.0f
                                                      blue:82.0f/255.0f
                                                     alpha:1.0f];
    
    self.titleName.textAlignment = NSTextAlignmentCenter;
    self.titleName.textColor = [UIColor whiteColor];
    CGFloat xWidth = self.bounds.size.width;
    self.titleName.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleName.frame = CGRectMake(0, 0, xWidth, 35.0f);
    [self addSubview:self.titleName];
    
    UIView *mqaView = [[UIView alloc]initWithFrame:CGRectMake(60.0f,50.0f,130.0f,35.0f)];
    mqaView.backgroundColor = [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:(1.0f)];
    mqaView.layer.cornerRadius= 3.0f;
    mqaView.layer.borderWidth = 0.5f;
    mqaView.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
    [self addSubview:mqaView];
    
    UIButton *minusButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 35.0f, 35.0f)];
    minusButton.backgroundColor = [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:(1.0f)];
    [minusButton setTitle:@"－" forState:UIControlStateNormal];
    minusButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [minusButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
    [minusButton addTarget:self action:@selector(minusBuyQuantity:) forControlEvents:UIControlEventTouchUpInside];
    [mqaView addSubview:minusButton];
    
    self.buyQuantityTextField = [[UITextField alloc]initWithFrame:CGRectMake(35.0f, 0.0f, 60.0f, 35.0f)];
    self.buyQuantityTextField.delegate = self;
    self.buyQuantityTextField.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:(1.0f)];
    self.buyQuantityTextField.font = [UIFont systemFontOfSize:12.0f];
    self.buyQuantityTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:(1.0f)];
    self.buyQuantityTextField.layer.borderWidth = 0.5f;
    self.buyQuantityTextField.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
    self.buyQuantityTextField.textAlignment = NSTextAlignmentCenter;
    self.buyQuantityTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.buyQuantityTextField.returnKeyType = UIReturnKeyDone;
    self.buyQuantityTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    [mqaView addSubview:self.buyQuantityTextField];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(95.0f, 0.0f, 35.0f, 35.0f)];
    addButton.backgroundColor = [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:(1.0f)];
    addButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [addButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
    [addButton setTitle:@"＋" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addBuyQuantity:) forControlEvents:UIControlEventTouchUpInside];
    [mqaView addSubview:addButton];
}

- (void)addBuyQuantity:(id)sender
{
    self.buyQuantityTextField.text = [NSString stringWithFormat:@"%d",[self.buyQuantityTextField.text intValue]+1];
}

- (void)minusBuyQuantity:(id)sender
{
    if ([self.buyQuantityTextField.text intValue] > 1)
    {
        self.buyQuantityTextField.text = [NSString stringWithFormat:@"%d",[self.buyQuantityTextField.text intValue]-1];
    }
}

- (void)refreshTheUserInterface
{
    if (self.doneButton && nil == self.cancelButton)
    {
        if (nil == _controlForDismiss)
        {
            _controlForDismiss = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
            _controlForDismiss.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
            [_controlForDismiss addTarget:self action:@selector(touchForDismissSelf:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        self.doneButton.frame = CGRectMake(100.0f, 100.0f, 50.0f, 30.0f);
    }
    else if (nil == self.doneButton && self.cancelButton)
    {
        if (nil == _controlForDismiss)
        {
            _controlForDismiss = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
            _controlForDismiss.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
        }
        
        self.cancelButton.frame = CGRectMake(220.0f, 10.0f, 15.0f, 15.0f);
    }
    else if (self.doneButton && self.cancelButton)
    {
        if (nil == _controlForDismiss)
        {
            _controlForDismiss = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
            _controlForDismiss.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
        }
        
        self.doneButton.frame = CGRectMake(100.0f, 100.0f, 50.0f, 30.0f);
        self.cancelButton.frame = CGRectMake(220.0f, 10.0f, 15.0f, 15.0f);
    }
    else if (nil == self.cancelButton && nil == self.doneButton)
    {
        if (nil == _controlForDismiss)
        {
            _controlForDismiss = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
            _controlForDismiss.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
            [_controlForDismiss addTarget:self action:@selector(touchForDismissSelf:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark - Animated Mthod
- (void)animatedIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)animatedOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            if (self.controlForDismiss)
            {
                [self.controlForDismiss removeFromSuperview];
            }
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - show or hide self
- (void)show
{
    [self refreshTheUserInterface];
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    if (self.controlForDismiss)
    {
        [keywindow addSubview:self.controlForDismiss];
    }
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/3.0f);
    [self animatedIn];
}

- (void)dismiss
{
    [self animatedOut];
}

+ (UIImage *)normalButtonBackgroundImage
{
	const size_t locationCount = 4;
	CGFloat opacity = 1.0;
    CGFloat locations[locationCount] = { 0.0, 0.5, 0.5 + 0.0001, 1.0 };
    CGFloat components[locationCount * 4] = {
		179/255.0, 185/255.0, 199/255.0, opacity,
		121/255.0, 132/255.0, 156/255.0, opacity,
		87/255.0, 100/255.0, 130/255.0, opacity,
		108/255.0, 120/255.0, 146/255.0, opacity,
	};
	return [self glassButtonBackgroundImageWithGradientLocations:locations
													  components:components
												   locationCount:locationCount];
}

+ (UIImage *)cancelButtonBackgroundImage
{
	const size_t locationCount = 4;
	CGFloat opacity = 1.0;
    CGFloat locations[locationCount] = { 0.0, 0.5, 0.5 + 0.0001, 1.0 };
    CGFloat components[locationCount * 4] = {
		164/255.0, 169/255.0, 184/255.0, opacity,
		77/255.0, 87/255.0, 115/255.0, opacity,
		51/255.0, 63/255.0, 95/255.0, opacity,
		78/255.0, 88/255.0, 116/255.0, opacity,
	};
	return [self glassButtonBackgroundImageWithGradientLocations:locations
													  components:components
												   locationCount:locationCount];
}

+ (UIImage *)glassButtonBackgroundImageWithGradientLocations:(CGFloat *)locations
												  components:(CGFloat *)components
											   locationCount:(NSInteger)locationCount
{
	const CGFloat lineWidth = 1;
	const CGFloat cornerRadius = 4;
	UIColor *strokeColor = [UIColor colorWithRed:1/255.0 green:11/255.0 blue:39/255.0 alpha:1.0];
	
	CGRect rect = CGRectMake(0, 0, cornerRadius * 2 + 1, ZSYCustomButtonHeight);
    
	BOOL opaque = NO;
    UIGraphicsBeginImageContextWithOptions(rect.size, opaque, [[UIScreen mainScreen] scale]);
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, locationCount);
	
	CGRect strokeRect = CGRectInset(rect, lineWidth * 0.5, lineWidth * 0.5);
	UIBezierPath *strokePath = [UIBezierPath bezierPathWithRoundedRect:strokeRect cornerRadius:cornerRadius];
	strokePath.lineWidth = lineWidth;
	[strokeColor setStroke];
	[strokePath stroke];
	
	CGRect fillRect = CGRectInset(rect, lineWidth, lineWidth);
	UIBezierPath *fillPath = [UIBezierPath bezierPathWithRoundedRect:fillRect cornerRadius:cornerRadius];
	[fillPath addClip];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
	CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
	CGFloat capHeight = floorf(rect.size.height * 0.5);
	return [image resizableImageWithCapInsets:UIEdgeInsetsMake(capHeight, cornerRadius, capHeight, cornerRadius)];
}

#pragma mark - Button Method
- (void)setCancelButtonTitle:(NSString *)aTitle block:(ZSYPopoverListViewButtonBlock)block
{
    if (nil == _cancelButton)
    {
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(buttonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelButton];
    }
    
    objc_setAssociatedObject(self.cancelButton, kZSYPopoverListButtonClickForCancel, [block copy], OBJC_ASSOCIATION_RETAIN);
}

- (void)setDoneButtonWithTitle:(NSString *)aTitle block:(ZSYPopoverListViewButtonBlock)block
{
    if (nil == _doneButton)
    {
        self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.doneButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.doneButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
        [self.doneButton.layer setCornerRadius:3.0f];
        self.doneButton.layer.borderWidth = 0.5f;
        self.doneButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
        [self.doneButton addTarget:self action:@selector(buttonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.doneButton];
    }
    
    [self.doneButton setTitle:aTitle forState:UIControlStateNormal];
    objc_setAssociatedObject(self.doneButton, kZSYPopoverListButtonClickForDone, [block copy], OBJC_ASSOCIATION_RETAIN);
}
#pragma mark - UIButton Clicke Method
- (void)buttonWasPressed:(id)sender
{
    [self.buyQuantityTextField resignFirstResponder];
    
    UIButton *button = (UIButton *)sender;
    ZSYPopoverListViewButtonBlock __block block;
    
    if (button == self.cancelButton)
    {
        block = objc_getAssociatedObject(sender, kZSYPopoverListButtonClickForCancel);
    }
    else
    {
        block = objc_getAssociatedObject(sender, kZSYPopoverListButtonClickForDone);
    }
    if (block)
    {
        block();
    }
    
    [self animatedOut];
}

- (void)touchForDismissSelf:(id)sender
{
    [self animatedOut];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end