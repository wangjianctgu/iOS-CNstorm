//
//  UpdatePswViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-23.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "UpdatePswViewController.h"

@interface UpdatePswViewController ()

@end

@implementation UpdatePswViewController

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
    self.navigationItem.title = @"修改密码";
    
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
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 12.0f, 300.0f, 40.0f)];
    view1.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view1.layer.cornerRadius = 6.0f;
    view1.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view1.layer.borderWidth = 0.5f;
    [self.scrollView addSubview:view1];
    
    self.pswTextField = [[UITextField alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 226.5f, 40.0f)];
    self.pswTextField.delegate = self;
    self.pswTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.pswTextField.placeholder = @"请输入原密码";
    self.pswTextField.backgroundColor = [UIColor whiteColor];
    self.pswTextField.textAlignment = NSTextAlignmentLeft;
    [self.pswTextField setFont:[UIFont systemFontOfSize:14.0f]];
    self.pswTextField.returnKeyType = UIReturnKeyDone;//return键的类型
    self.pswTextField.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.pswTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    [view1 addSubview:self.pswTextField];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 62.0f, 300.0f, 40.0f)];
    view2.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view2.layer.cornerRadius = 6.0f;
    view2.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view2.layer.borderWidth = 0.5f;
    [self.scrollView addSubview:view2];
    
    self.npswTextField = [[UITextField alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 226.5f, 40.0f)];
    self.npswTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.npswTextField.placeholder = @"请输入新密码";
    self.npswTextField.backgroundColor = [UIColor whiteColor];
    self.npswTextField.textAlignment = NSTextAlignmentLeft;
    [self.npswTextField setFont:[UIFont systemFontOfSize:14.0f]];
    self.npswTextField.returnKeyType = UIReturnKeyDone;//return键的类型
    self.npswTextField.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.npswTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    [view2 addSubview:self.npswTextField];
    
    ZJSwitch *pswSwitch = [[ZJSwitch alloc] initWithFrame:CGRectMake(236.5f, 7.5f, 53.5f, 24.5f)];
    pswSwitch.backgroundColor = [UIColor clearColor];
    pswSwitch.thumbTintColor = [UIColor whiteColor];
    pswSwitch.tintColor = [UIColor whiteColor];
    pswSwitch.onTintColor = [UIColor whiteColor];
    pswSwitch.textColor = [UIColor colorWithRed:(51.0f)/255.0f green:(51.0f)/255.0f blue:(51.0f)/255.0f alpha:1];
    pswSwitch.on = NO;
    pswSwitch.onText = @"●●●";
    pswSwitch.offText = @"ABC";
    [pswSwitch addTarget:self action:@selector(hideShowPassword:) forControlEvents:UIControlEventValueChanged];
    [view2 addSubview:pswSwitch];

    
    UILabel *validateLable = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 112.0f, 290.0f, 23.0f)];
    validateLable.text = @"至少6位的数字、字母组合，区分大小写。";
    validateLable.textColor = [UIColor colorWithRed:(153.0f)/255.0f green:(153.0f)/255.0f blue:(153.0f)/255.0f alpha:1];;
    validateLable.font = [UIFont systemFontOfSize:12.0f];
    validateLable.lineBreakMode = NSLineBreakByTruncatingTail;
    validateLable.numberOfLines = 1;
    validateLable.textAlignment = NSTextAlignmentLeft;
    validateLable.baselineAdjustment = UIBaselineAdjustmentNone;
    [self.scrollView addSubview:validateLable];
    
    
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 150.0f, 300.0f,40.0f)];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [commitButton.layer setCornerRadius:3.0f];
    commitButton.layer.borderWidth = 0.5f;
    commitButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [commitButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:commitButton];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,MainScreenHeight-NavigationBarHeight+1.0f);
}

- (void)hideShowPassword:(id)sender
{
    ZJSwitch *pswSwitch = (ZJSwitch *)sender;
    if (pswSwitch.on)
    {
        self.npswTextField.secureTextEntry = YES;
    }
    else
    {
        self.npswTextField.secureTextEntry = NO;
    }
}

- (void)commit:(id)sender
{
    //判断原密码是否匹配
    
    //修改密码接口
    [self callUpdatePswWebService];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

/*****************************修改密码接口**********************************/
- (void)callUpdatePswWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/user/editPassword"];
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
    [param setValue:[NSString stringWithFormat:@"%@",self.pswTextField.text] forKey:@"oldPassword"];
    [param setValue:[NSString stringWithFormat:@"%@",self.npswTextField.text] forKey:@"newPassword"];
    
    NSString *paramJson = [param JSONRepresentation];
    NSLog(@"paramJson = %@",paramJson);
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在修改";
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
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 0)
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"修改失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"success"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"修改成功";
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
