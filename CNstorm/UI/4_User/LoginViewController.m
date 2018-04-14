//
//  LoginViewController.m
//  LoginTest
//
//  Created by EBS1 on 14-3-17.
//  Copyright (c) 2014年 Foxconn. All rights reserved.
//

#import "LoginViewController.h"

#import "DaiDodgeKeyboard.h"

@implementation UIView (FindFirstResponder)

-(UIView*) findFirstResponder
{
    if (self.isFirstResponder) return self;
    for (UIView *subView in self.subviews)
    {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) return firstResponder;
    }
    return nil;
}

@end

@interface LoginViewController ()

- (UIToolbar*)createToolbar;
- (void)nextTextField;
- (void)prevTextField;
- (void)textFieldDone;
- (NSArray*)inputViews;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.type = [NSString stringWithFormat:@""],
        self.uid = [NSString stringWithFormat:@""];
        self.tname = [NSString stringWithFormat:@""];
        self.image = [NSString stringWithFormat:@""];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.title = @"会员登录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cancel"] style:UIBarButtonItemStylePlain target:self action:@selector(backToRootView)];
    
    [self initMyView];
    
    //键盘
    UIToolbar *toolBar = [self createToolbar];
    for (UIView *v in [self inputViews]) {
        if ([v respondsToSelector:@selector(setText:)])
        {
            [v performSelector:@selector(setDelegate:) withObject:self];
            [v performSelector:@selector(setInputAccessoryView:) withObject:toolBar];
        }
    }
    
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)backToRootView
{
    //取消登录选项卡栏回到首页
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedCancel:)])
    {
        [self.delegate didFinishedCancel:self];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        //这里打个断点，点击按钮模态视图移除后会回到这里
        //ios 5.0以上可以用该方法
    }];
}

- (void)initMyView
{
    self.view.frame = CGRectMake(0.0f,0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f,0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f];
    [self.scrollView setScrollEnabled:YES];
    [self.view addSubview:self.scrollView];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap:)];
    tap1.numberOfTapsRequired = 1;//不同的实体数目
    [self.scrollView addGestureRecognizer:tap1];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 12.0f, 300.0f, 40.0f)];
    view1.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view1.layer.cornerRadius = 6.0f;
    view1.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view1.layer.borderWidth = 0.5f;
    [self.scrollView addSubview:view1];
    
    UIImageView *nameImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8.5f, 12.0f, 11.0f, 16.0f)];
    [nameImageView setImage:[UIImage imageNamed:@"account"]];
    [view1 addSubview:nameImageView];
    
    //用户名（昵称）/邮箱
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(28.0f, 0.0f, 213.5f, 40.0f)];
    self.nameTextField.delegate = self;
    self.nameTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.nameTextField.placeholder = @"邮箱/用户名";
    self.nameTextField.textAlignment = NSTextAlignmentLeft;
    [self.nameTextField setFont:[UIFont systemFontOfSize:14.0f]];
    self.nameTextField.returnKeyType = UIReturnKeyNext;//return键的类型
    self.nameTextField.keyboardType = UIKeyboardTypeEmailAddress;//键盘类型
    self.nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    [view1 addSubview:self.nameTextField];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 64.0f, 300.0f, 40.0f)];
    view2.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view2.layer.cornerRadius = 6.0f;
    view2.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view2.layer.borderWidth = 0.5f;
    [self.scrollView addSubview:view2];
    
    UIImageView *passwordImageView = [[UIImageView alloc]initWithFrame:CGRectMake(9.0f, 12.0f, 10.0f, 16.0f)];
    [passwordImageView setImage:[UIImage imageNamed:@"password"]];
    [view2 addSubview:passwordImageView];
    
    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(28.0f, 0.0f, 213.5f, 40.0f)];
    self.passwordTextField.delegate = self;
    self.passwordTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.passwordTextField.placeholder = @"输入密码";
    self.passwordTextField.textAlignment = NSTextAlignmentLeft;
    self.passwordTextField.secureTextEntry = YES;
    [self.passwordTextField setFont:[UIFont systemFontOfSize:14.0f]];
    self.passwordTextField.returnKeyType = UIReturnKeyDone;//return键的类型
    self.passwordTextField.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    [view2 addSubview:self.passwordTextField];
    
    ZJSwitch *pswSwitch = [[ZJSwitch alloc] initWithFrame:CGRectMake(241.5f, 7.5f, 53.5f, 24.5f)];
    pswSwitch.backgroundColor = [UIColor clearColor];
    pswSwitch.thumbTintColor = [UIColor whiteColor];
    pswSwitch.tintColor = [UIColor whiteColor];
    pswSwitch.onTintColor = [UIColor whiteColor];
    pswSwitch.textColor = [UIColor colorWithRed:(51.0f)/255.0f green:(51.0f)/255.0f blue:(51.0f)/255.0f alpha:1];
    [pswSwitch setOn:YES];
    pswSwitch.onText = @"●●●";
    pswSwitch.offText = @"Abc";
    [pswSwitch addTarget:self action:@selector(hideShowPassword:) forControlEvents:UIControlEventValueChanged];
    [view2 addSubview:pswSwitch];
    
    UIButton *registerButton = [[UIButton alloc]initWithFrame:CGRectMake(15.0f, 115.0f, 60.0f,23.0f)];
    [registerButton setTitle:@"会员注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor colorWithRed:(51.0f)/255.0f green:(51.0f)/255.0f blue:(51.0f)/255.0f alpha:1.0f] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:registerButton];

    UIButton *forgetPsdButton = [[UIButton alloc]initWithFrame:CGRectMake(245.0f, 115.0f, 60.0f,23.0f)];
    [forgetPsdButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPsdButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [forgetPsdButton setTitleColor:[UIColor colorWithRed:(51.0f)/255.0f green:(51.0f)/255.0f blue:(51.0f)/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [forgetPsdButton addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:forgetPsdButton];
    
    self.loginButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 155.0f, 300.0f,40.0f)];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [self.loginButton.layer setCornerRadius:3.0f];
    self.loginButton.layer.borderWidth = 0.5f;
    self.loginButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.loginButton];
    
    UILabel *otherLable = [[UILabel alloc]initWithFrame:CGRectMake(68.0f, 235.0f, 184.0f, 23.0f)];
    otherLable.text = @"其他合作网站登录";
    otherLable.textColor = [UIColor colorWithRed:(153.0f)/255.0f green:(153.0f)/255.0f blue:(153.0f)/255.0f alpha:1];;
    otherLable.font = [UIFont systemFontOfSize:14.0f];
    otherLable.lineBreakMode = NSLineBreakByTruncatingTail;
    otherLable.numberOfLines = 1;
    otherLable.textAlignment = NSTextAlignmentCenter;
    otherLable.baselineAdjustment = UIBaselineAdjustmentNone;
    [self.scrollView addSubview:otherLable];
    
    UIButton *weiboButton = [[UIButton alloc]initWithFrame:CGRectMake(124.0f, 270.0f, 24.0f,20.0f)];
    weiboButton.backgroundColor = [UIColor clearColor];
    [weiboButton setImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
    [weiboButton addTarget:self action:@selector(loginWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:weiboButton];
    
    UIButton *qqButton = [[UIButton alloc]initWithFrame:CGRectMake(172.0f, 270.0f, 24.0f,20.0f)];
    qqButton.backgroundColor = [UIColor clearColor];
    [qqButton setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [qqButton addTarget:self action:@selector(loginQQ:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:qqButton];
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
        self.passwordTextField.secureTextEntry = YES;
    }
    else
    {
        self.passwordTextField.secureTextEntry = NO;
    }
}

- (void)loginWeibo:(id)sender
{
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               NSLog(@"result = %d",result);
                               if (result)
                               {
                                   //QQ、Weibo注册
                                   self.type = [NSString stringWithFormat:@"weibo"],
                                   self.uid = [NSString stringWithFormat:@"%@",[userInfo uid]];
                                   self.tname = [NSString stringWithFormat:@"%@",[userInfo nickname]];
                                   self.image = [NSString stringWithFormat:@"%@",[userInfo profileImage]];
                                   //判断是否注册登录接口
                                   [self loginOauthWithUid:[userInfo uid] type:@"weibo"];
                               }
                               else
                               {
                                   [MBProgressHUD showError:@"授权失败" toView:self.view];
                                   NSLog(@"error 0 = %@",error);
                                   NSLog(@"errorDescription 0 = %@",error.errorDescription);
                               }
                               
                           }];
}

- (void)loginQQ:(id)sender
{
    [ShareSDK getUserInfoWithType:ShareTypeQQSpace
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               
                               NSLog(@"result = %d",result);
                               NSLog(@"userInfo 0 = %@",userInfo);
                               
                               if (result)
                               {
                                   self.type = [NSString stringWithFormat:@"qq"],
                                   self.uid = [NSString stringWithFormat:@"%@",[userInfo uid]];
                                   self.tname = [NSString stringWithFormat:@"%@",[userInfo nickname]];
                                   self.image = [NSString stringWithFormat:@"%@",[userInfo profileImage]];
                                   
                                   //判断是否注册登录接口
                                   [self loginOauthWithUid:[userInfo uid] type:@"qq"];
                               }
                               else
                               {
                                   [MBProgressHUD showError:@"授权失败" toView:self.view];
                                   NSLog(@"error 0 = %@",error);
                                   NSLog(@"errorDescription 0 = %@",error.errorDescription);
                               
                               }
                               
                           }];
}


- (void)loginAction:(id)sender
{
    //退出键盘
    [self backgroundTap:sender];
    
    float yoffset = -(self.view.center.y-self.loginButton.center.y)+NavigationBarHeight;
    
    //判断邮箱/用户名或密码是否为空
    if([self.nameTextField.text isEqualToString:@""]&&[self.passwordTextField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入邮箱/用户名或密码" toYOffset:yoffset toView:self.view];
        return;
    }
    else if ([self.nameTextField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入邮箱/用户名" toYOffset:yoffset toView:self.view];
        return;
    }
    else if([self.passwordTextField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入密码" toYOffset:yoffset toView:self.view];
        return;
    }
    
    //登录不需要正则匹配
    //调用登录接口进行登录
    [self loginWithName:self.nameTextField.text password:self.passwordTextField.text];
}

- (void)registerAction:(id)sender
{
    RegisterViewController *registerViewController = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    registerViewController.delegate = self;
    registerViewController.registerType = 0;
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)forgetPasswordAction:(id)sender
{
    ForgetPasswordViewController *forgetPasswordViewController = [[ForgetPasswordViewController alloc]initWithNibName:@"ForgetPasswordViewController" bundle:nil];
    forgetPasswordViewController.delegate = self;
    [self.navigationController pushViewController:forgetPasswordViewController animated:YES];
}

/***************************UITextField delegate******************************/
#pragma mark - private
- (UIToolbar*)createToolbar
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 37.5)];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"  〉"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(nextTextField)];
    nextButton.tintColor = [UIColor blackColor];
    [nextButton setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"〈  "
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(prevTextField)];
    prevButton.tintColor = [UIColor blackColor];
    [prevButton setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    space.title = [NSString stringWithFormat:@"请输入注册邮箱"];
    space.tintColor = [UIColor blackColor];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    done.tintColor = [UIColor blackColor];
    [done setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.0f],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    toolBar.items = @[prevButton, nextButton, space, done];
    
    
    return toolBar;
}

- (void)nextTextField
{
    NSUInteger currentIndex = [[self inputViews] indexOfObject:[self.view findFirstResponder]];
    
    NSUInteger nextIndex = currentIndex + 1;
    nextIndex += [[self inputViews] count];
    nextIndex %= [[self inputViews] count];
    
    UITextField *nextTextField = [[self inputViews] objectAtIndex:nextIndex];
    
    [nextTextField becomeFirstResponder];
}

- (void)prevTextField
{
    
    NSUInteger currentIndex = [[self inputViews] indexOfObject:[self.view findFirstResponder]];
    
    NSUInteger prevIndex = currentIndex - 1;
    prevIndex += [[self inputViews] count];
    prevIndex %= [[self inputViews] count];
    
    UITextField *nextTextField = [[self inputViews] objectAtIndex:prevIndex];
    
    [nextTextField becomeFirstResponder];
}

- (void)textFieldDone
{
    [[self.view findFirstResponder] resignFirstResponder];
}

- (NSArray*) inputViews
{
    NSMutableArray *returnArray = [NSMutableArray array];
    
    [returnArray addObject:self.nameTextField];
    [returnArray addObject:self.passwordTextField];
    
    return returnArray;
}

//方法:control退出键盘
- (void)backgroundTap:(id)sender
{
    [self.nameTextField resignFirstResponder];
    
    [self.passwordTextField resignFirstResponder];
}

//UITextField Return按键
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //如果允许要调用resignFirstResponder 方法，这回导致结束编辑，而键盘会被收起
    if (textField == self.nameTextField)
    {
        [self.nameTextField resignFirstResponder];
        
        [self.passwordTextField becomeFirstResponder];
    }
    else if (textField == self.passwordTextField)
    {
        [self.passwordTextField resignFirstResponder];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.nameTextField)
    {

    }
    
    else if (textField == self.passwordTextField)
    {

    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (void)didFinishedRegisterSuccess:(RegisterViewController *) registerViewController andHud:(MBProgressHUD *)hud
{
    self.nameTextField.text = registerViewController.emailTextField.text;
    self.passwordTextField.text = registerViewController.passwordTextField.text;
    
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    hud.yOffset = -(self.view.center.y-self.loginButton.center.y)+NavigationBarHeight;
    [self.view addSubview:hud];
    sleep(2);
    //注册成功，自动登录
    [self loginWithName:self.nameTextField.text password:self.passwordTextField.text];
}

/***************************登录接口******************************/
- (void)loginWithName:(NSString *)name password:(NSString *)password
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/user/login"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setDidFinishSelector:@selector(requestLogin:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [userDefaults stringForKey:@"userid"];
    NSString *channelid = [userDefaults stringForKey:@"channelid"];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:name forKey:@"name"];
    [param setValue:password forKey:@"password"];
    [param setValue:userid forKey:@"userid"];
    [param setValue:channelid forKey:@"channelid"];
    [param setValue:[NSString stringWithFormat:@"1"] forKey:@"deviceType"];
    NSString *paramJson = [param JSONRepresentation];
    
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在登录";
    request.hud.detailsLabelText = @"请稍候";
    request.hud.yOffset = -(self.view.center.y-self.loginButton.center.y)+NavigationBarHeight;
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestLogin:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSLog(@"request = %@",request);
        
        NSString *responseString =[request responseString];
        NSLog(@"login responseString = %@",responseString);
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *data= [dataDictionary objectForKey:@"data"];
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if (resultCode == 1)
        {
            NSDictionary *result = [data objectForKey:@"result"];
            Customer *customer = [[Customer alloc]init];
            customer.customerid = [[result objectForKey:@"customer_id"] longLongValue];
            customer.email = [result objectForKey:@"email"];
            customer.username = [result objectForKey:@"firstname"];//用户名／昵称
            customer.tname = [result objectForKey:@"lastname"];//真实姓名
            customer.password = [result objectForKey:@"password"];
            customer.scores = [[result objectForKey:@"scores"] longLongValue];
            customer.money = [[result objectForKey:@"money"] doubleValue];
            customer.image = [result objectForKey:@"face"];
            customer.verification = [result objectForKey:@"verification"];
            
            [self initDataBase:customer];
   
            //登录成功后保存登录的用户名
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setBool:YES forKey:@"isLogin"];
            [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:customer] forKey:@"customer"];
            if ([userDefaults objectForKey:[NSString stringWithFormat:@"%lld",customer.customerid]] == nil)
            {
                //初始化圆角数字
                BadgeKeyValue *badgeKeyValue = [[BadgeKeyValue alloc]init];
                [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:badgeKeyValue] forKey:[NSString stringWithFormat:@"%lld",customer.customerid]];
            }
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"success"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"登录成功";
            request.hud.detailsLabelText = [NSString stringWithFormat:@"欢迎您"];
            
            [self dismissViewControllerAnimated:YES completion:^{
            }];

            if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedLogin:andHud:)])
            {
                [self.delegate didFinishedLogin:self andHud:request.hud];
            }
        }
        else
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"登录失败";
            request.hud.detailsLabelText = errorMessage;
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
    request.hud.detailsLabelText = @"请检查网络";
}

/***************************登录接口******************************/
- (void)loginOauthWithUid:(NSString *)uid type:(NSString *)type
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/user/oauth"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSLog(@"urlString = %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestOauthFailed:)];
    [request setDidFinishSelector:@selector(requestOauthFinish:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [userDefaults stringForKey:@"userid"];
    NSString *channelid = [userDefaults stringForKey:@"channelid"];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:uid forKey:@"uid"];
    [param setValue:type forKey:@"type"];
    
    [param setValue:userid forKey:@"userid"];
    [param setValue:channelid forKey:@"channelid"];
    [param setValue:[NSString stringWithFormat:@"1"] forKey:@"deviceType"];
    
    NSString *paramJson = [param JSONRepresentation];
    NSLog(@"paramJson = %@",paramJson);
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    if ([type isEqualToString:@"qq"])
    {
        request.hud.labelText = @"正在qq登录";
    }
    else
    {
        request.hud.labelText = @"正在微博登录";
    }
    request.hud.detailsLabelText = @"请稍候";
    request.hud.yOffset = -(self.view.center.y-self.loginButton.center.y)+NavigationBarHeight;
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestOauthFinish:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSString *responseString =[request responseString];
        NSLog(@"responseString  = %@",responseString);
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *data= [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if (resultCode == 0)
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"授权失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else if (resultCode == 1)
        {
            NSDictionary *result = [data objectForKey:@"result"];
            
            Customer *customer = [[Customer alloc]init];
            customer.customerid = [[result objectForKey:@"customer_id"] longLongValue];
            customer.email = [result objectForKey:@"email"];
            customer.username = [result objectForKey:@"firstname"];//用户名／昵称
            customer.tname = [result objectForKey:@"lastname"];//真实姓名
            customer.password = [result objectForKey:@"password"];
            customer.scores = [[result objectForKey:@"scores"] longLongValue];
            customer.money = [[result objectForKey:@"money"] doubleValue];
            customer.image = [result objectForKey:@"face"];
            customer.verification = [result objectForKey:@"verification"];
            
            [self initDataBase:customer];
            //登录成功后保存登录的用户名
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setBool:YES forKey:@"isLogin"];
            [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:customer] forKey:@"customer"];
            if ([userDefaults objectForKey:[NSString stringWithFormat:@"%lld",customer.customerid]] == nil)
            {
                //初始化圆角数字
                BadgeKeyValue *badgeKeyValue = [[BadgeKeyValue alloc]init];
                [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:badgeKeyValue] forKey:[NSString stringWithFormat:@"%lld",customer.customerid]];
            }
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"success"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"登录成功";
            request.hud.detailsLabelText = [NSString stringWithFormat:@"欢迎您"];
            
            [self dismissViewControllerAnimated:YES completion:^{
            }];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedLogin:andHud:)])
            {
                [self.delegate didFinishedLogin:self andHud:request.hud];
            }
        }
        else if (resultCode == 2)
        {
            RegisterViewController *registerViewController = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
            registerViewController.delegate = self;
            registerViewController.registerType = 1;
            registerViewController.uid = [NSString stringWithFormat:@"%@",self.uid];
            registerViewController.tname = [NSString stringWithFormat:@"%@",self.tname];
            registerViewController.type = [NSString stringWithFormat:@"%@",self.type];
            registerViewController.image = [NSString stringWithFormat:@"%@",self.image];
            
            [self.navigationController pushViewController:registerViewController animated:YES];
        }
    }
}

- (void)requestOauthFailed:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
    request.hud.mode = MBProgressHUDModeCustomView;
    request.hud.removeFromSuperViewOnHide = YES;
    request.hud.labelText = @"网络异常";
    request.hud.detailsLabelText = @"请检查网络";
}

/***************************数据库******************************/
- (void)initDataBase:(Customer *)customer
{
    SqliteHelper *helper = [[SqliteHelper alloc]initWithDataPath:[DataBaseInfo defaultDataBaseInfo].dbpath];
    @try
    {
        [helper OpenSqlite];
        [helper BeginTransaction];
        //将测试数据保存到sqlite
        if(![helper checkXubModelExist:customer])//检查数据库中是否有同一主键的行
            [helper InsertXubModel:customer throwEx:false];
        
        [helper CommitTransaction];
    }
    @catch (NSException *exception)
    {
        [helper RollbackTransaction];
    }
    @finally
    {
        [helper CloseSqlite];
    }
}

@end
