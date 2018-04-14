//
//  OpeningViewController.m
//  LoginTest
//
//  Created by EBS1 on 14-3-18.
//  Copyright (c) 2014年 Foxconn. All rights reserved.
//

#import "OpeningViewController.h"

@interface OpeningViewController ()

@end

@implementation OpeningViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	if(MainScreenHeight == 568.0f)
	{
		[self.imageBG setImage:[UIImage imageNamed:@"opening5"]];
        self.imageBG.frame = CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight);
	}
	else
	{
		[self.imageBG setImage:[UIImage imageNamed:@"opening"]];
        self.imageBG.frame = CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight);
	}
    

    [UIView animateWithDuration:0.0f delay:0.1f options:UIViewAnimationOptionCurveEaseInOut animations:^{
    }
    completion:^(BOOL finished)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedLoadOpeningView:)]) {
            [self.delegate didFinishedLoadOpeningView:self];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
