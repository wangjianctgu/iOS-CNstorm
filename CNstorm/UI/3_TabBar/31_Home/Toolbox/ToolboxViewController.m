//
//  ToolboxViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-4-11.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "ToolboxViewController.h"

@interface ToolboxViewController ()

@end

@implementation ToolboxViewController

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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleLabel setText:@"实用工具"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setTextColor:[UIColor whiteColor]];
    titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    self.navigationItem.titleView = titleLabel;
    
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
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 138.5f, 320.0f, 1.0f)];
    lineView2.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:lineView2];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 277.0f, 320.0f, 1.0f)];
    lineView3.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:lineView3];
    
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(159.5f, 0.0f, 1.0f, 277.0f)];
    lineView4.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:lineView4];
    
    UIView *lineView5 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 415.5f, 320.0f, 1.0f)];
    lineView5.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:lineView5];

    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 160.0f, 138.5f)];
    view1.backgroundColor = [UIColor clearColor];
    [view1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view1:)]];
    [self.scrollView addSubview:view1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(160.0f, 0.0f, 160.0f, 138.5f)];
    view2.backgroundColor = [UIColor clearColor];
    [view2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view2:)]];
    [self.scrollView addSubview:view2];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 138.5f, 160.0f, 138.5f)];
    view3.backgroundColor = [UIColor clearColor];
    [view3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view3:)]];
    [self.scrollView addSubview:view3];
    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(160.0f, 138.5f, 160.0f, 138.5f)];
    view4.backgroundColor = [UIColor clearColor];
    [view4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view4:)]];
    [self.scrollView addSubview:view4];
    
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 277.0f, 320.0f, 138.5f)];
    view5.backgroundColor = [UIColor clearColor];
    [view5 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view5:)]];
    [self.scrollView addSubview:view5];

    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(42.5f, 20.0f, 75.0f, 75.0f)];
    [imageView1 setImage:[UIImage imageNamed:@"packageSearch"]];
    [view1 addSubview:imageView1];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 95.0f, 160.0f, 30.0f)];
    label1.text = [NSString stringWithFormat:@"包裹查询"];
    label1.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    label1.font = [UIFont boldSystemFontOfSize:17.0f];
    label1.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:label1];
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(42.5f, 20.0f, 75.0f, 75.0f)];
    [imageView2 setImage:[UIImage imageNamed:@"cost"]];
    [view2 addSubview:imageView2];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 95.0f, 160.0f, 30.0f)];
    label2.text = [NSString stringWithFormat:@"费用估算"];
    label2.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    label2.font = [UIFont boldSystemFontOfSize:17.0f];
    label2.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:label2];
    
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(42.5f, 20.0f, 75.0f, 75.0f)];
    [imageView3 setImage:[UIImage imageNamed:@"sizeTable"]];
    [view3 addSubview:imageView3];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 95.0f, 160.0f, 30.0f)];
    label3.text = [NSString stringWithFormat:@"尺码对照表"];
    label3.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    label3.font = [UIFont boldSystemFontOfSize:17.0f];
    label3.textAlignment = NSTextAlignmentCenter;
    [view3 addSubview:label3];
    
    UIImageView *imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(42.5f, 20.0f, 75.0f, 75.0f)];
    [imageView4 setImage:[UIImage imageNamed:@"rateExchange"]];
    [view4 addSubview:imageView4];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 95.0f, 160.0f, 30.0f)];
    label4.text = [NSString stringWithFormat:@"汇率换算"];
    label4.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    label4.font = [UIFont boldSystemFontOfSize:17.0f];
    label4.textAlignment = NSTextAlignmentCenter;
    [view4 addSubview:label4];
    
    UIImageView *imageView5 = [[UIImageView alloc]initWithFrame:CGRectMake(125.0f, 28.0f, 70.0f, 58.0f)];
    [imageView5 setImage:[UIImage imageNamed:@"kefu"]];
    [view5 addSubview:imageView5];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(80.0f, 95.0f, 160.0f, 30.0f)];
    label5.text = [NSString stringWithFormat:@"在线客服"];
    label5.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    label5.font = [UIFont boldSystemFontOfSize:17.0f];
    label5.textAlignment = NSTextAlignmentCenter;
    [view5 addSubview:label5];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,MainScreenHeight-NavigationBarHeight+1.0f);
}

- (void)view1:(id)sender
{
    PackageSearchViewController *packageSearchViewController = [[PackageSearchViewController alloc] initWithNibName:@"PackageSearchViewController" bundle:nil];
    [self.navigationController pushViewController:packageSearchViewController animated:YES];
}

- (void)view2:(id)sender
{
    CostimatingViewController *costimatingViewController = [[CostimatingViewController alloc] initWithNibName:@"CostimatingViewController" bundle:nil];
    [self.navigationController pushViewController:costimatingViewController animated:YES];
}

- (void)view3:(id)sender
{
    SizeTableViewController *sizeTableViewController = [[SizeTableViewController alloc] initWithNibName:@"SizeTableViewController" bundle:nil];
    [self.navigationController pushViewController:sizeTableViewController animated:YES];
}

- (void)view4:(id)sender
{
    RateExchangeViewController *rateExchangeViewController = [[RateExchangeViewController alloc] initWithNibName:@"RateExchangeViewController" bundle:nil];
    [self.navigationController pushViewController:rateExchangeViewController animated:YES];
}

- (void)view5:(id)sender
{
    CustomerServiceViewController *customerServiceViewController = [[CustomerServiceViewController alloc] initWithNibName:@"CustomerServiceViewController" bundle:nil];
    
    MJNavigationController *customerServiceNC = [[MJNavigationController alloc]initWithRootViewController:customerServiceViewController];
    [self presentViewController:customerServiceNC animated:YES completion:NULL];
}

@end
