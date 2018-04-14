//
//  ForgetPasswordViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-30.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

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
    [titleLabel setText:@"忘记密码"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setTextColor:[UIColor whiteColor]];
    titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    self.navigationItem.titleView = titleLabel;
    
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
    
    UIImageView *emailImageView = [[UIImageView alloc]initWithFrame:CGRectMake(6.0f, 13.5f, 16.0f, 13.0f)];
    [emailImageView setImage:[UIImage imageNamed:@"email"]];
    [view1 addSubview:emailImageView];
    
    self.emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(28.0f, 0.0f, 213.5f, 40.0f)];
    self.emailTextField.delegate = self;
    self.emailTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.emailTextField.placeholder = @"请填写注册邮箱";
    self.emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    self.emailTextField.textAlignment = NSTextAlignmentLeft;
    [self.emailTextField setFont:[UIFont systemFontOfSize:14.0f]];
    
    self.emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    self.emailTextField.returnKeyType = UIReturnKeyNext;//return键的类型
    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;//键盘类型
    [view1 addSubview:self.emailTextField];
    
    self.resetButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f,70.0f,300.0f,40.0f)];
    [self.resetButton setTitle:@"重置密码" forState:UIControlStateNormal];
    self.resetButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [self.resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.resetButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [self.resetButton.layer setCornerRadius:3.0f];
    self.resetButton.layer.borderWidth = 0.5f;
    self.resetButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [self.resetButton addTarget:self action:@selector(lockPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.resetButton];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,MainScreenHeight-NavigationBarHeight+1.0f);
}

//点击确认发送邮件／发送Email按钮
- (void)lockPasswordAction:(id)sender
{
    [self.emailTextField resignFirstResponder];
    
    float yoffset = -(self.view.center.y-self.resetButton.center.y)+NavigationBarHeight;
    
    if ([self.emailTextField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请填写注册邮箱" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if(![self isValidateEmail:self.emailTextField.text])
    {
        [MBProgressHUD showError:@"邮箱格式不正确" toYOffset:yoffset toView:self.view];
        return;
    }
    
    [self lockPasswordWithEmail:self.emailTextField.text];
}

//control退出键盘
- (void)backgroundTap:(id)sender
{
    [self.emailTextField resignFirstResponder];
}

//textField开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.emailTextField resignFirstResponder];
    
    return YES;
}

//利用正则表达式验证
//邮箱
-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTestEmail = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTestEmail evaluateWithObject:email];
}


//忘记密码发送邮件
- (void)lockPasswordWithEmail:(NSString *)email
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/user/forgotten"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestSendFailed:)];
    [request setDidFinishSelector:@selector(requestSendFinished:)];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:email forKey:@"email"];
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在发送";
    request.hud.detailsLabelText = @"请稍候";
    request.hud.yOffset = -(self.view.center.y-self.resetButton.center.y)+NavigationBarHeight;
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestSendFinished:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSString *responseString =[request responseString];
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *data= [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        if(resultCode == 0)
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"发送失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else if(resultCode == 1)
        {
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"success"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"发送成功";
            request.hud.detailsLabelText = @"请前往邮箱";
        }
    }
}

- (void)requestSendFailed:(ASIHTTPRequest *)request
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
