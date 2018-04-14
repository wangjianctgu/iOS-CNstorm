//
//  RateExchangeViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "RateExchangeViewController.h"

@interface RateExchangeViewController ()

@end

@implementation RateExchangeViewController

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
    self.navigationItem.title = @"汇率换算";
    
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
    self.scrollView.backgroundColor = [UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f];
    [self.scrollView setScrollEnabled:YES];
    [self.view addSubview:self.scrollView];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 20.0f, 300.0f, 40.0f)];
    view1.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view1.layer.cornerRadius = 6.0f;
    view1.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view1.layer.borderWidth = 0.5f;
    view1.userInteractionEnabled = YES;
    [view1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectOwnType:)]];
    [self.scrollView addSubview:view1];
    
    self.ownTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 270.0f, 40.0f)];
    self.ownTypeLabel.text = [NSString stringWithFormat:@"美元（USD）"];
    self.ownTypeLabel.textColor = [UIColor colorWithRed:(200.0f/255.0f) green:(200.0f/255.0f) blue:(200.0f/255.0f) alpha:1.0f];
    self.ownTypeLabel.font = [UIFont systemFontOfSize:14.0f];
    self.ownTypeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.ownTypeLabel.numberOfLines = 1;
    self.ownTypeLabel.textAlignment = NSTextAlignmentLeft;
    self.ownTypeLabel.adjustsFontSizeToFitWidth = YES;
    self.ownTypeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:self.ownTypeLabel];
    
    UIImageView *arrowImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(284.0f,14.8f, 6.0f, 10.5f)];
    [arrowImageView1 setImage:[UIImage imageNamed:@"accessoryView"]];
    [view1 addSubview:arrowImageView1];
    
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 70.0f, 300.0f, 40.0f)];
    view2.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view2.layer.cornerRadius = 6.0f;
    view2.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view2.layer.borderWidth = 0.5f;
    view2.userInteractionEnabled = YES;
    [view2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectExchangeType:)]];
    [self.scrollView addSubview:view2];
    
    self.exchangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 270.0f, 40.0f)];
    self.exchangeLabel.text = [NSString stringWithFormat:@"人民币（CNY）"];
    self.exchangeLabel.textColor = [UIColor colorWithRed:(200.0f/255.0f) green:(200.0f/255.0f) blue:(200.0f/255.0f) alpha:1.0f];
    self.exchangeLabel.font = [UIFont systemFontOfSize:14.0f];
    self.exchangeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.exchangeLabel.numberOfLines = 1;
    self.exchangeLabel.textAlignment = NSTextAlignmentLeft;
    self.exchangeLabel.adjustsFontSizeToFitWidth = YES;
    self.exchangeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view2 addSubview:self.exchangeLabel];
    
    UIImageView *arrowImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(284.0f,14.8f, 6.0f, 10.5f)];
    [arrowImageView2 setImage:[UIImage imageNamed:@"accessoryView"]];
    [view2 addSubview:arrowImageView2];
    
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 120.0f, 300.0f, 40.0f)];
    view3.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view3.layer.cornerRadius = 6.0f;
    view3.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view3.layer.borderWidth = 0.5f;
    [self.scrollView addSubview:view3];
    
    self.rateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 280.0f, 40.0f)];
    self.rateLabel.text = [NSString stringWithFormat:@"汇率:0.1613"];
    self.rateLabel.textColor = [UIColor colorWithRed:(200.0f/255.0f) green:(200.0f/255.0f) blue:(200.0f/255.0f) alpha:1.0f];
    self.rateLabel.font = [UIFont systemFontOfSize:14.0f];
    self.rateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.rateLabel.numberOfLines = 1;
    self.rateLabel.textAlignment = NSTextAlignmentLeft;
    self.rateLabel.adjustsFontSizeToFitWidth = YES;
    self.rateLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view3 addSubview:self.rateLabel];
    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 170.0f, 300.0f, 40.0f)];
    view4.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:view4];
    
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 130.0f, 40.0f)];
    self.label1.text = @"美元(USD)";
    self.label1.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.label1.font = [UIFont systemFontOfSize:15.0f];
    self.label1.lineBreakMode = NSLineBreakByTruncatingTail;
    self.label1.numberOfLines = 1;
    self.label1.textAlignment = NSTextAlignmentRight;
    self.label1.adjustsFontSizeToFitWidth = YES;
    self.label1.baselineAdjustment = UIBaselineAdjustmentNone;
    [view4 addSubview:self.label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(130.0f, 0.0f, 20.0f, 40.0f)];
    label2.text = @"=";
    label2.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    label2.font = [UIFont systemFontOfSize:15.0f];
    label2.lineBreakMode = NSLineBreakByTruncatingTail;
    label2.numberOfLines = 1;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.adjustsFontSizeToFitWidth = YES;
    label2.baselineAdjustment = UIBaselineAdjustmentNone;
    [view4 addSubview:label2];
    
    self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(150.0f, 0.0f, 150.0f, 40.0f)];
    self.label3.text = @"人民币(CNY)";
    self.label3.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.label3.font = [UIFont systemFontOfSize:15.0f];
    self.label3.lineBreakMode = NSLineBreakByTruncatingTail;
    self.label3.numberOfLines = 1;
    self.label3.textAlignment = NSTextAlignmentLeft;
    self.label3.adjustsFontSizeToFitWidth = YES;
    self.label3.baselineAdjustment = UIBaselineAdjustmentNone;
    [view4 addSubview:self.label3];
    
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 230.0f, 300.0f,40.0f)];
    [commitButton setTitle:@"正向兑换" forState:UIControlStateNormal];
    [commitButton setTitle:@"反向兑换" forState:UIControlStateSelected];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.selected = NO;
    commitButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [commitButton.layer setCornerRadius:3.0f];
    commitButton.layer.borderWidth = 0.5f;
    commitButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [commitButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:commitButton];
    
    NSString *code = [NSString stringWithFormat:@"CNY"];
    [self callSearchRateWebService:code];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,MainScreenHeight-NavigationBarHeight+1.0f);
}

- (void)selectOwnType:(id)sender
{
    
}

- (void)selectExchangeType:(id)sender
{

}

- (void)commit:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected)
    {
        self.rateDirection = 1;
        NSString *code = [NSString stringWithFormat:@"CNY"];
        [self callSearchRateWebService:code];
    }
    else
    {
        self.rateDirection = 0;
        NSString *code = [NSString stringWithFormat:@"CNY"];
        [self callSearchRateWebService:code];
    }
}

- (void)callSearchRateWebService:(NSString *)code
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/app/currency_rate"];
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
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%@",code] forKey:@"code"];
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
        
        NSLog(@"data = %@",data);
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 0)
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"加载失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            NSString *result = [data objectForKey:@"result"];
        
            if (self.rateDirection == 0)
            {
                self.rateLabel.text = [NSString stringWithFormat:@"汇率: %.8f",1/[result doubleValue]];
                
                self.label1.text = [NSString stringWithFormat:@"100美元(USD)"];
                self.label3.text = [NSString stringWithFormat:@"%.2f人民币(RMB)",(1/[result doubleValue])*100];
                
                self.ownTypeLabel.text = [NSString stringWithFormat:@"美元（USD）"];
                self.exchangeLabel.text = [NSString stringWithFormat:@"人民币（CNY）"];
            }
            else
            {
                self.rateLabel.text = [NSString stringWithFormat:@"汇率: %.8f",[result doubleValue]];
                
                self.label1.text = [NSString stringWithFormat:@"100人民币(RMB)"];
                self.label3.text = [NSString stringWithFormat:@"%.2f美元(USD)",[result doubleValue]*100];
                
                self.ownTypeLabel.text = [NSString stringWithFormat:@"人民币（CNY）"];
                self.exchangeLabel.text = [NSString stringWithFormat:@"美元（USD）"];
            }

        }
    }
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


@end
