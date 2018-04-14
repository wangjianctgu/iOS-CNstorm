//
//  TabBarViewController.h
//  LoginTest
//
//  Created by EBS1 on 14-3-17.
//  Copyright (c) 2014年 Foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeViewController.h"

#import "SearchGoodsViewController.h"

#import "CartViewController.h"

#import "MyCNstormViewController.h"

#import "ICSDrawerController.h"


@interface TabBarViewController : UITabBarController <ICSDrawerControllerChild, ICSDrawerControllerPresenting,UITabBarControllerDelegate,HomeViewControllerDelegate>

@property(nonatomic, weak) ICSDrawerController *drawer;

@property(nonatomic, strong) HomeViewController *homeViewController;
@property(nonatomic, strong) MyCNstormViewController *myCNstormViewController;

@end
