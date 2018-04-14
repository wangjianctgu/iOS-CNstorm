//
//  ScoreRecordUsedViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-27.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "ScoreRecordUsedViewController.h"

@interface ScoreRecordUsedViewController ()

@end

@implementation ScoreRecordUsedViewController

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
    self.navigationItem.title = @"使用积分";
    
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
    self.scrollView.backgroundColor = [UIColor colorWithRed:(253.0f/255.0f) green:(253.0f/255.0f) blue:(253.0f/255.0f) alpha:1.0f];
    [self.scrollView setScrollEnabled:YES];
    [self.view addSubview:self.scrollView];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 150.0f)];
    view1.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:view1];
    
    self.scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 15.0f, 135.0f, 30.0f)];
    self.scoreLabel.text = [NSString stringWithFormat:@"会员积分:%d",0];
    self.scoreLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    self.scoreLabel.font = [UIFont systemFontOfSize:15.0f];
    self.scoreLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.scoreLabel.numberOfLines = 1;
    self.scoreLabel.textAlignment = NSTextAlignmentLeft;
    self.scoreLabel.adjustsFontSizeToFitWidth = YES;
    self.scoreLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:self.scoreLabel];
    
    UILabel *userTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(165.0f, 15.0f, 65.0f, 30.0f)];
    userTypeLabel.text = @"会员等级:";
    userTypeLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    userTypeLabel.font = [UIFont systemFontOfSize:14.0f];
    userTypeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    userTypeLabel.numberOfLines = 1;
    userTypeLabel.textAlignment = NSTextAlignmentLeft;
    userTypeLabel.adjustsFontSizeToFitWidth = YES;
    userTypeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:userTypeLabel];
    
    UILabel *userTypeInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(230.0f, 15.0f, 60.0f, 30.0f)];
    userTypeInfoLabel.text = @"V0会员";
    userTypeInfoLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    userTypeInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    userTypeInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    userTypeInfoLabel.numberOfLines = 1;
    userTypeInfoLabel.textAlignment = NSTextAlignmentLeft;
    userTypeInfoLabel.adjustsFontSizeToFitWidth = YES;
    userTypeInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:userTypeInfoLabel];

    
    self.usedscoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 45.0f, 135.0f, 30.0f)];
    self.usedscoreLabel.text = [NSString stringWithFormat:@"可用积分:%d",0];
    self.usedscoreLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f];
    self.usedscoreLabel.font = [UIFont systemFontOfSize:15.0f];
    self.usedscoreLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.usedscoreLabel.numberOfLines = 1;
    self.usedscoreLabel.textAlignment = NSTextAlignmentLeft;
    self.usedscoreLabel.adjustsFontSizeToFitWidth = YES;
    self.usedscoreLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:self.usedscoreLabel];
    
    UILabel *exchangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(165.0f, 45.0f, 135.0f, 30.0f)];
    exchangeLabel.text = @"100积分 ＝ 1元";
    exchangeLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    exchangeLabel.font = [UIFont systemFontOfSize:14.0f];
    exchangeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    exchangeLabel.numberOfLines = 1;
    exchangeLabel.textAlignment = NSTextAlignmentLeft;
    exchangeLabel.adjustsFontSizeToFitWidth = YES;
    exchangeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:exchangeLabel];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(20.0f, 90.0f, 135.0f, 40.0f)];
    view2.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view2.layer.cornerRadius = 6.0f;
    view2.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view2.layer.borderWidth = 0.5f;
    [view1 addSubview:view2];
    
    self.scoreTextField = [[UITextField alloc]initWithFrame:CGRectMake(5.0f, 5.0f, 125.0f, 30.0f)];
    self.scoreTextField.delegate = self;
    self.scoreTextField.placeholder = @"请输入积分";
    self.scoreTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.scoreTextField.backgroundColor = [UIColor clearColor];
    self.scoreTextField.textAlignment = NSTextAlignmentLeft;
    [self.scoreTextField setFont:[UIFont systemFontOfSize:14.0f]];
    self.scoreTextField.returnKeyType = UIReturnKeyDone;//return键的类型
    self.scoreTextField.keyboardType = UIKeyboardTypeNumberPad;//键盘类型
    self.scoreTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    [view2 addSubview:self.scoreTextField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(textFieldTextDidChange:)
            name:UITextFieldTextDidChangeNotification
          object:self.scoreTextField];

    UILabel *deductionLabel = [[UILabel alloc]initWithFrame:CGRectMake(165.0f, 90.0f, 60.0f, 40.0f)];
    deductionLabel.text = @"可抵扣:";
    deductionLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    deductionLabel.font = [UIFont systemFontOfSize:15.0f];
    deductionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    deductionLabel.numberOfLines = 1;
    deductionLabel.textAlignment = NSTextAlignmentLeft;
    deductionLabel.adjustsFontSizeToFitWidth = YES;
    deductionLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:deductionLabel];
    
    self.deduRMBLabel = [[UILabel alloc]initWithFrame:CGRectMake(225.0f, 90.0f, 85.0f, 40.0f)];
    self.deduRMBLabel.text = [NSString stringWithFormat:@"¥%.2f",self.deduRMB];
    self.deduRMBLabel.textColor = [UIColor colorWithRed:(253.0f/255.0f) green:(78.0f/255.0f) blue:(46.0f/255.0f) alpha:1.0f];
    self.deduRMBLabel.font = [UIFont systemFontOfSize:15.0f];
    self.deduRMBLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.deduRMBLabel.numberOfLines = 1;
    self.deduRMBLabel.textAlignment = NSTextAlignmentLeft;
    self.deduRMBLabel.adjustsFontSizeToFitWidth = YES;
    self.deduRMBLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:self.deduRMBLabel];
    
    self.commitButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 150.0f, 300.0f,40.0f)];
    [self.commitButton setTitle:@"确定" forState:UIControlStateNormal];
    self.commitButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commitButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [self.commitButton.layer setCornerRadius:3.0f];
    self.commitButton.layer.borderWidth = 0.5f;
    self.commitButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [self.commitButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.commitButton];
    
    [self callScoresWebService];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,MainScreenHeight-NavigationBarHeight+1.0f);
}

- (void)commit:(id)sender
{
    [self.scoreTextField resignFirstResponder];
    float yoffset = -(self.view.center.y-self.commitButton.center.y)+NavigationBarHeight;

    if([self.scoreTextField.text isEqualToString:@""]|| [self.scoreTextField.text intValue]== 0)
    {
        [MBProgressHUD showError:@"请输入积分" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if(self.usedScores < [self.scoreTextField.text intValue])
    {
        [MBProgressHUD showError:@"可用积分不足" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didFinishedReturnScoresValue:andScores:)])
    {
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate didFinishedReturnScoresValue:self.deduRMB andScores:[self.scoreTextField.text intValue]];
    }
}

//UITextFieldDelegate
- (void)textFieldTextDidChange:(id)sender
{
    self.deduRMB = [self.scoreTextField.text intValue]/100.0f;
    
    self.deduRMBLabel.text = [NSString stringWithFormat:@"¥%.2f",self.deduRMB];

}

//UITextField 将开始编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //返回一个BOOL值，指定是否循序文本字段开始编辑
    return YES;
}

//UITextField 开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //开始编辑时触发，文本字段将成为first responder
    [textField becomeFirstResponder];
}

//UITextField 将结束编辑
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    //返回BOOL值，指定是否允许文本字段结束编辑，当编辑结束，文本字段会让出first responder
    //要想在用户结束编辑时阻止文本字段消失，可以返回NO
    //这对一些文本字段必须始终保持活跃状态的程序很有用，比如即时消息
    return YES;
}

//UITextField 将结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //[textField resignFirstResponder];
}


- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //当用户使用自动更正功能，把输入的文字修改为推荐的文字时，就会调用这个方法。
    //这对于想要加入撤销选项的应用程序特别有用
    //可以跟踪字段内所做的最后一次修改，也可以对所有编辑做日志记录,用作审计用途。
    //要防止文字被改变可以返回NO
    //这个方法的参数中有一个NSRange对象，指明了被改变文字的位置，建议修改的文本也在其中
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    //返回一个BOOL值指明是否允许根据用户请求清除内容
    //可以设置在特定条件下才允许清除内容
    return YES;
}

//UITextField Return按键
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //如果允许要调用resignFirstResponder 方法，这回导致结束编辑，而键盘会被收起
    [textField resignFirstResponder];//查一下resign这个单词的意思就明白这个方法了
    return YES;
}

- (void)callScoresWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/account/scores"];
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
    [request startAsynchronous];//异步传输
    
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
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
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
            NSDictionary *result = [data objectForKey:@"result"];
            int scores = [[result objectForKey:@"scores"]intValue];
            self.usedScores = (int)scores*0.89;
            self.scoreLabel.text = [NSString stringWithFormat:@"会员积分:%d",scores];
            self.usedscoreLabel.text = [NSString stringWithFormat:@"可用积分:%d",self.usedScores];
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
        request.hud.detailsLabelText = @"请检查网络";
    }
}

@end
