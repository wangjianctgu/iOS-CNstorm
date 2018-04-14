//
//  RechargeViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "RechargeViewController.h"

@interface RechargeViewController ()

@end

@implementation RechargeViewController

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
    self.title = @"账户充值";
    
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
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f];
    [self.scrollView setScrollEnabled:YES];
    [self.view addSubview:self.scrollView];
    
    UILabel *rechargeLable = [[UILabel alloc]initWithFrame:CGRectMake(40.0f, 40.0f, 80.0f, 40.0f)];
    rechargeLable.text = @"充值金额:￥";
    rechargeLable.textColor = [UIColor colorWithRed:(153.0f)/255.0f green:(153.0f)/255.0f blue:(153.0f)/255.0f alpha:1];;
    rechargeLable.font = [UIFont systemFontOfSize:15.0f];
    rechargeLable.lineBreakMode = NSLineBreakByTruncatingTail;
    rechargeLable.numberOfLines = 1;
    rechargeLable.textAlignment = NSTextAlignmentLeft;
    rechargeLable.baselineAdjustment = UIBaselineAdjustmentNone;
    [self.scrollView addSubview:rechargeLable];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(120.0f, 40.0f, 150.0f, 40.0f)];
    view.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view.layer.cornerRadius = 6.0f;
    view.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view.layer.borderWidth = 0.5f;
    [self.scrollView addSubview:view];
    
    self.rechargeTextField = [[UITextField alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 130.0f, 40.0f)];
    self.rechargeTextField.delegate = self;
    self.rechargeTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.rechargeTextField.backgroundColor = [UIColor whiteColor];
    self.rechargeTextField.textAlignment = NSTextAlignmentLeft;
    [self.rechargeTextField setFont:[UIFont systemFontOfSize:14.0f]];
    self.rechargeTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    self.rechargeTextField.returnKeyType = UIReturnKeyDone;//return键的类型
    self.rechargeTextField.keyboardType = UIKeyboardTypeNumberPad;//键盘类型
    [view addSubview:self.rechargeTextField];
    
    self.commitButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 115.0f, 300.0f,40.0f)];
    [self.commitButton setTitle:@"选择支付平台充值" forState:UIControlStateNormal];
    self.commitButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commitButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [self.commitButton.layer setCornerRadius:3.0f];
    self.commitButton.layer.borderWidth = 0.5f;
    self.commitButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [self.commitButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.commitButton];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,MainScreenHeight-NavigationBarHeight+1.0f);
}

- (void)commit:(id)sender
{
    [self.rechargeTextField resignFirstResponder];
    
    float yoffset = -(self.view.center.y-self.commitButton.center.y)+NavigationBarHeight;
    
    if ([self.rechargeTextField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入充值金额" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if ([self.rechargeTextField.text floatValue] == 0.0f)
    {
        [MBProgressHUD showError:@"请输入充值金额" toYOffset:yoffset toView:self.view];
        return;
    }
    
    ThirdPayViewController *thirdPayViewController = [[ThirdPayViewController alloc]initWithNibName:@"ThirdPayViewController" bundle:nil];
    thirdPayViewController.hidesBottomBarWhenPushed = YES;
    thirdPayViewController.totalCost = [[NSString stringWithFormat:@"%@",self.rechargeTextField.text] floatValue];
    thirdPayViewController.payType = 2;
    [self.navigationController pushViewController:thirdPayViewController animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
