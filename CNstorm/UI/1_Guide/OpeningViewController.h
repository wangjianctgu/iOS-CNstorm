//
//  OpeningViewController.h
//  LoginTest
//
//  Created by EBS1 on 14-3-18.
//  Copyright (c) 2014年 Foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"

@class OpeningViewController;

@protocol OpeningViewDelegate <NSObject>

- (void)didFinishedLoadOpeningView:(OpeningViewController *)openingViewController;

@end

@interface OpeningViewController : UIViewController

@property (nonatomic, assign) id <OpeningViewDelegate> delegate;

@property (nonatomic, strong) IBOutlet UIImageView *imageBG;

@end