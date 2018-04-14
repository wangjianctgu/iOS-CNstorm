//
//  RegisterViewController.m
//  LoginTest
//
//  Created by EBS1 on 14-3-17.
//  Copyright (c) 2014年 Foxconn. All rights reserved.
//

#import "RegisterViewController.h"

#import "UserAgreementViewController.h"

#import "MD5.h"


@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    
    if (self.registerType == 0)
    {
        self.navigationItem.title = [NSString stringWithFormat:@"会员注册"];
    }
    else
    {
        self.navigationItem.title = [NSString stringWithFormat:@"补填注册资料"];
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
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

- (void)initMyView
{
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
    
    UIImageView *nameImageView = [[UIImageView alloc]initWithFrame:CGRectMake(6.0f, 13.5f, 16.0f, 13.0f)];
    [nameImageView setImage:[UIImage imageNamed:@"email"]];
    [view1 addSubview:nameImageView];
    
    self.emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(28.0f, 0.0f, 213.5f, 40.0f)];
    self.emailTextField.delegate = self;
    self.emailTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.emailTextField.placeholder = @"邮箱";
    self.emailTextField.textAlignment = NSTextAlignmentLeft;
    [self.emailTextField setFont:[UIFont systemFontOfSize:14.0f]];
    self.emailTextField.returnKeyType = UIReturnKeyNext;//return键的类型
    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;//键盘类型
    self.emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    [view1 addSubview:self.emailTextField];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 64.0f, 300.0f, 40.0f)];
    view2.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view2.layer.cornerRadius = 6.0f;
    view2.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view2.layer.borderWidth = 0.5f;
    [self.scrollView addSubview:view2];
    
    UIImageView *userNameImageView = [[UIImageView alloc]initWithFrame:CGRectMake(6.0f, 12.0f, 16.0f, 16.0f)];
    [userNameImageView setImage:[UIImage imageNamed:@"nickname_"]];
    [view2 addSubview:userNameImageView];
    
    self.userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(28.0f, 0.0f, 213.5f, 40.0f)];
    self.userNameTextField.delegate = self;
    self.userNameTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.userNameTextField.placeholder = @"昵称";
    if (self.registerType == 1)
    {
        self.userNameTextField.text = self.tname;
    }
    self.userNameTextField.textAlignment = NSTextAlignmentLeft;
    [self.userNameTextField setFont:[UIFont systemFontOfSize:14.0f]];
    self.userNameTextField.returnKeyType = UIReturnKeyNext;//return键的类型
    self.userNameTextField.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.userNameTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    [view2 addSubview:self.userNameTextField];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 116.0f, 300.0f, 40.0f)];
    view3.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view3.layer.cornerRadius = 6.0f;
    view3.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view3.layer.borderWidth = 0.5f;
    [self.scrollView addSubview:view3];
    
    UIImageView *passwordImageView = [[UIImageView alloc]initWithFrame:CGRectMake(9.0f, 12.0f, 10.0f, 16.0f)];
    [passwordImageView setImage:[UIImage imageNamed:@"password"]];
    [view3 addSubview:passwordImageView];
    
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
    [view3 addSubview:self.passwordTextField];
    
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
    [view3 addSubview:pswSwitch];
    
    self.registerButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 180.0f, 300.0f,40.0f)];
    if (self.registerType == 0)
    {
        [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    }
    else
    {
        [self.registerButton setTitle:@"补填注册资料" forState:UIControlStateNormal];
    }
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.registerButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [self.registerButton.layer setCornerRadius:3.0f];
    self.registerButton.layer.borderWidth = 0.5f;
    self.registerButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [self.registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.registerButton];

    self.agreeButton = [[UIButton alloc]initWithFrame:CGRectMake(20.0f, 235.0f, 20.0f,20.0f)];
    self.agreeButton.selected = YES;
    [self.agreeButton setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    [self.agreeButton setBackgroundImage:[UIImage imageNamed:@"uncheck_selected"] forState:UIControlStateSelected];
    [self.agreeButton addTarget:self action:@selector(isAgreeUserAgreement:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.agreeButton];
    
    self.agreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(40.0f, 230.0f, 275.0f, 32.0f)];
    self.agreeLabel.text = @"《CNstorm会员服务协议》";
    self.agreeLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:1.0f];
    self.agreeLabel.font = [UIFont systemFontOfSize:14.0f];
    self.agreeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.agreeLabel.numberOfLines = 1;
    self.agreeLabel.textAlignment = NSTextAlignmentLeft;
    self.agreeLabel.adjustsFontSizeToFitWidth = YES;
    self.agreeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    self.agreeLabel.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.agreeLabel];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushUserAgreementView:)];
    tap2.numberOfTapsRequired = 1;
    [self.agreeLabel addGestureRecognizer:tap2];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth,MainScreenHeight-NavigationBarHeight+1.0f);
}

- (void)hideShowPassword:(id)sender;
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

- (void)isAgreeUserAgreement:(id)sender
{
    UIButton *agreeButton = (UIButton *)sender;
    
    if(agreeButton.selected == YES)
    {
        agreeButton.selected = NO;
        self.agreeLabel.textColor = [UIColor colorWithRed:(152.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    }
    else
    {
        agreeButton.selected = YES;
        self.agreeLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:1.0f];
    }
}

- (void)pushUserAgreementView:(id)sender
{
    UserAgreementViewController *userAgreementViewController = [[UserAgreementViewController alloc]initWithNibName:@"UserAgreementViewController" bundle:nil];

    [self.navigationController pushViewController:userAgreementViewController animated:YES];
}

- (void)registerAction:(id)sender
{
    [self backgroundTap:sender];
    
    float yoffset = -(self.view.center.y-self.registerButton.center.y)+NavigationBarHeight;
    
    if([self.emailTextField.text isEqualToString:@""]&&[self.userNameTextField.text isEqualToString:@""]&&[self.passwordTextField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入邮箱/昵称/密码" toYOffset:yoffset toView:self.view];
        return;
    }
    else if ([self.emailTextField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入邮箱" toYOffset:yoffset toView:self.view];
        return;
    }
    else if([self.userNameTextField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入昵称" toYOffset:yoffset toView:self.view];
        return;
    }
    else if([self.passwordTextField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入密码" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if(![self isValidateEmail:self.emailTextField.text])
    {
        [MBProgressHUD showError:@"邮箱格式不正确" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if(![self isValidateUsername:self.userNameTextField.text])
    {
        [MBProgressHUD showError:@"昵称长度在1-32个字符之间" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if(![self isValidatePassword:self.passwordTextField.text])
    {
        [MBProgressHUD showError:@"密码长度在4-20个字符之间" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if(self.agreeButton.selected == NO)
    {
        [MBProgressHUD showError:@"请勾选服务协议" toYOffset:yoffset toView:self.view];
        return;
    }

    [self registerWithEmail:self.emailTextField.text userName:self.userNameTextField.text password:self.passwordTextField.text];
}


//方法:control退出键盘
- (void)backgroundTap:(id)sender
{
    [self.emailTextField resignFirstResponder];
    
	[self.userNameTextField resignFirstResponder];
    
    [self.passwordTextField resignFirstResponder];
}

- (void)textFieldReturnEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.emailTextField)
    {
        [self.emailTextField resignFirstResponder];
        
        [self.userNameTextField becomeFirstResponder];
    }
    else if (textField == self.userNameTextField)
    {
        [self.userNameTextField resignFirstResponder];
        
        [self.passwordTextField becomeFirstResponder];
    }
    else if (textField == self.passwordTextField)
    {
        [self.passwordTextField resignFirstResponder];
    }
    
    return YES;
}

//利用正则表达式验证
//邮箱
-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

-(BOOL)isValidateUsername:(NSString *)username
{
//    NSString *usernameRegex = @"^[\u4e00-\u9fa5_a-zA-Z0-9._]{1,32}";
//    
//    NSPredicate *usernameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", usernameRegex];
//    
//    return [usernameTest evaluateWithObject:username];
    if (username.length>=1 && username.length<=32)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(BOOL)isValidatePassword:(NSString *)password
{
//    NSString *passwordRegex = @"^[a-zA-Z0-9._]{4,20}";
//    
//    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
//    
//    return [passwordTest evaluateWithObject:password];
    
    if (password.length>=4 && password.length<=20)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//注册接口
- (void)registerWithEmail:(NSString *)email userName:(NSString *)userName password:(NSString *)password
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/user/regedit"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestRegisterFailed:)];
    [request setDidFinishSelector:@selector(requestRegisterFinished:)];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:email forKey:@"email"];
    [param setValue:userName forKey:@"userName"];
    [param setValue:password forKey:@"password"];
    if (self.registerType == 1)
    {
        [param setValue:self.type forKey:@"type"];
        [param setValue:self.uid forKey:@"uid"];
        [param setValue:self.tname forKey:@"tname"];
        [param setValue:self.image forKey:@"face"];
    }

    NSString *paramJson = [param JSONRepresentation];
    NSLog(@"paramJson = %@",paramJson);
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在注册";
    request.hud.detailsLabelText = @"请稍候";
    request.hud.yOffset = -(self.view.center.y-self.registerButton.center.y)+NavigationBarHeight;
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestRegisterFinished:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSString *responseString =[request responseString];
        
        NSLog(@"register responseString = %@",responseString);
        
        //官方的Json速度最快
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data= [dataDictionary objectForKey:@"data"];
        
        if (!data || [data isEqual:@"(null)"])
        {
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"注册失败";
            return;
        }
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        if(resultCode == 1)
        {
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"success"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"注册成功";
            request.hud.detailsLabelText = @"自动登录";
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedRegisterSuccess:andHud:)])
            {
                [self.navigationController popViewControllerAnimated:YES];
                [self.delegate didFinishedRegisterSuccess:self andHud:request.hud];
            }
        }
        else
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"注册失败";
            request.hud.detailsLabelText = errorMessage;
        }
    }
}

- (void)requestRegisterFailed:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error.png"]]];
    request.hud.mode = MBProgressHUDModeCustomView;
    request.hud.removeFromSuperViewOnHide = YES;
    request.hud.labelText = @"网络异常";
    request.hud.detailsLabelText = @"请检查网络";
}

@end
