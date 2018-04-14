//
//  ExpressAddViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "ExpressAddViewController.h"

@interface ExpressAddViewController ()

@end

@implementation ExpressAddViewController

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
    self.navigationItem.title = @"补填快递单号";
    
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
    [view1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectExpressCompany:)]];
    [self.scrollView addSubview:view1];
    
    self.expressesLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 270.0f, 40.0f)];
    self.expressesLabel.text = [NSString stringWithFormat:@"请选择物流公司"];
    self.expressesLabel.textColor = [UIColor colorWithRed:(200.0f/255.0f) green:(200.0f/255.0f) blue:(200.0f/255.0f) alpha:1.0f];
    self.expressesLabel.textAlignment = NSTextAlignmentLeft;
    self.expressesLabel.font = [UIFont systemFontOfSize:14.0f];
    self.expressesLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.expressesLabel.numberOfLines = 1;
    self.expressesLabel.textAlignment = NSTextAlignmentLeft;
    self.expressesLabel.adjustsFontSizeToFitWidth = YES;
    self.expressesLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:self.expressesLabel];
    
    UIImageView *arrowImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(284.0f,14.8f, 6.0f, 10.5f)];
    [arrowImageView1 setImage:[UIImage imageNamed:@"accessoryView"]];
    [view1 addSubview:arrowImageView1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 70.0f, 300.0f, 40.0f)];
    view2.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view2.layer.cornerRadius = 6.0f;
    view2.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view2.layer.borderWidth = 0.5f;
    view2.userInteractionEnabled = YES;
    [self.scrollView addSubview:view2];
    
    self.expressesNoTextField = [[UITextField alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 280.0f, 40.0f)];
    self.expressesNoTextField.delegate = self;
    self.expressesNoTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.expressesNoTextField.placeholder = @"请填写物流单号";
    self.expressesNoTextField.textAlignment = NSTextAlignmentLeft;
    [self.expressesNoTextField setFont:[UIFont systemFontOfSize:14.0f]];
    self.expressesNoTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    self.expressesNoTextField.returnKeyType = UIReturnKeyDone;//return键的类型
    self.expressesNoTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//键盘类型
    [view2 addSubview:self.expressesNoTextField];
    
    self.commitButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 140.0f, 300.0f,40.0f)];
    [self.commitButton setTitle:@"提交" forState:UIControlStateNormal];
    self.commitButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
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

- (void)selectExpressCompany:(id)sender
{
    ExpressViewController *expressViewController = [[ExpressViewController alloc]initWithNibName:@"ExpressViewController" bundle:nil];
    expressViewController.delegate = self;
    [self.navigationController pushViewController:expressViewController animated:YES];
}

- (void)didFinishedReturnExpress:(Express *)selectedExpress
{
    if (selectedExpress)
    {
        self.selectedExpress = selectedExpress;
        self.expressesLabel.text = selectedExpress.name_cn;
        self.expressesLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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


- (void)commit:(id)sender
{
    [self.expressesNoTextField resignFirstResponder];
    
    float yoffset = -(self.view.center.y-self.commitButton.center.y)+NavigationBarHeight;

    if (!self.selectedExpress.name_en || [self.selectedExpress.name_en isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请选择快递" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if ([self.expressesNoTextField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请填写快递单号" toYOffset:yoffset toView:self.view];
        return;
    }
    
    NSString *expresses = [NSString stringWithFormat:@"%@",self.selectedExpress.name_en];
    NSString *expressesNo = [NSString stringWithFormat:@"%@",self.expressesNoTextField.text];
    
    [self callCommitExpressWebServiceWithExpresses:expresses andExpressesNo:expressesNo];
}

/**************************补填物流接口**********************************/
- (void)callCommitExpressWebServiceWithExpresses:(NSString *)expresses andExpressesNo:(NSString *)expressesNo
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/order/express_rewrite"];
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
    [param setValue:[NSString stringWithFormat:@"%@",expressesNo] forKey:@"expressNo"];
    [param setValue:[NSString stringWithFormat:@"%@",expresses] forKey:@"expresses"];
    [param setValue:[NSString stringWithFormat:@"%@",self.orderId] forKey:@"orderId"];
    NSLog(@"param = %@",param);
    NSString *paramJson = [param JSONRepresentation];
    NSLog(@"paramJson = %@",paramJson);
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在提交";
    request.hud.square = YES;
    request.hud.yOffset = -(self.view.center.y-self.commitButton.center.y)+NavigationBarHeight;
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
            request.hud.labelText = @"提交失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"success"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"补填成功";
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedWithExpress:andNo:andHud:)])
            {
                NSString *expresses = [NSString stringWithFormat:@"%@",self.selectedExpress.name_en];
                NSString *expressesNo = [NSString stringWithFormat:@"%@",self.expressesNoTextField.text];
                
                [self.navigationController popViewControllerAnimated:YES];
                [self.delegate didFinishedWithExpress:expresses andNo:expressesNo andHud:request.hud];
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

