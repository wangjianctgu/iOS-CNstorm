//
//  SizeTableViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "SizeTableViewController.h"

@interface SizeTableViewController ()

@end

@implementation SizeTableViewController

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
    self.navigationItem.title = @"尺码对照表";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self initMyView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)popToRootView
{
    [self.navigationController popViewControllerAnimated:YES];
}

//选项卡导航
- (void)showMenu:(id)sender
{
    NSArray *menuItems =
    @[[KxMenuItem menuItem:@"首页"
                     image:[UIImage imageNamed:@"home"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"搜索"
                     image:[UIImage imageNamed:@"searchGoods"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"购物车"
                     image:[UIImage imageNamed:@"cart"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"我的"
                     image:[UIImage imageNamed:@"myCNstorm"]
                    target:self
                    action:@selector(pushMenuItem:)],
      ];
    
    //    KxMenuItem *first = menuItems[0];
    //    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    //    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu setTintColor: [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.5]];
    [KxMenu setTitleFont:[UIFont systemFontOfSize:14]];
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(282.0f,-22.0f,22.0f,22.0f)
                 menuItems:menuItems];
}

- (void) pushMenuItem:(id)sender
{
    KxMenuItem *kxMenuItem = (KxMenuItem *)sender;
    NSUInteger selectedIndex = 0;
    if([kxMenuItem.title isEqualToString:@"首页"])
    {
        selectedIndex = 0;
    }
    else if([kxMenuItem.title isEqualToString:@"搜索"])
    {
        selectedIndex = 1;
    }
    else if([kxMenuItem.title isEqualToString:@"购物车"])
    {
        selectedIndex = 2;
    }
    else
    {
        selectedIndex = 3;
    }
    
    self.tabBarController.selectedIndex = selectedIndex;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)initMyView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f,0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView setScrollEnabled:YES];
    [self.view addSubview:self.scrollView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 1.0f)];
    lineView1.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 160.0f, 320.0f, 1.0f)];
    lineView2.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:lineView2];

    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(159.5f, 0.0f, 1.0f, 160.0f)];
    lineView3.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:lineView3];
    
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 160.0f, 160.0f)];
    view1.backgroundColor = [UIColor clearColor];
    [view1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view1:)]];
    [self.scrollView addSubview:view1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(160.0f, 0.0f, 160.0f, 160.0f)];
    view2.backgroundColor = [UIColor clearColor];
    [view2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view2:)]];
    [self.scrollView addSubview:view2];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(54.75f, 53.75f, 50.5f, 52.5f)];
    [imageView1 setImage:[UIImage imageNamed:@"women"]];
    [view1 addSubview:imageView1];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 117.5f, 160.0f, 30.0f)];
    label1.text = [NSString stringWithFormat:@"女士尺码表"];
    label1.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    label1.font = [UIFont boldSystemFontOfSize:17.0f];
    label1.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:label1];
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(52.25f, 53.0f, 55.5f, 54.0f)];
    [imageView2 setImage:[UIImage imageNamed:@"man"]];
    [view2 addSubview:imageView2];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 117.5f, 160.0f, 30.0f)];
    label2.text = [NSString stringWithFormat:@"男士尺码表"];
    label2.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    label2.font = [UIFont boldSystemFontOfSize:17.0f];
    label2.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:label2];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,MainScreenHeight-NavigationBarHeight+1.0f);
}

- (void)view1:(id)sender
{
    WomenSizeTableViewController *womenSizeTableViewController = [[WomenSizeTableViewController alloc] initWithNibName:@"WomenSizeTableViewController" bundle:nil];
    [self.navigationController pushViewController:womenSizeTableViewController animated:YES];
}

- (void)view2:(id)sender
{
    ManSizeTableViewController *manSizeTableViewController = [[ManSizeTableViewController alloc] initWithNibName:@"ManSizeTableViewController" bundle:nil];
    [self.navigationController pushViewController:manSizeTableViewController animated:YES];
}

@end
