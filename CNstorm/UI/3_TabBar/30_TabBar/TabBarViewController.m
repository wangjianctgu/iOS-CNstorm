//
//  TabBarViewController.m
//  LoginTest
//
//  Created by EBS1 on 14-3-17.
//  Copyright (c) 2014年 Foxconn. All rights reserved.
//

#import "TabBarViewController.h"

#import "MJNavigationController.h"

#define iphone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//iphone5 5s的分辨率 640, 1136


@interface TabBarViewController ()

@property(nonatomic, strong) UIButton *openDrawerButton;

@end

@implementation TabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置选项卡选中图像的颜色
    self.tabBar.backgroundColor = RGBACOLOR(215.0f,215.0f,215.0f,1.0f);//背景色
    self.tabBar.barTintColor = RGBACOLOR(248.0f,248.0f,248.0f,1.0f);//最前景色
    //self.tabBar.selectedImageTintColor = RGBACOLOR(251.0f,110.0f,83.0f,1.0f);
    //修复iOS8.1警告
    self.tabBar.tintColor = RGBACOLOR(251.0f,110.0f,83.0f,1.0f);//前景色

    //设置UITabBar的边界颜色值 没有达到预期的效果
    //self.tabBar.layer.borderColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:(1.0f)].CGColor;//
    //self.tabBar.layer.borderWidth = 5.0f;
    
    self.homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    self.homeViewController.delegate = self;

    SearchGoodsViewController *searchGoodsViewController = [[SearchGoodsViewController alloc] initWithNibName:@"SearchGoodsViewController" bundle:nil];
    
    CartViewController *cartViewController = [[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil];
    
    self.myCNstormViewController = [[MyCNstormViewController alloc] initWithNibName:@"MyCNstormViewController" bundle:nil];
    
    MJNavigationController *homeNavigationController = [[MJNavigationController alloc]initWithRootViewController:self.homeViewController];
    
    MJNavigationController *searchGoodsNavigationController = [[MJNavigationController alloc]initWithRootViewController:searchGoodsViewController];
    
    MJNavigationController *cartNavigationController = [[MJNavigationController alloc]initWithRootViewController:cartViewController];
    
    MJNavigationController *myCNstormNavigationController = [[MJNavigationController alloc]initWithRootViewController:self.myCNstormViewController];
    
    self.viewControllers = @[homeNavigationController, searchGoodsNavigationController,cartNavigationController,myCNstormNavigationController];
    
    [self initBadgeValue];
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

#pragma mark - ICSDrawerControllerPresenting
- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

#pragma mark - Open drawer button
- (void)didFinishedOpenDrawer:(HomeViewController *) homeViewController;
{
    [self.drawer open];
}

- (void)initBadgeValue
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    BadgeKeyValue *badgeKeyValue = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:[NSString stringWithFormat:@"%lld",customer.customerid]]];
    
    if (badgeKeyValue.tabBadge4 == 0)
    {
        self.myCNstormViewController.tabBarItem.badgeValue = 0;
    }
    else
    {
        self.myCNstormViewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",badgeKeyValue.tabBadge4];
    }
}

@end
