//
//  RMBAccountViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-25.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "RMBAccountViewController.h"

@interface RMBAccountViewController ()

@end

@implementation RMBAccountViewController

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
    
    self.navigationItem.title = @"人民币账户";
    
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
    self.scrollView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView setScrollEnabled:YES];
    [self.view addSubview:self.scrollView];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 104.0f)];
    view1.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:view1];
    
    UILabel *accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 10.0f, 70.0f, 28.0f)];
    accountLabel.text = @"当前账户:";
    accountLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    accountLabel.font = [UIFont systemFontOfSize:14.0f];
    accountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    accountLabel.numberOfLines = 1;
    accountLabel.textAlignment = NSTextAlignmentLeft;
    accountLabel.adjustsFontSizeToFitWidth = YES;
    accountLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:accountLabel];
    
    UILabel *accountInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(80.0f, 10.0f, 230.0f, 28.0f)];
    accountInfoLabel.text = [NSString stringWithFormat:@"cnstorm@cnstorm.com"];
    accountInfoLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    accountInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    accountInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    accountInfoLabel.numberOfLines = 1;
    accountInfoLabel.textAlignment = NSTextAlignmentLeft;
    accountInfoLabel.adjustsFontSizeToFitWidth = YES;
    accountInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    accountInfoLabel.text = [NSString stringWithFormat:@"%@",customer.email];
    [view1 addSubview:accountInfoLabel];
    
    UILabel *yuerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 38.0f, 70.0f, 28.0f)];
    yuerLabel.text = @"可用余额:";
    yuerLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    yuerLabel.font = [UIFont systemFontOfSize:14.0f];
    yuerLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    yuerLabel.numberOfLines = 1;
    yuerLabel.textAlignment = NSTextAlignmentLeft;
    yuerLabel.adjustsFontSizeToFitWidth = YES;
    yuerLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:yuerLabel];
    
    self.yuerInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(80.0f, 38.0f, 230.0f, 28.0f)];
    self.yuerInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",0.0f];
    self.yuerInfoLabel.textColor = [UIColor colorWithRed:(253.0f/255.0f) green:(78.0f/255.0f) blue:(46.0f/255.0f) alpha:1.0f];
    self.yuerInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    self.yuerInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.yuerInfoLabel.numberOfLines = 1;
    self.yuerInfoLabel.textAlignment = NSTextAlignmentLeft;
    self.yuerInfoLabel.adjustsFontSizeToFitWidth = YES;
    self.yuerInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:self.yuerInfoLabel];
    
    UILabel *freezeYuerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 66.0f, 70.0f, 28.0f)];
    freezeYuerLabel.text = @"冻结余额:";
    freezeYuerLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    freezeYuerLabel.font = [UIFont systemFontOfSize:14.0f];
    freezeYuerLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    freezeYuerLabel.numberOfLines = 1;
    freezeYuerLabel.textAlignment = NSTextAlignmentLeft;
    freezeYuerLabel.adjustsFontSizeToFitWidth = YES;
    freezeYuerLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:freezeYuerLabel];
    
    UILabel *freezeYuerInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(80.0f, 66.0f, 230.0f, 28.0f)];
    freezeYuerInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",0.0f];
    freezeYuerInfoLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    freezeYuerInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    freezeYuerInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    freezeYuerInfoLabel.numberOfLines = 1;
    freezeYuerInfoLabel.textAlignment = NSTextAlignmentLeft;
    freezeYuerInfoLabel.adjustsFontSizeToFitWidth = YES;
    freezeYuerInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:freezeYuerInfoLabel];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 104.0f, 320.0f, 45.0f)];
    view2.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:view2];
    
    UILabel *showRechargeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 8.0f, 200.0f, 28.0f)];
    showRechargeLabel.text = @"查看我的充值记录";
    showRechargeLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    showRechargeLabel.font = [UIFont systemFontOfSize:16.0f];
    showRechargeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    showRechargeLabel.numberOfLines = 1;
    showRechargeLabel.textAlignment = NSTextAlignmentLeft;
    showRechargeLabel.adjustsFontSizeToFitWidth = YES;
    showRechargeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view2 addSubview:showRechargeLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(295.0f,17.0f, 6.0f, 10.5f)];
    [arrowImageView setImage:[UIImage imageNamed:@"accessoryView"]];
    [view2 addSubview:arrowImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRechargeTapped:)];
    tap.numberOfTapsRequired = 1;
    [view2 addGestureRecognizer:tap];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 1.0f)];
    lineView1.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [view2 addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, 1.0f)];
    lineView2.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [view2 addSubview:lineView2];
    

    UIButton *rechargeButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, MainScreenHeight-NavigationBarHeight-TransparentBarHeight, 300.0f,40.0f)];
    [rechargeButton setTitle:@"立即充值" forState:UIControlStateNormal];
    rechargeButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [rechargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rechargeButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [rechargeButton.layer setCornerRadius:3.0f];
    rechargeButton.layer.borderWidth = 0.5f;
    rechargeButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [rechargeButton addTarget:self action:@selector(recharge:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:rechargeButton];
    
    [self callSearchYuerWebService];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,MainScreenHeight-NavigationBarHeight+1.0f);
}

- (void)showRechargeTapped:(id)sender
{
    RechargeRecordViewController *rechargeRecordViewController = [[RechargeRecordViewController alloc]initWithNibName:@"RechargeRecordViewController" bundle:nil];
    [self.navigationController pushViewController:rechargeRecordViewController animated:YES];
}

- (void)recharge:(id)sender
{
    RechargeViewController *rechargeViewController = [[RechargeViewController alloc]initWithNibName:@"RechargeViewController" bundle:nil];
    [self.navigationController pushViewController:rechargeViewController animated:YES];
}

/**************************查询用户余额接口*******************************/
- (void)callSearchYuerWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/order/getBalance"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSLog(@"urlString = %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setDidFinishSelector:@selector(requestFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    NSString *paramJson = [param JSONRepresentation];
    NSLog(@"paramJson = %@",paramJson);
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在加载";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
    request.hud.mode = MBProgressHUDModeCustomView;
    request.hud.removeFromSuperViewOnHide = YES;
    request.hud.labelText = @"网络异常";
    request.hud.detailsLabelText = @"请检查网络重试";
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSString *responseString =[request responseString];
        
        NSLog(@"responseString = %@",responseString);
        
        //官方的Json速度最快
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dataDictionary = %@",dataDictionary);
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 1)
        {
            NSDictionary *result = [data objectForKey:@"result"];
            
            self.yuerInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",[[result objectForKey:@"balance"] doubleValue]];
        }
        else
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"加载失败";
            request.hud.detailsLabelText = errorMessage;
        }
    }
}

@end
