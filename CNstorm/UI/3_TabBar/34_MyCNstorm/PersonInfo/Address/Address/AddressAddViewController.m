//
//  AddressAddViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-21.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "AddressAddViewController.h"

@interface AddressAddViewController ()

@end

@implementation AddressAddViewController

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
    
    self.navigationItem.title = @"新增收货地址";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAddress:)];
    
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

- (void)saveAddress:(id)sender
{
    [self.recevicerTextField resignFirstResponder];
    [self.telePhoneTextField resignFirstResponder];
    [self.mailCodeTextField resignFirstResponder];
    [self.addressDetailTextView resignFirstResponder];
    
    float yoffset = -(self.view.center.y-MainScreenHeight/2);

    if([self.recevicerTextField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入姓名" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if([self.telePhoneTextField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入手机/电话" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if([self.mailCodeTextField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入邮政编码" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if (self.countryLabel.tag == 0)
    {
        [MBProgressHUD showError:@"请选择国家" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if (self.provinceLabel.tag == 0)
    {
        [MBProgressHUD showError:@"请选择省份" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if([self.addressDetailTextView.text isEqualToString:@"市/区/街区详细地址"])
    {
        [MBProgressHUD showError:@"请输入详细地址" toYOffset:yoffset toView:self.view];
        return;
    }
    
    [self callAddWebService];
}

- (void)initMyView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f];
    [self.scrollView setScrollEnabled:YES];
    [self.view addSubview:self.scrollView];
    
    UIView *setView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, MainScreenHeight-NavigationBarHeight-TransparentBarHeight, 320.0f, 50.0f)];
    setView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.9f];
    [self.view addSubview:setView];
    
    self.setDefaultButton = [[UIButton alloc]initWithFrame:CGRectMake(85.0f, 10.0f, 150.0f,30.0f)];
    [self.setDefaultButton setTitle:@"设为默认收货地址" forState:UIControlStateNormal];
    self.setDefaultButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.setDefaultButton setBackgroundColor:[UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:1.0f]];
    self.setDefaultButton.selected = YES;
    [self.setDefaultButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.setDefaultButton addTarget:self action:@selector(setDefault:) forControlEvents:UIControlEventTouchUpInside];
    self.setDefaultButton.layer.cornerRadius = 15.0f;
    [setView addSubview:self.setDefaultButton];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 12.0f, 300.0f, 40.0f)];
    view1.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view1.layer.cornerRadius = 6.0f;
    view1.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view1.layer.borderWidth = 0.5f;
    [self.scrollView addSubview:view1];
    
    self.recevicerTextField = [[UITextField alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 280.0f, 40.0f)];
    self.recevicerTextField.delegate = self;
    self.recevicerTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.recevicerTextField.placeholder = @"收货人姓名";
    self.recevicerTextField.textAlignment = NSTextAlignmentLeft;
    [self.recevicerTextField setFont:[UIFont systemFontOfSize:14.0f]];
    self.recevicerTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    self.recevicerTextField.returnKeyType = UIReturnKeyDone;//return键的类型
    self.recevicerTextField.keyboardType = UIKeyboardTypeDefault;//键盘类型
    [view1 addSubview:self.recevicerTextField];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 64.0f, 300.0f, 40.0f)];
    view2.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view2.layer.cornerRadius = 6.0f;
    view2.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view2.layer.borderWidth = 0.5f;
    [self.scrollView addSubview:view2];
    
    self.telePhoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 280.0f, 40.0f)];
    self.telePhoneTextField.delegate = self;
    self.telePhoneTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.telePhoneTextField.placeholder = @"手机或固定电话";
    self.telePhoneTextField.textAlignment = NSTextAlignmentLeft;
    [self.telePhoneTextField setFont:[UIFont systemFontOfSize:14.0f]];
    self.telePhoneTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    self.telePhoneTextField.returnKeyType = UIReturnKeyDone;//return键的类型
    self.telePhoneTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//键盘类型
    [view2 addSubview:self.telePhoneTextField];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 116.0f, 300.0f, 40.0f)];
    view3.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view3.layer.cornerRadius = 6.0f;
    view3.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view3.layer.borderWidth = 0.5f;
    [self.scrollView addSubview:view3];
    
    self.mailCodeTextField = [[UITextField alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 280.0f, 40.0f)];
    self.mailCodeTextField.delegate = self;
    self.mailCodeTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.mailCodeTextField.placeholder = @"6位邮政编码";
    self.mailCodeTextField.textAlignment = NSTextAlignmentLeft;
    [self.mailCodeTextField setFont:[UIFont systemFontOfSize:14.0f]];
    self.telePhoneTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    self.mailCodeTextField.returnKeyType = UIReturnKeyDone;//return键的类型
    self.mailCodeTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//键盘类型
    [view3 addSubview:self.mailCodeTextField];
    
    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 168.0f, 300.0f, 40.0f)];
    view4.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view4.layer.cornerRadius = 6.0f;
    view4.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view4.layer.borderWidth = 0.5f;
    view4.userInteractionEnabled = YES;
    [self.scrollView addSubview:view4];
    
    self.countryLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 270.0f, 40.0f)];
    self.countryLabel.text = [NSString stringWithFormat:@"选择国家"];
    self.countryLabel.textColor = [UIColor colorWithRed:(200.0f/255.0f) green:(200.0f/255.0f) blue:(200.0f/255.0f) alpha:1.0f];
    self.countryLabel.textAlignment = NSTextAlignmentLeft;
    self.countryLabel.font = [UIFont systemFontOfSize:14.0f];
    self.countryLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.countryLabel.numberOfLines = 1;
    self.countryLabel.textAlignment = NSTextAlignmentLeft;
    self.countryLabel.adjustsFontSizeToFitWidth = YES;
    self.countryLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view4 addSubview:self.countryLabel];
    
    UIImageView *arrowImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(284.0f,14.8f, 6.0f, 10.5f)];
    [arrowImageView1 setImage:[UIImage imageNamed:@"accessoryView"]];
    [view4 addSubview:arrowImageView1];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushCountryViewTapped:)];
    tap1.numberOfTapsRequired = 1;
    [view4 addGestureRecognizer:tap1];
    
    
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 220.0f, 300.0f, 40.0f)];
    view5.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view5.layer.cornerRadius = 6.0f;
    view5.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view5.layer.borderWidth = 0.5f;
    view5.userInteractionEnabled = YES;
    [self.scrollView addSubview:view5];
    
    self.provinceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 270.0f, 40.0f)];
    self.provinceLabel.text = [NSString stringWithFormat:@"选择省/洲"];
    self.provinceLabel.textColor = [UIColor colorWithRed:(200.0f/255.0f) green:(200.0f/255.0f) blue:(200.0f/255.0f) alpha:1.0f];
    self.provinceLabel.textAlignment = NSTextAlignmentLeft;
    self.provinceLabel.font = [UIFont systemFontOfSize:14.0f];
    self.provinceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.provinceLabel.numberOfLines = 1;
    self.provinceLabel.textAlignment = NSTextAlignmentLeft;
    self.provinceLabel.adjustsFontSizeToFitWidth = YES;
    self.provinceLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view5 addSubview:self.provinceLabel];
    
    UIImageView *arrowImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(284.0f,14.8f, 6.0f, 10.5f)];
    [arrowImageView2 setImage:[UIImage imageNamed:@"accessoryView"]];
    [view5 addSubview:arrowImageView2];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushProvinceViewTapped:)];
    tap2.numberOfTapsRequired = 1;
    [view5 addGestureRecognizer:tap2];
    
    //详细市区/街区地址
    UIView *view6 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 272.0f, 300.0f, 80.0f)];
    view6.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view6.layer.cornerRadius = 6.0f;
    view6.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view6.layer.borderWidth = 0.5f;
    [self.scrollView addSubview:view6];
    
    self.addressDetailTextView = [[CPTextViewPlaceholder alloc]initWithFrame:CGRectMake(5.0f, 0.0f, 290.0f, 80.0f)];
    self.addressDetailTextView.delegate = self;
    self.addressDetailTextView.backgroundColor = [UIColor clearColor];
    self.addressDetailTextView.placeholder = [NSString stringWithFormat:@"市/区/街区详细地址"];
    self.addressDetailTextView.textColor = [UIColor colorWithRed:(200.0f/255.0f) green:(200.0f/255.0f) blue:(200.0f/255.0f) alpha:1.0f];
    self.addressDetailTextView.textAlignment = NSTextAlignmentLeft;
    [self.addressDetailTextView setFont:[UIFont systemFontOfSize:14.0f]];
    self.addressDetailTextView.returnKeyType = UIReturnKeyDone;//return键的类型
    self.addressDetailTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.addressDetailTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    [view6 addSubview:self.addressDetailTextView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, MainScreenHeight-NavigationBarHeight+1);
}

- (void)pushCountryViewTapped:(id)sender
{
    [self.recevicerTextField resignFirstResponder];
    [self.telePhoneTextField resignFirstResponder];
    [self.addressDetailTextView resignFirstResponder];
    [self.mailCodeTextField resignFirstResponder];
    
    CountryViewController *countryViewController = [[CountryViewController alloc]initWithNibName:@"CountryViewController" bundle:nil];
    countryViewController.delegate = self;
    [self.navigationController pushViewController:countryViewController animated:YES];
}

- (void)pushProvinceViewTapped:(id)sender
{
    [self.recevicerTextField resignFirstResponder];
    [self.telePhoneTextField resignFirstResponder];
    [self.addressDetailTextView resignFirstResponder];
    [self.mailCodeTextField resignFirstResponder];
    
    if (self.countryLabel.tag == 0)
    {
        float yoffset = -(self.view.center.y-MainScreenHeight/2);
        [MBProgressHUD showError:@"请选择国家" toYOffset:yoffset toView:self.view];
        return;
    }
    
    ProvinceViewController *provinceViewController = [[ProvinceViewController alloc]initWithNibName:@"ProvinceViewController" bundle:nil];
    provinceViewController.delegate = self;
    provinceViewController.selectedCountryId = (int)self.countryLabel.tag;
    [self.navigationController pushViewController:provinceViewController animated:YES];
}

- (void)didFinishedReturnCountry:(Country *)selectedCountry
{
    self.countryLabel.text = [NSString stringWithFormat:@"%@",selectedCountry.name];
    self.countryLabel.tag = selectedCountry.country_id;
    self.countryLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    
    //清空 省／洲
    self.provinceLabel.text = [NSString stringWithFormat:@"选择省/洲"];
    self.provinceLabel.tag = 0;
    self.provinceLabel.textColor = [UIColor colorWithRed:(200.0f/255.0f) green:(200.0f/255.0f) blue:(200.0f/255.0f) alpha:1.0f];
}

- (void)didFinishedReturnProvince:(Province *)selectedProvince
{
    self.provinceLabel.text = [NSString stringWithFormat:@"%@",selectedProvince.name];
    self.provinceLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.provinceLabel.tag = selectedProvince.zone_id;
}

- (void)setDefault:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected)
    {
        [self.setDefaultButton setBackgroundColor:[UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:1.0f]];
    }
    else
    {
        [self.setDefaultButton setBackgroundColor:[UIColor colorWithRed:(200.0f/255.0f) green:(200.0f/255.0f) blue:(200.0f/255.0f) alpha:1.0f]];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField != self.recevicerTextField)
    {
        if(MainScreenHeight == 480.0f)
        {
            self.scrollView.contentSize = CGSizeMake(MainScreenWidth,MainScreenHeight-NavigationBarHeight+60.0f);
            
            [self.scrollView scrollRectToVisible:CGRectMake(0.0f,60.0f,MainScreenWidth,MainScreenHeight-NavigationBarHeight) animated:YES];
        }
        else if(MainScreenHeight == 568.0f)
        {
            self.scrollView.contentSize = CGSizeMake(MainScreenWidth,MainScreenHeight-NavigationBarHeight+50.0f);
            
            [self.scrollView scrollRectToVisible:CGRectMake(0.0f,50.0f,MainScreenWidth,MainScreenHeight-NavigationBarHeight) animated:YES];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth,MainScreenHeight-NavigationBarHeight+1.0f);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth,MainScreenHeight-NavigationBarHeight+1.0f);
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(MainScreenHeight == 480.0f)
    {
        self.scrollView.contentSize = CGSizeMake(MainScreenWidth,MainScreenHeight-NavigationBarHeight+180.0f);
        
        [self.scrollView scrollRectToVisible:CGRectMake(0.0f,180.0f,MainScreenWidth,MainScreenHeight-NavigationBarHeight) animated:YES];
    }
    else if(MainScreenHeight == 568.0f)
    {
        self.scrollView.contentSize = CGSizeMake(MainScreenWidth,MainScreenHeight-NavigationBarHeight+100.0f);
        
        [self.scrollView scrollRectToVisible:CGRectMake(0.0f,100.0f,MainScreenWidth,MainScreenHeight-NavigationBarHeight) animated:YES];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth,MainScreenHeight-NavigationBarHeight+1.0f);
}

//控制输入文字的长度和内容，可通调用以下代理方法实现
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        //禁止输入换行
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

/*****************************增加收货地址接口**********************************/
- (void)callAddWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/address/address_update"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];

	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestFinished:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];

    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld", customer.customerid]forKey:@"customerId"];
    [param setValue:[NSString stringWithFormat:@"%@", self.recevicerTextField.text]forKey:@"recevicer"];
    [param setValue:[NSString stringWithFormat:@"%@", self.telePhoneTextField .text]forKey:@"telePhone"];
    [param setValue:[NSString stringWithFormat:@"%d", (int)self.countryLabel.tag]forKey:@"country"];
    [param setValue:[NSString stringWithFormat:@"%d", (int)self.provinceLabel.tag]forKey:@"province"];
    [param setValue:[NSString stringWithFormat:@"%@", self.addressDetailTextView .text]forKey:@"addressDetail"];
    [param setValue:[NSString stringWithFormat:@"%@", self.mailCodeTextField .text]forKey:@"mailCode"];
    [param setValue:[NSString stringWithFormat:@"%d",self.setDefaultButton.selected] forKey:@"isDefault"];
    
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在保存";
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
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 1)
        {
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"success"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"新增成功";
            
            [self popToRootView];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedReturn:)])
            {
                [self.delegate didFinishedReturn:self];
            }
        }
        else
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"新增失败";
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
    
    if ([request error])
    {
        request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
        request.hud.mode = MBProgressHUDModeCustomView;
        request.hud.removeFromSuperViewOnHide = YES;
        request.hud.labelText = @"网络异常";
        request.hud.detailsLabelText = @"请检查网络重试";
    }
}

@end