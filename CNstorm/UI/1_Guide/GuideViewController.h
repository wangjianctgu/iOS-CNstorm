//
//  GuideViewController.h
//  LoginTest
//
//  Created by EBS1 on 14-3-19.
//  Copyright (c) 2014年 Foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImage+SplitImageIntoTwoParts.h"

#import "UIdefine.h"

@class GuideViewController;

@protocol GuideViewControllerDelegate <NSObject>

- (void)didFinishedLoadGuideView:(GuideViewController *) guideViewController;

@end

@interface GuideViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, assign) id <GuideViewControllerDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) UIScrollView *pageScroll;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIButton *gotoBtn;

@end
