//
//  CostimatingViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "CostimatingViewController.h"

@interface CostimatingViewController ()

@end

@implementation CostimatingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.costimatingList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"费用估算";
    
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
    
    UILabel *selectTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 12.5f, 70.0f, 23.0f)];
    selectTypeLabel.text = @"选择类型:";
    selectTypeLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    selectTypeLabel.font = [UIFont systemFontOfSize:15.0f];
    selectTypeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    selectTypeLabel.numberOfLines = 1;
    selectTypeLabel.textAlignment = NSTextAlignmentLeft;
    selectTypeLabel.adjustsFontSizeToFitWidth = YES;
    selectTypeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [self.scrollView addSubview:selectTypeLabel];
    
    self.replaceBuyButton = [[UIButton alloc]initWithFrame:CGRectMake(80.0f, 10.0f, 58.0f,28.0f)];
    [self.replaceBuyButton setTitle:@"代购" forState:UIControlStateNormal];
    self.replaceBuyButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.replaceBuyButton setTitleColor:[UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
    [self.replaceBuyButton setTitleColor:[UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f] forState:UIControlStateSelected];
    self.replaceBuyButton.backgroundColor = [UIColor colorWithRed:(255.0f)/255.0f green:(255.0f)/255.0f blue:(255.0f)/255.0f alpha:1];
    self.replaceBuyButton.selected = YES;
    [self.replaceBuyButton.layer setCornerRadius:3.0f];
    self.replaceBuyButton.layer.borderWidth = 0.5f;
    self.replaceBuyButton.layer.borderColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f].CGColor;
    [self.replaceBuyButton addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.replaceBuyButton];
    
    self.selfBuyButton = [[UIButton alloc]initWithFrame:CGRectMake(148.0f, 10.0f, 58.0f,28.0f)];
    [self.selfBuyButton setTitle:@"自助购" forState:UIControlStateNormal];
    self.selfBuyButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.selfBuyButton setTitleColor:[UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
    [self.selfBuyButton setTitleColor:[UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f] forState:UIControlStateSelected];
    self.selfBuyButton.backgroundColor = [UIColor colorWithRed:(255.0f)/255.0f green:(255.0f)/255.0f blue:(255.0f)/255.0f alpha:1];
    [self.selfBuyButton.layer setCornerRadius:3.0f];
    self.selfBuyButton.layer.borderWidth = 0.5f;
    self.selfBuyButton.layer.borderColor = [UIColor colorWithRed:(204.0f)/255.0f green:(204.0f)/255.0f blue:(204.0f)/255.0f alpha:1].CGColor;
    [self.selfBuyButton addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.selfBuyButton];
    
//    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 50.0f, 300.0f, 40.0f)];
//    view1.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
//    view1.layer.cornerRadius = 6.0f;
//    view1.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
//    view1.layer.borderWidth = 0.5f;
//    [self.scrollView addSubview:view1];
//    
//    self.goodsCostTextField = [[UITextField alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 280.0f, 40.0f)];
//    self.goodsCostTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
//    self.goodsCostTextField.placeholder = @"输入购买商品的费用";
//    self.goodsCostTextField.textAlignment = NSTextAlignmentLeft;
//    [self.goodsCostTextField setFont:[UIFont systemFontOfSize:14.0f]];
//    self.goodsCostTextField.returnKeyType = UIReturnKeyDone;//return键的类型
//    self.goodsCostTextField.keyboardType = UIKeyboardTypePhonePad;//键盘类型
//    [view1 addSubview:self.goodsCostTextField];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 50.0f, 300.0f, 40.0f)];
    view2.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view2.layer.cornerRadius = 6.0f;
    view2.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view2.layer.borderWidth = 0.5f;
    view2.userInteractionEnabled = YES;
    [view2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCountryTapped:)]];
    [self.scrollView addSubview:view2];
    
    self.countryLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 270.0f, 40.0f)];
    self.countryLabel.text = [NSString stringWithFormat:@"选择您的目的地国家"];
    self.countryLabel.textColor = [UIColor colorWithRed:(200.0f/255.0f) green:(200.0f/255.0f) blue:(200.0f/255.0f) alpha:1.0f];
    self.countryLabel.textAlignment = NSTextAlignmentLeft;
    self.countryLabel.font = [UIFont systemFontOfSize:14.0f];
    self.countryLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.countryLabel.numberOfLines = 1;
    self.countryLabel.textAlignment = NSTextAlignmentLeft;
    self.countryLabel.adjustsFontSizeToFitWidth = YES;
    self.countryLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view2 addSubview:self.countryLabel];
    
    UIImageView *arrowImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(284.0f,14.8f, 6.0f, 10.5f)];
    [arrowImageView1 setImage:[UIImage imageNamed:@"accessoryView"]];
    [view2 addSubview:arrowImageView1];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 100.0f, 300.0f, 40.0f)];
    view3.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view3.layer.cornerRadius = 6.0f;
    view3.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view3.layer.borderWidth = 0.5f;
    [self.scrollView addSubview:view3];
    
    self.packageWeightTextField = [[UITextField alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 280.0f, 40.0f)];
    self.packageWeightTextField.delegate = self;
    self.packageWeightTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.packageWeightTextField.placeholder = @"输入包裹重量";
    self.packageWeightTextField.textAlignment = NSTextAlignmentLeft;
    [self.packageWeightTextField setFont:[UIFont systemFontOfSize:14.0f]];
    self.packageWeightTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    self.packageWeightTextField.returnKeyType = UIReturnKeyDone;//return键的类型
    self.packageWeightTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//键盘类型
    [view3 addSubview:self.packageWeightTextField];
    
//    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 150.0f, 300.0f, 40.0f)];
//    view4.backgroundColor = [UIColor clearColor];
//    [self.scrollView addSubview:view4];
//    
//    UIView *lengthView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 74.0f, 40.0f)];
//    lengthView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
//    lengthView.layer.cornerRadius = 6.0f;
//    lengthView.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
//    lengthView.layer.borderWidth = 0.5f;
//    [view4 addSubview:lengthView];
//    
//    self.lengthTextField = [[UITextField alloc]initWithFrame:CGRectMake(2.0f, 0.0f, 70.0f, 40.0f)];
//    self.lengthTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
//    self.lengthTextField.placeholder = @"长";
//    self.lengthTextField.textAlignment = NSTextAlignmentCenter;
//    [self.lengthTextField setFont:[UIFont systemFontOfSize:14.0f]];
//    self.lengthTextField.returnKeyType = UIReturnKeyDone;//return键的类型
//    self.lengthTextField.keyboardType = UIKeyboardTypePhonePad;//键盘类型
//    [lengthView addSubview:self.lengthTextField];
//    
//    UIView *widthView = [[UIView alloc]initWithFrame:CGRectMake(94.0f, 0.0f, 74.0f, 40.0f)];
//    widthView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
//    widthView.layer.cornerRadius = 6.0f;
//    widthView.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
//    widthView.layer.borderWidth = 0.5f;
//    [view4 addSubview:widthView];
//    
//    self.widthTextField = [[UITextField alloc]initWithFrame:CGRectMake(2.0f, 0.0f, 70.0f, 40.0f)];
//    self.widthTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
//    self.widthTextField.placeholder = @"宽";
//    self.widthTextField.textAlignment = NSTextAlignmentCenter;
//    [self.widthTextField setFont:[UIFont systemFontOfSize:14.0f]];
//    self.widthTextField.returnKeyType = UIReturnKeyDone;//return键的类型
//    self.widthTextField.keyboardType = UIKeyboardTypePhonePad;//键盘类型
//    [widthView addSubview:self.widthTextField];
//    
//    UIView *heightView = [[UIView alloc]initWithFrame:CGRectMake(188.0f, 0.0f, 74.0f, 40.0f)];
//    heightView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
//    heightView.layer.cornerRadius = 6.0f;
//    heightView.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
//    heightView.layer.borderWidth = 0.5f;
//    [view4 addSubview:heightView];
//    
//    self.heightTextField = [[UITextField alloc]initWithFrame:CGRectMake(2.0f, 0.0f, 70.0f, 40.0f)];
//    self.heightTextField.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
//    self.heightTextField.placeholder = @"高";
//    self.heightTextField.textAlignment = NSTextAlignmentCenter;
//    [self.heightTextField setFont:[UIFont systemFontOfSize:14.0f]];
//    self.heightTextField.returnKeyType = UIReturnKeyDone;//return键的类型
//    self.heightTextField.keyboardType = UIKeyboardTypePhonePad;//键盘类型
//    [heightView addSubview:self.heightTextField];
//    
//    UILabel *xLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(74.0f, 0.0f, 20.0f, 40.0f)];
//    xLabel1.text = @"X";
//    xLabel1.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
//    xLabel1.font = [UIFont systemFontOfSize:15.0f];
//    xLabel1.lineBreakMode = NSLineBreakByTruncatingTail;
//    xLabel1.numberOfLines = 1;
//    xLabel1.textAlignment = NSTextAlignmentCenter;
//    xLabel1.adjustsFontSizeToFitWidth = YES;
//    xLabel1.baselineAdjustment = UIBaselineAdjustmentNone;
//    [view4 addSubview:xLabel1];
//    
//    UILabel *xLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(168.0f, 0.0f, 20.0f, 40.0f)];
//    xLabel2.text = @"X";
//    xLabel2.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
//    xLabel2.font = [UIFont systemFontOfSize:15.0f];
//    xLabel2.lineBreakMode = NSLineBreakByTruncatingTail;
//    xLabel2.numberOfLines = 1;
//    xLabel2.textAlignment = NSTextAlignmentCenter;
//    xLabel2.adjustsFontSizeToFitWidth = YES;
//    xLabel2.baselineAdjustment = UIBaselineAdjustmentNone;
//    [view4 addSubview:xLabel2];
//    
//    UILabel *cmLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(262.0f, 0.0f, 38.0f, 40.0f)];
//    cmLabel2.text = @"CM";
//    cmLabel2.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
//    cmLabel2.font = [UIFont systemFontOfSize:15.0f];
//    cmLabel2.lineBreakMode = NSLineBreakByTruncatingTail;
//    cmLabel2.numberOfLines = 1;
//    cmLabel2.textAlignment = NSTextAlignmentCenter;
//    cmLabel2.adjustsFontSizeToFitWidth = YES;
//    cmLabel2.baselineAdjustment = UIBaselineAdjustmentNone;
//    [view4 addSubview:cmLabel2];
    
    self.commitButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 160.0f, 300.0f, 40.0f)];
    [self.commitButton setTitle:@"开始计算" forState:UIControlStateNormal];
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

- (void)selectType:(id)sender
{
    self.replaceBuyButton.selected = NO;
    self.replaceBuyButton.layer.borderColor = [UIColor colorWithRed:(204.0f)/255.0f green:(204.0f)/255.0f blue:(204.0f)/255.0f alpha:1].CGColor;
    self.selfBuyButton.selected = NO;
    self.selfBuyButton.layer.borderColor = [UIColor colorWithRed:(204.0f)/255.0f green:(204.0f)/255.0f blue:(204.0f)/255.0f alpha:1].CGColor;
    
    UIButton *btn = (UIButton*)sender;
    btn.selected = YES;
    btn.layer.borderColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f].CGColor;
}

- (void)commit:(id)sender
{
    [self.packageWeightTextField resignFirstResponder];
    
    float yoffset = -(self.view.center.y-self.commitButton.center.y)+NavigationBarHeight;
    
    if(self.countryLabel.tag == 0)
    {
        [MBProgressHUD showError:@"请选择国家" toYOffset:yoffset toView:self.view];
        return;
    }
    
    if([self.packageWeightTextField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入包裹重量" toYOffset:yoffset toView:self.view];
        return;
    }
    
    [self callCostimatingWebService];
}

- (void)selectCountryTapped:(id)sender
{
    CountryViewController *countryViewController = [[CountryViewController alloc]initWithNibName:@"CountryViewController" bundle:nil];
    countryViewController.delegate = self;
    [self.navigationController pushViewController:countryViewController animated:YES];
}

- (void)didFinishedReturnCountry:(Country *)selectedCountry
{
    self.countryLabel.text = [NSString stringWithFormat:@"%@",selectedCountry.name];
    self.countryLabel.tag = selectedCountry.country_id;
    self.countryLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)callCostimatingWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/app/cost_estimate"];
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
    [param setValue:[NSString stringWithFormat:@"%d",(int)self.countryLabel.tag] forKey:@"areaId"];
    [param setValue:[NSString stringWithFormat:@"%.2f",[self.packageWeightTextField.text doubleValue]] forKey:@"weight"];
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
            NSArray *result = [data objectForKey:@"result"];
            if (![self resolveCostimatingListJson:result])
            {
                request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
                request.hud.mode = MBProgressHUDModeCustomView;
                request.hud.removeFromSuperViewOnHide = YES;
                request.hud.labelText = @"解析失败";
            }
            else
            {
                CostimatingListViewController *costimatingListViewController = [[CostimatingListViewController alloc] initWithNibName:@"CostimatingListViewController" bundle:nil];
                costimatingListViewController.costimatingList = [self.costimatingList mutableCopy];
                [self.navigationController pushViewController:costimatingListViewController animated:YES];
            }
        }
    }
}

- (BOOL)resolveCostimatingListJson:(NSArray *)costimatingList
{
    int i = 1;
    for(NSDictionary *costimatingDictionary in costimatingList)
    {
        
        Costimating *costimating = [[Costimating alloc]init];
        costimating.cid = i;
        costimating.carrierLogo = [costimatingDictionary objectForKey:@"carrierLogo"];
        costimating.customsFee = [[costimatingDictionary objectForKey:@"customsFee"]doubleValue];
        costimating.deliveryName = [costimatingDictionary objectForKey:@"deliveryName"];
        costimating.deliveryTime = [costimatingDictionary objectForKey:@"deliveryTime"];
        costimating.freight = [[costimatingDictionary objectForKey:@"freight"]doubleValue];
        costimating.servefee = [[costimatingDictionary objectForKey:@"servefee"]doubleValue];
        costimating.total = [[costimatingDictionary objectForKey:@"total"]doubleValue];
    
        [self.costimatingList addObject:costimating];
        i++;
    }
    return YES;
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
