//
//  WayPayViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "WayPayViewController.h"

@interface WayPayViewController ()

@end

@implementation WayPayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.inputType = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.navigationItem.title = @"生成国际运单";
    
    if (self.inputType == 0)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    }
    else
    {
        [self.navigationItem setHidesBackButton:YES];//防止返回重新提交
    }
    
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
    [self.view addSubview:self.scrollView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(10.0f ,5.0f,  300.0f, 275.0f)];
    [imageView setImage:[UIImage imageNamed:@"payBg"]];
    imageView.userInteractionEnabled = YES;
    [self.scrollView addSubview: imageView];
    
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 320.0f, 300.0f,40.0f)];
    [commitButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [commitButton setBackgroundColor:[UIColor darkGrayColor]];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [commitButton.layer setCornerRadius:3.0f];
    commitButton.layer.borderWidth = 0.5f;
    commitButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [commitButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:commitButton];
    
    UIView *infoView = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 20.0f, 280.0f, 122.0f)];
    infoView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [imageView addSubview:infoView];
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, 0.0f, 280.0f, 32.0f)];
    infoLabel.text = @"运单信息";
    infoLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    infoLabel.font = [UIFont systemFontOfSize:17.0f];
    infoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    infoLabel.numberOfLines = 1;
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.adjustsFontSizeToFitWidth = YES;
    infoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [infoView addSubview:infoLabel];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 31.0f, 280.0f, 1.0f)];
    lineView1.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [infoView addSubview:lineView1];
    
    UILabel *commitLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, 32.0f, 280.0f, 25.0f)];
    commitLabel.text = @"运单已经成功提交，请尽快完成支付！";
    commitLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    commitLabel.font = [UIFont systemFontOfSize:15.0f];
    commitLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    commitLabel.numberOfLines = 1;
    commitLabel.textAlignment = NSTextAlignmentLeft;
    commitLabel.adjustsFontSizeToFitWidth = YES;
    commitLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [infoView addSubview:commitLabel];
    
    UILabel *orderNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, 57.0f, 280.0f, 40.0f)];
    orderNoLabel.text = [NSString stringWithFormat:@"运单编号:%@",self.wayIdStr];
    orderNoLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    orderNoLabel.font = [UIFont systemFontOfSize:15.0f];
    orderNoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    orderNoLabel.numberOfLines = 2;
    orderNoLabel.textAlignment = NSTextAlignmentLeft;
    orderNoLabel.adjustsFontSizeToFitWidth = YES;
    orderNoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [infoView addSubview:orderNoLabel];
    
    self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, 97.0f, 280.0f, 25.0f)];
    self.moneyLabel.text = [NSString stringWithFormat:@"应付金额:%.2f",self.wayTotalCost];
    self.moneyLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    self.moneyLabel.font = [UIFont systemFontOfSize:15.0f];
    self.moneyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.moneyLabel.numberOfLines = 1;
    self.moneyLabel.textAlignment = NSTextAlignmentLeft;
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    self.moneyLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [infoView addSubview:self.moneyLabel];
    
    UIView *payView = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 152.0f, 280.0f, 102.0f)];
    payView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [imageView addSubview:payView];
    
    UILabel *payLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, 0.0f, 280.0f, 32.0f)];
    payLabel.text = @"支付方式";
    payLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    payLabel.font = [UIFont systemFontOfSize:17.0f];
    payLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    payLabel.numberOfLines = 1;
    payLabel.textAlignment = NSTextAlignmentLeft;
    payLabel.adjustsFontSizeToFitWidth = YES;
    payLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [payView addSubview:payLabel];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 31.0f, 280.0f, 1.0f)];
    lineView2.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [payView addSubview:lineView2];
    
    self.yuerButton = [[UIButton alloc]initWithFrame:CGRectMake(5.0f, 39.5f, 20.0f,20.0f)];
    [self.yuerButton setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    [self.yuerButton setBackgroundImage:[UIImage imageNamed:@"uncheck_selected"] forState:UIControlStateSelected];
    self.yuerButton.selected = YES;
    self.yuerButton.userInteractionEnabled = YES;
    [self.yuerButton addTarget:self action:@selector(selectedYuer:) forControlEvents:UIControlEventTouchUpInside];
    [payView addSubview:self.yuerButton];
    
    UILabel *yuerLabel = [[UILabel alloc]initWithFrame:CGRectMake(30.0f, 32.0f, 125.0f, 35.0f)];
    yuerLabel.text = @"使用账户余额支付";
    yuerLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    yuerLabel.font = [UIFont systemFontOfSize:15.0f];
    yuerLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    yuerLabel.numberOfLines = 1;
    yuerLabel.textAlignment = NSTextAlignmentLeft;
    yuerLabel.adjustsFontSizeToFitWidth = YES;
    yuerLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [payView addSubview:yuerLabel];
    
    self.yuerInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(155.0f, 32.0f, 130.0f, 35.0f)];
    self.yuerInfoLabel.text = [NSString stringWithFormat:@"(余额:%.2f)",self.yuer];
    self.yuerInfoLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f];
    self.yuerInfoLabel.font = [UIFont systemFontOfSize:15.0f];
    self.yuerInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.yuerInfoLabel.numberOfLines = 1;
    self.yuerInfoLabel.textAlignment = NSTextAlignmentLeft;
    self.yuerInfoLabel.adjustsFontSizeToFitWidth = YES;
    self.yuerInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [payView addSubview:self.yuerInfoLabel];
    
    self.thirdPayButton = [[UIButton alloc]initWithFrame:CGRectMake(5.0f, 74.5f, 20.0f,20.0f)];
    [self.thirdPayButton setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    [self.thirdPayButton setBackgroundImage:[UIImage imageNamed:@"uncheck_selected"] forState:UIControlStateSelected];
    self.thirdPayButton.selected = NO;
    self.thirdPayButton.userInteractionEnabled = YES;
    [self.thirdPayButton addTarget:self action:@selector(selectedThirdPay:) forControlEvents:UIControlEventTouchUpInside];
    [payView addSubview:self.thirdPayButton];
    
    UILabel *thirdPayLabel = [[UILabel alloc]initWithFrame:CGRectMake(30.0f, 67.0f, 255.0f, 35.0f)];
    thirdPayLabel.text = @"使用第三方平台支付";
    thirdPayLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    thirdPayLabel.font = [UIFont systemFontOfSize:15.0f];
    thirdPayLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    thirdPayLabel.numberOfLines = 1;
    thirdPayLabel.textAlignment = NSTextAlignmentLeft;
    thirdPayLabel.adjustsFontSizeToFitWidth = YES;
    thirdPayLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [payView addSubview:thirdPayLabel];
    
    [self searchYuerWebService];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth,MainScreenHeight-NavigationBarHeight+1);
}

- (void)selectedYuer:(id)sender
{
    self.yuerButton.selected = YES;
    self.thirdPayButton.selected = NO;
}


- (void)selectedThirdPay:(id)sender
{
    self.yuerButton.selected = NO;
    self.thirdPayButton.selected = YES;
}

- (void)commit:(id)sender
{
    if (self.yuerButton.selected)
    {
        if(self.yuer < self.wayTotalCost)
        {
            self.rechargeAlertView = [[UIAlertView alloc]initWithTitle:@"余额不足" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"请充值",nil];
            [self.rechargeAlertView show];
        }
        else
        {
            self.yuerPayAlertView = [[UIAlertView alloc]initWithTitle:@"您确认余额支付吗？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [self.yuerPayAlertView show];
        }
    }
    
    if (self.thirdPayButton.selected)
    {
        ThirdPayViewController *thirdPayViewController = [[ThirdPayViewController alloc]initWithNibName:@"ThirdPayViewController" bundle:nil];
        thirdPayViewController.hidesBottomBarWhenPushed = YES;
        thirdPayViewController.totalCost = self.wayTotalCost;
        thirdPayViewController.idsStr = self.wayIdStr;
        thirdPayViewController.payType = 1;
        [self.navigationController pushViewController:thirdPayViewController animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.rechargeAlertView)
    {
        if (buttonIndex == 1)
        {
            RechargeViewController *rechargeViewController = [[RechargeViewController alloc]initWithNibName:@"RechargeViewController" bundle:nil];
            [self.navigationController pushViewController:rechargeViewController animated:YES];
        }
    }
    else
    {
        if (buttonIndex == 1)
        {
            //调用余额充值接口
            [self yuerPayWebService];
        }
    }
}

/*********************************余额支付接口*************************************/
- (void)yuerPayWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/order/balance_payment"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestYuerPayFailed:)];
    [request setDidFinishSelector:@selector(requestYuerPayFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    [param setValue:self.wayIdStr forKey:@"orderIds"];
    [param setValue:[NSString stringWithFormat:@"%.2f",self.wayTotalCost] forKey:@"money"];
    [param setValue:[NSString stringWithFormat:@"1"] forKey:@"yundan"];
    
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在支付";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestYuerPayFailed:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if ([request error])
    {
        request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
        request.hud.mode = MBProgressHUDModeCustomView;
        request.hud.removeFromSuperViewOnHide = YES;
        request.hud.labelText = @"网络异常";
        request.hud.detailsLabelText = @"请检查网络重试";
    }
}

- (void)requestYuerPayFinished:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSData *responseData = request.responseData;
        
        //官方的Json速度最快
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dataDictionary = %@",dataDictionary);
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 0)
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"支付失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            PayComViewController *payComViewController = [[PayComViewController alloc]initWithNibName:@"PayComViewController" bundle:nil];
            payComViewController.payType = 1;
            [self.navigationController pushViewController:payComViewController animated:YES];
        }
    }
}

/**************************查询用户余额接口*******************************/
- (void)searchYuerWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/order/getBalance"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestSearchYuerFailed:)];
    [request setDidFinishSelector:@selector(requestSearchYuerFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在加载";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestSearchYuerFailed:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if ([request error])
    {
        request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
        request.hud.mode = MBProgressHUDModeCustomView;
        request.hud.removeFromSuperViewOnHide = YES;
        request.hud.labelText = @"网络异常";
        request.hud.detailsLabelText = @"请检查网络重试";
    }
}

- (void)requestSearchYuerFinished:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSData *responseData = request.responseData;
        
        //官方的Json速度最快
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 1)
        {
            NSDictionary *result = [data objectForKey:@"result"];
            self.yuer = [[result objectForKey:@"balance"]doubleValue];
            self.yuerInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",self.yuer];;
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
