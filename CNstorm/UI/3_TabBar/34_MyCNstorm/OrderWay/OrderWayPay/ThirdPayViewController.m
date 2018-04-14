//
//  ThirdPayViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "ThirdPayViewController.h"

#import <QuartzCore/QuartzCore.h>

// Set the environment:
// - For live charges, use PayPalEnvironmentProduction (default).
// - To use the PayPal sandbox, use PayPalEnvironmentSandbox.
// - For testing, use PayPalEnvironmentNoNetwork.
#define kPayPalEnvironment PayPalEnvironmentProduction

static ThirdPayViewController *thirdPayViewInstance = nil;

@interface ThirdPayViewController ()

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

@end

@implementation ThirdPayViewController

- (id)init
{
    if (self = [super init])
    {
        thirdPayViewInstance = self;//注意这里
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        thirdPayViewInstance = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择支付平台";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self initView];
    [self setUpPayPalConfig];
}
    
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    // Preconnect to PayPal early 更早的预连接到PayPal
    [PayPalMobile preconnectWithEnvironment:self.environment];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//- (void)dealloc
//{
//    thirdPayViewInstance = nil;      //释放全局变量,这个不能要啊
//}

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

//初始化
- (void)initView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.view addSubview:self.scrollView];
    
    UIView *segmentedControlView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,MainScreenWidth,TransparentBarHeight)];
    segmentedControlView.backgroundColor=[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:segmentedControlView];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"PayPal",@"支付宝",@"国际信用卡",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(10.0f, 10.0f, 300.0f, 30.0f);
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    segmentedControl.tintColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1];
    [segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    [segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];//添加委托方法
    segmentedControl.layer.cornerRadius = 6.0f;
    segmentedControl.layer.borderWidth = 0.5f;
    segmentedControl.layer.borderColor = [UIColor colorWithRed:(195.0f)/255.0f green:(60.0f)/255.0f blue:(33.0f)/255.0f alpha:1].CGColor;
    [segmentedControlView addSubview:segmentedControl];
    
    [self initCreditView];
    [self initAlipayView];
    [self callSearchRateWebService];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth,MainScreenHeight-NavigationBarHeight+1);
}

- (void)segmentAction:(UISegmentedControl *)segmentedControl
{
    NSInteger index = segmentedControl.selectedSegmentIndex;
    switch (index)
    {
        case 0:
            [self.scrollView bringSubviewToFront:self.paypalView];
            break;
            
        case 1:
            [self.scrollView bringSubviewToFront:self.alipayView];
            break;
            
        case 2:
            [self.scrollView bringSubviewToFront:self.creditView];
            break;
            
        default:
            [self.scrollView bringSubviewToFront:self.paypalView];
            break;
    }
}

- (void)initPaypalView
{
    double exchangeLoss = self.totalCost*self.payRate*0.039;
    double dTotalCost = self.totalCost*self.payRate;
    self.palTotalCost = self.totalCost*self.payRate*1.039;
    
    self.paypalView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,TransparentBarHeight, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    self.paypalView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:self.paypalView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(10.0f, 5.0f,  300.0f, 275.0f)];
    [imageView setImage:[UIImage imageNamed:@"payBg"]];
    imageView.userInteractionEnabled = YES;
    [self.paypalView addSubview:imageView];
    
    UILabel *payMentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 20.0f, 280.0f, 30.0f)];
    payMentLabel.text = @"您当前选择的支付方式是PayPal";
    payMentLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    payMentLabel.font = [UIFont systemFontOfSize:15.0f];
    payMentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    payMentLabel.numberOfLines = 1;
    payMentLabel.textAlignment = NSTextAlignmentLeft;
    payMentLabel.adjustsFontSizeToFitWidth = YES;
    payMentLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [imageView addSubview:payMentLabel];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 50.0f, 280.0f, 1.0f)];
    lineView1.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [imageView addSubview:lineView1];
    
    UIImageView *paypalIcon = [[UIImageView alloc] initWithFrame: CGRectMake(10.0f, 58.0f,  85.0f, 50.0f)];
    [paypalIcon setImage:[UIImage imageNamed:@"paypal"]];
    paypalIcon.userInteractionEnabled = YES;
    [imageView addSubview:paypalIcon];
    
    UILabel *payMentLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(98.0f, 55.0f, 200.0f, 28.0f)];
    payMentLabel1.text = @"外币汇兑损失约:3%～3.9%";
    payMentLabel1.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    payMentLabel1.font = [UIFont systemFontOfSize:14.0f];
    payMentLabel1.lineBreakMode = NSLineBreakByTruncatingTail;
    payMentLabel1.numberOfLines = 1;
    payMentLabel1.textAlignment = NSTextAlignmentLeft;
    payMentLabel1.adjustsFontSizeToFitWidth = YES;
    payMentLabel1.baselineAdjustment = UIBaselineAdjustmentNone;
    [imageView addSubview:payMentLabel1];
    
    UILabel *payRateLabel = [[UILabel alloc]initWithFrame:CGRectMake(98.0f, 83.0f, 200.0f, 28.0f)];
    payRateLabel.text = [NSString stringWithFormat:@"当前汇率:%.4f 美元/人民币",self.payRate];
    payRateLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    payRateLabel.font = [UIFont systemFontOfSize:14.0f];
    payRateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    payRateLabel.numberOfLines = 1;
    payRateLabel.textAlignment = NSTextAlignmentLeft;
    payRateLabel.adjustsFontSizeToFitWidth = YES;
    payRateLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [imageView addSubview:payRateLabel];
    
    UILabel *payInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 120.0f, 140.0f, 30.0f)];
    payInfoLabel.text = [NSString stringWithFormat:@"您实际应支付金额是"];
    payInfoLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    payInfoLabel.font = [UIFont systemFontOfSize:15.0f];
    payInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    payInfoLabel.numberOfLines = 1;
    payInfoLabel.textAlignment = NSTextAlignmentLeft;
    payInfoLabel.adjustsFontSizeToFitWidth = YES;
    payInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [imageView addSubview:payInfoLabel];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 150.0f, 280.0f, 1.0f)];
    lineView2.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [imageView addSubview:lineView2];
    
    if(self.payType == 0 || self.payType == 1)
    {
        UILabel *payInfoLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 155.0f, 280.0f, 28.0f)];
        if (self.payType == 0)
        {
            payInfoLabel1.text = [NSString stringWithFormat:@"订单编号:%@",self.idsStr];
        }
        else
        {
            payInfoLabel1.text = [NSString stringWithFormat:@"运单编号:%@",self.idsStr];
        }
        payInfoLabel1.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        payInfoLabel1.font = [UIFont systemFontOfSize:14.0f];
        payInfoLabel1.lineBreakMode = NSLineBreakByTruncatingTail;
        payInfoLabel1.numberOfLines = 1;
        payInfoLabel1.textAlignment = NSTextAlignmentLeft;
        payInfoLabel1.adjustsFontSizeToFitWidth = YES;
        payInfoLabel1.baselineAdjustment = UIBaselineAdjustmentNone;
        [imageView addSubview:payInfoLabel1];
        
        UILabel *payInfoLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 183.0f, 280.0f, 28.0f)];
        if (self.payType == 0)
        {
            payInfoLabel2.text = [NSString stringWithFormat:@"订单总计:￥%.2f/＄%.4f ",self.totalCost,dTotalCost];
        }
        else
        {
            payInfoLabel2.text = [NSString stringWithFormat:@"运单总计:￥%.2f/＄%.4f ",self.totalCost,dTotalCost];
        }
        payInfoLabel2.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        payInfoLabel2.font = [UIFont systemFontOfSize:14.0f];
        payInfoLabel2.lineBreakMode = NSLineBreakByTruncatingTail;
        payInfoLabel2.numberOfLines = 1;
        payInfoLabel2.textAlignment = NSTextAlignmentLeft;
        payInfoLabel2.adjustsFontSizeToFitWidth = YES;
        payInfoLabel2.baselineAdjustment = UIBaselineAdjustmentNone;
        [imageView addSubview:payInfoLabel2];
        
        UILabel *payInfoLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 211.0f, 280.0f, 28.0f)];
        payInfoLabel3.text = [NSString stringWithFormat:@"外币汇兑损失:＄%.4f",exchangeLoss];
        payInfoLabel3.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        payInfoLabel3.font = [UIFont systemFontOfSize:14.0f];
        payInfoLabel3.lineBreakMode = NSLineBreakByTruncatingTail;
        payInfoLabel3.numberOfLines = 1;
        payInfoLabel3.textAlignment = NSTextAlignmentLeft;
        payInfoLabel3.adjustsFontSizeToFitWidth = YES;
        payInfoLabel3.baselineAdjustment = UIBaselineAdjustmentNone;
        [imageView addSubview:payInfoLabel3];
        
        UILabel *payInfoLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(150.0f, 120.0f, 140.0f, 30.0f)];
        payInfoLabel4.text = [NSString stringWithFormat:@"＄%.2f",self.palTotalCost];;
        payInfoLabel4.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f];
        payInfoLabel4.font = [UIFont systemFontOfSize:15.0f];
        payInfoLabel4.lineBreakMode = NSLineBreakByTruncatingTail;
        payInfoLabel4.numberOfLines = 1;
        payInfoLabel4.textAlignment = NSTextAlignmentLeft;
        payInfoLabel4.adjustsFontSizeToFitWidth = YES;
        payInfoLabel4.baselineAdjustment = UIBaselineAdjustmentNone;
        [imageView addSubview:payInfoLabel4];
    }
    else
    {
        UILabel *payInfoLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 155.0f, 280.0f, 28.0f)];
        payInfoLabel2.text = [NSString stringWithFormat:@"充值金额:￥%.2f/＄%.4f ",self.totalCost,dTotalCost];
        payInfoLabel2.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        payInfoLabel2.font = [UIFont systemFontOfSize:14.0f];
        payInfoLabel2.lineBreakMode = NSLineBreakByTruncatingTail;
        payInfoLabel2.numberOfLines = 1;
        payInfoLabel2.textAlignment = NSTextAlignmentLeft;
        payInfoLabel2.adjustsFontSizeToFitWidth = YES;
        payInfoLabel2.baselineAdjustment = UIBaselineAdjustmentNone;
        [imageView addSubview:payInfoLabel2];
        
        UILabel *payInfoLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 183.0f, 280.0f, 28.0f)];
        payInfoLabel3.text = [NSString stringWithFormat:@"外币汇兑损失:＄%.4f",exchangeLoss];
        payInfoLabel3.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        payInfoLabel3.font = [UIFont systemFontOfSize:14.0f];
        payInfoLabel3.lineBreakMode = NSLineBreakByTruncatingTail;
        payInfoLabel3.numberOfLines = 1;
        payInfoLabel3.textAlignment = NSTextAlignmentLeft;
        payInfoLabel3.adjustsFontSizeToFitWidth = YES;
        payInfoLabel3.baselineAdjustment = UIBaselineAdjustmentNone;
        [imageView addSubview:payInfoLabel3];
        
        UILabel *payInfoLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(150.0f, 120.0f, 140.0f, 30.0f)];
        payInfoLabel4.text = [NSString stringWithFormat:@"＄%.2f",self.palTotalCost];;
        payInfoLabel4.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f];
        payInfoLabel4.font = [UIFont systemFontOfSize:15.0f];
        payInfoLabel4.lineBreakMode = NSLineBreakByTruncatingTail;
        payInfoLabel4.numberOfLines = 1;
        payInfoLabel4.textAlignment = NSTextAlignmentLeft;
        payInfoLabel4.adjustsFontSizeToFitWidth = YES;
        payInfoLabel4.baselineAdjustment = UIBaselineAdjustmentNone;
        [imageView addSubview:payInfoLabel4];
    }
    
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 300.0f, 300.0f,40.0f)];
    [commitButton setTitle:@"PayPal支付" forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [commitButton.layer setCornerRadius:3.0f];
    commitButton.layer.borderWidth = 0.5f;
    commitButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [commitButton addTarget:self action:@selector(payPalPay:) forControlEvents:UIControlEventTouchUpInside];
    [self.paypalView addSubview:commitButton];
}

- (void)initAlipayView
{
    _result = @selector(paymentResult:);
    
    double exchangeLoss = self.totalCost*0.02;
    self.aliTotalCost = self.totalCost*1.02;
    
    if (self.payType == 0)
    {
        self.aliName = [NSString stringWithFormat:@"CNstorm 订单编号:%@",self.idsStr];
    }
    else if (self.payType == 1)
    {
        self.aliName = [NSString stringWithFormat:@"CNstorm 运单编号:%@",self.idsStr];
    }
    else
    {
        self.aliName = [NSString stringWithFormat:@"CNstorm 账户充值"];
    }

    self.aliInfo = @"CNstorm信恩世通 (www.cnstorm.com) 时尚便捷的留学生及华人代购、自助购、国际转运服务平台，于2011年11月8日正式启动运营，旨在为海外留学生及华人提供可多币种支付的中国商品购买及送货上门服务。CNstorm坚持贯彻“亲切，时尚，优惠，便捷”的服务理念，以顾客为主，不断为顾客创造价值。";
    
    self.aliPrice = [NSString stringWithFormat:@"%.2f",self.aliTotalCost];
    
    self.alipayView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,TransparentBarHeight, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    self.alipayView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:self.alipayView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(10.0f ,5.0f,  300.0f, 275.0f)];
    [imageView setImage:[UIImage imageNamed:@"payBg"]];
    imageView.userInteractionEnabled = YES;
    [self.alipayView addSubview: imageView];
    
    UILabel *payMentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 20.0f, 280.0f, 30.0f)];
    payMentLabel.text = @"您当前选择的支付方式是支付宝";
    payMentLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    payMentLabel.font = [UIFont systemFontOfSize:15.0f];
    payMentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    payMentLabel.numberOfLines = 1;
    payMentLabel.textAlignment = NSTextAlignmentLeft;
    payMentLabel.adjustsFontSizeToFitWidth = YES;
    payMentLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [imageView addSubview:payMentLabel];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 50.0f, 280.0f, 1.0f)];
    lineView1.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [imageView addSubview:lineView1];
    
    UIImageView *alipayIcon = [[UIImageView alloc] initWithFrame: CGRectMake(10.0f, 58.0f,  85.0f, 50.0f)];
    [alipayIcon setImage:[UIImage imageNamed:@"alipay"]];
    alipayIcon.userInteractionEnabled = YES;
    [imageView addSubview:alipayIcon];
    
    UILabel *payMentLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(98.0f, 55.0f, 200.0f, 28.0f)];
    payMentLabel1.text = @"网关转账损失约:2%";
    payMentLabel1.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    payMentLabel1.font = [UIFont systemFontOfSize:14.0f];
    payMentLabel1.lineBreakMode = NSLineBreakByTruncatingTail;
    payMentLabel1.numberOfLines = 1;
    payMentLabel1.textAlignment = NSTextAlignmentLeft;
    payMentLabel1.adjustsFontSizeToFitWidth = YES;
    payMentLabel1.baselineAdjustment = UIBaselineAdjustmentNone;
    [imageView addSubview:payMentLabel1];
    
    UILabel *payInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 120.0f, 140.0f, 30.0f)];
    payInfoLabel.text = [NSString stringWithFormat:@"您实际应支付金额是"];
    payInfoLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    payInfoLabel.font = [UIFont systemFontOfSize:15.0f];
    payInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    payInfoLabel.numberOfLines = 1;
    payInfoLabel.textAlignment = NSTextAlignmentLeft;
    payInfoLabel.adjustsFontSizeToFitWidth = YES;
    payInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [imageView addSubview:payInfoLabel];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 150.0f, 280.0f, 1.0f)];
    lineView2.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [imageView addSubview:lineView2];
    
    if(self.payType == 0 || self.payType == 1)
    {
        UILabel *payInfoLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 155.0f, 280.0f, 28.0f)];
        if (self.payType == 0)
        {
            payInfoLabel1.text = [NSString stringWithFormat:@"订单编号:%@",self.idsStr];
        }
        else
        {
            payInfoLabel1.text = [NSString stringWithFormat:@"运单编号:%@",self.idsStr];
        }
        payInfoLabel1.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        payInfoLabel1.font = [UIFont systemFontOfSize:14.0f];
        payInfoLabel1.lineBreakMode = NSLineBreakByTruncatingTail;
        payInfoLabel1.numberOfLines = 1;
        payInfoLabel1.textAlignment = NSTextAlignmentLeft;
        payInfoLabel1.adjustsFontSizeToFitWidth = YES;
        payInfoLabel1.baselineAdjustment = UIBaselineAdjustmentNone;
        [imageView addSubview:payInfoLabel1];
        
        UILabel *payInfoLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 183.0f, 280.0f, 28.0f)];
        if (self.payType == 0)
        {
            payInfoLabel2.text = [NSString stringWithFormat:@"订单总计:￥%.2f",self.totalCost];
        }
        else
        {
            payInfoLabel2.text = [NSString stringWithFormat:@"运单总计:￥%.2f",self.totalCost];
        }
        
        payInfoLabel2.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        payInfoLabel2.font = [UIFont systemFontOfSize:14.0f];
        payInfoLabel2.lineBreakMode = NSLineBreakByTruncatingTail;
        payInfoLabel2.numberOfLines = 1;
        payInfoLabel2.textAlignment = NSTextAlignmentLeft;
        payInfoLabel2.adjustsFontSizeToFitWidth = YES;
        payInfoLabel2.baselineAdjustment = UIBaselineAdjustmentNone;
        [imageView addSubview:payInfoLabel2];
        
        UILabel *payInfoLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 211.0f, 280.0f, 28.0f)];
        payInfoLabel3.text = [NSString stringWithFormat:@"网关转账损失:￥%.4f",exchangeLoss];
        payInfoLabel3.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        payInfoLabel3.font = [UIFont systemFontOfSize:14.0f];
        payInfoLabel3.lineBreakMode = NSLineBreakByTruncatingTail;
        payInfoLabel3.numberOfLines = 1;
        payInfoLabel3.textAlignment = NSTextAlignmentLeft;
        payInfoLabel3.adjustsFontSizeToFitWidth = YES;
        payInfoLabel3.baselineAdjustment = UIBaselineAdjustmentNone;
        [imageView addSubview:payInfoLabel3];
        
        UILabel *payInfoLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(150.0f, 120.0f, 140.0f, 30.0f)];
        payInfoLabel4.text = [NSString stringWithFormat:@"￥%.2f",self.aliTotalCost];
        payInfoLabel4.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f];
        payInfoLabel4.font = [UIFont systemFontOfSize:15.0f];
        payInfoLabel4.lineBreakMode = NSLineBreakByTruncatingTail;
        payInfoLabel4.numberOfLines = 1;
        payInfoLabel4.textAlignment = NSTextAlignmentLeft;
        payInfoLabel4.adjustsFontSizeToFitWidth = YES;
        payInfoLabel4.baselineAdjustment = UIBaselineAdjustmentNone;
        [imageView addSubview:payInfoLabel4];
    }
    else
    {
        UILabel *payInfoLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 155.0f, 280.0f, 28.0f)];
        payInfoLabel2.text = [NSString stringWithFormat:@"充值金额:￥%.2f",self.totalCost];
        payInfoLabel2.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        payInfoLabel2.font = [UIFont systemFontOfSize:14.0f];
        payInfoLabel2.lineBreakMode = NSLineBreakByTruncatingTail;
        payInfoLabel2.numberOfLines = 1;
        payInfoLabel2.textAlignment = NSTextAlignmentLeft;
        payInfoLabel2.adjustsFontSizeToFitWidth = YES;
        payInfoLabel2.baselineAdjustment = UIBaselineAdjustmentNone;
        [imageView addSubview:payInfoLabel2];
        
        UILabel *payInfoLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 183.0f, 280.0f, 28.0f)];
        payInfoLabel3.text = [NSString stringWithFormat:@"网关转账损失:￥%.4f",exchangeLoss];
        payInfoLabel3.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        payInfoLabel3.font = [UIFont systemFontOfSize:14.0f];
        payInfoLabel3.lineBreakMode = NSLineBreakByTruncatingTail;
        payInfoLabel3.numberOfLines = 1;
        payInfoLabel3.textAlignment = NSTextAlignmentLeft;
        payInfoLabel3.adjustsFontSizeToFitWidth = YES;
        payInfoLabel3.baselineAdjustment = UIBaselineAdjustmentNone;
        [imageView addSubview:payInfoLabel3];
        
        UILabel *payInfoLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(150.0f, 120.0f, 140.0f, 30.0f)];
        payInfoLabel4.text = [NSString stringWithFormat:@"￥%.2f",self.aliTotalCost];;
        payInfoLabel4.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f];
        payInfoLabel4.font = [UIFont systemFontOfSize:15.0f];
        payInfoLabel4.lineBreakMode = NSLineBreakByTruncatingTail;
        payInfoLabel4.numberOfLines = 1;
        payInfoLabel4.textAlignment = NSTextAlignmentLeft;
        payInfoLabel4.adjustsFontSizeToFitWidth = YES;
        payInfoLabel4.baselineAdjustment = UIBaselineAdjustmentNone;
        [imageView addSubview:payInfoLabel4];
    }
    
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 300.0f, 300.0f,40.0f)];
    [commitButton setTitle:@"支付宝支付" forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [commitButton.layer setCornerRadius:3.0f];
    commitButton.layer.borderWidth = 0.5f;
    commitButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [commitButton addTarget:self action:@selector(aliPay:) forControlEvents:UIControlEventTouchUpInside];
    [self.alipayView addSubview:commitButton];
}

- (void)initCreditView
{
    self.creditView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,TransparentBarHeight, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    self.creditView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:self.creditView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(10.0f ,5.0f,  300.0f, 275.0f)];
    [imageView setImage:[UIImage imageNamed:@"payBg"]];
    imageView.userInteractionEnabled = YES;
    [self.creditView addSubview: imageView];
    
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 300.0f, 300.0f,40.0f)];
    commitButton.enabled = NO;
    [commitButton setTitle:@"支付宝国际信用卡支付（暂未开通）" forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [commitButton.layer setCornerRadius:3.0f];
    commitButton.layer.borderWidth = 0.5f;
    commitButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [commitButton addTarget:self action:@selector(aliCreditPay:) forControlEvents:UIControlEventTouchUpInside];
    [self.creditView addSubview:commitButton];
}

/***********************************paypal***************************************/
- (void)setUpPayPalConfig
{
    //PayPal配置 Set up payPalConfig
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;//是否接受信用卡
    _payPalConfig.languageOrLocale = @"en";//本地语言
    _payPalConfig.merchantName = @"CNstorm 信恩世通";//商户名称
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];//商户的隐私政策的URL
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];//商业用户协议的URL
    
    // Setting the languageOrLocale property is optional.
    //
    // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
    // its user interface according to the device's current language setting.
    //
    // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
    // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
    // to use that language/locale.
    //
    // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
    
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];//首选语言
    
    // Do any additional setup after loading the view, typically from a nib.
    
    // use default environment, should be Production in real life
    self.environment = kPayPalEnvironment;//设置PayPal的环境
    self.acceptCreditCards = YES;//设置是否接受信用卡支付
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
}

- (void)payPalPay:(id)sender
{
    self.type = 1;//PayPal支付
    // Remove our last completed payment, just for demo purposes.
    self.resultText = nil;
    
    // Note: For purposes of illustration, this example shows a payment that includes
    //       both payment details (subtotal, shipping, tax) and multiple items.
    //       You would only specify these if appropriate to your situation.
    //       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
    //       and simply set payment.amount to your total charge.
    
    // Optional: include multiple items
    
    PayPalItem *item1 = [PayPalItem itemWithName:
                                   [NSString stringWithFormat:@"CNstorm"]
                                    withQuantity:1
                                       withPrice:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f",self.palTotalCost]]
                                    withCurrency:@"USD"
                                         withSku:@"CNstorm 账户充值/订单、运单付款"];
    
//    PayPalItem *item1 = [PayPalItem itemWithName:
//                         [NSString stringWithFormat:@"CNstorm"]
//                                    withQuantity:1
//                                       withPrice:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f",0.01f]]
//                                    withCurrency:@"USD"
//                                         withSku:@"CNstorm 账户充值/订单、运单付款"];
    
    NSArray *items = @[item1];
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    
    // Optional: include payment details
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"0.00"];//银行网关损失
    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"0.00"];//payPal支付抽拥
    
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal withShipping:shipping withTax:tax];
    
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"USD";
    if (self.payType == 0)
    {
        payment.shortDescription = [NSString stringWithFormat:@"CNstorm 订单编号:%@",self.idsStr];
    }
    else if (self.payType == 1)
    {
        payment.shortDescription = [NSString stringWithFormat:@"CNstorm 运单编号:%@",self.idsStr];
    }
    else
    {
        payment.shortDescription = [NSString stringWithFormat:@"CNstorm 账户充值"];
    }
    
    payment.items = items;  // if not including multiple items, then leave payment.items as nil
    payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    // Update payPalConfig re accepting credit cards.
    self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
    
    PayPalPaymentViewController *paymentViewController =
          [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                 configuration:self.payPalConfig
                                                      delegate:self];

    [self.navigationController presentViewController:paymentViewController animated:YES completion:nil];
}

#pragma mark PayPalPaymentDelegate methods
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment
{
    NSLog(@"payPal支付成功 PayPal Payment Success!");
    
    self.resultText = [completedPayment description];
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.payType == 2)
    {
        [self thirdRechargeWebService];
    }
    else
    {
        [self thirdPayWebService];
    }
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController
{
    NSLog(@"PayPal Payment Canceled");
    [MBProgressHUD showError:@"取消支付" toView:self.view];
    self.resultText = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation
- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment
{
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}

/***********************************aliPay***************************************/
- (void)aliPay:(id)sender
{
    self.type = 2;//支付宝支付
    /*
	 *生成订单信息及签名
	 *由于demo的局限性，采用了将私钥放在本地签名的方法，商户可以根据自身情况选择签名方法
	 */
    NSString *appScheme = @"CNstormAliPay";
    NSString *orderInfo = [self getOrderInfo];
    NSString *signedStr = [self doRsa:orderInfo];
    
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
    
    [AlixLibService payOrder:orderString AndScheme:appScheme seletor:_result target:self];
}

- (NSString*)getOrderInfo
{
    /*
	 *点击获取prodcut实例并初始化订单信息
	 */
    NSMutableString * discription = [NSMutableString string];
	[discription appendFormat:@"partner=\"%@\"", PartnerID];
	[discription appendFormat:@"&seller_id=\"%@\"", SellerID];
	[discription appendFormat:@"&out_trade_no=\"%@\"", [self generateTradeNO]];
	[discription appendFormat:@"&subject=\"%@\"", self.aliName];
	[discription appendFormat:@"&body=\"%@\"", self.aliInfo];
	[discription appendFormat:@"&total_fee=\"%@\"", self.aliPrice];
	[discription appendFormat:@"&notify_url=\"%@\"", @"m.alipay.com"];
    [discription appendFormat:@"&service=\"%@\"", @"mobile.securitypay.pay"];
    [discription appendFormat:@"&payment_type=\"%@\"",@"1"];
	[discription appendFormat:@"&_input_charset=\"%@\"", @"utf-8"];
    [discription appendFormat:@"&it_b_pay=\"%@\"", @"30m"];
	[discription appendFormat:@"&show_url=\"%@\"",@"m.alipay.com"];
    [discription appendFormat:@"&return_url=\"%@\"", @"m.alipay.com"];
    
	return discription;
}

- (NSString *)generateTradeNO
{
	const int N = 15;
	
	NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	NSMutableString *result = [[NSMutableString alloc] init] ;
	srand(time(0));
	for (int i = 0; i < N; i++)
	{
		unsigned index = rand() % [sourceString length];
		NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
		[result appendString:s];
	}
	return result;
}

- (NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

//wap回调函数
- (void)paymentResult:(NSString *)resultd
{
    NSLog(@"paymentResult");
  
    //结果处理
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
	if (result)
    {
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            NSString* key = AlipayPubKey;
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                 //验证签名成功，交易结果无篡改
			}
            
            if (self.payType == 2)
            {
                [self thirdRechargeWebService];
            }
            else
            {
                [self thirdPayWebService];
            }
        }
        else
        {
            //支付失败
            [MBProgressHUD showError:@"取消支付" toView:self.view];
            self.hidesBottomBarWhenPushed = YES;
        }
    }
    else
    {
        //支付失败
        [MBProgressHUD showError:@"取消支付" toView:self.view];
        self.hidesBottomBarWhenPushed = YES;
    }
    
}

/********************支付宝国际信用卡**************************/
- (void)aliCreditPay:(id)sender
{
    self.type = 3;//支付宝国际信用卡
}

/********************第三方支付支付成功接口**************************/
- (void)thirdPayWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/order/third_party_payment"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestThirdPayFailed:)];
    [request setDidFinishSelector:@selector(requestThirdPayFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    [param setValue:self.idsStr forKey:@"orderIds"];
    [param setValue:[NSString stringWithFormat:@"%.2f",self.totalCost] forKey:@"money"];
    //第三方支付名称
    [param setValue:[NSString stringWithFormat:@"%d",self.type] forKey:@"type"];
    
    if (self.payType == 0)
    {
        [param setValue:[NSString stringWithFormat:@"0"] forKey:@"yundan"];
    }
    else if (self.payType == 1)
    {
        [param setValue:[NSString stringWithFormat:@"1"] forKey:@"yundan"];
    }
    NSString *paramJson = [param JSONRepresentation];
    NSLog(@"paramJson = %@",paramJson);
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestThirdPayFailed:(ASIHTTPRequest *)request
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

- (void)requestThirdPayFinished:(ASIHTTPRequest *)request
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
        
        if(resultCode == 0)
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            if (self.payType == 0)
            {
                request.hud.labelText = @"订单付款错误,请联系客服";
            }
            else if (self.payType == 1)
            {
                request.hud.labelText = @"运单付款错误,请联系客服";
            }
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            PayComViewController *payComViewController = [[PayComViewController alloc]initWithNibName:@"PayComViewController" bundle:nil];
            payComViewController.payType = self.payType;
            [self.navigationController pushViewController:payComViewController animated:YES];
        }
    }
}

- (void)thirdRechargeWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/account/online_charge"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestThirdRechargeFailed:)];
    [request setDidFinishSelector:@selector(requestThirdRechargeFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    [param setValue:[NSString stringWithFormat:@"%.2f",self.totalCost] forKey:@"amount"];
    [param setValue:[NSString stringWithFormat:@"%.2f",self.totalCost] forKey:@"money"];
    [param setValue:[NSString stringWithFormat:@"%d",self.type] forKey:@"type"];//第三方支付名称
    
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestThirdRechargeFailed:(ASIHTTPRequest *)request
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

- (void)requestThirdRechargeFinished:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSString *responseString =[request responseString];
        
        NSLog(@"responseString = %@",responseString);
        
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
            request.hud.labelText = @"充值付款错误,请联系客服";
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            PayComViewController *payComViewController = [[PayComViewController alloc]initWithNibName:@"PayComViewController" bundle:nil];
            payComViewController.payType = self.payType;
            [self.navigationController pushViewController:payComViewController animated:YES];
        }
    }
}

//单例模式实现方法
+ (id)shareInstance
{
    //NSAssert(thirdPayViewInstance != nil,@"thirdPayViewInstance can not be nil!");
    
    if(thirdPayViewInstance == nil)
    {
        thirdPayViewInstance = [[self alloc] init];
    }
    
    return thirdPayViewInstance;
}

/********************查询实时汇率接口**************************/
- (void)callSearchRateWebService
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
    [request setDidFailSelector:@selector(requestRateFailed:)];
    [request setDidFinishSelector:@selector(requestRateFinished:)];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"CNY"] forKey:@"code"];
    NSString *paramJson = [param JSONRepresentation];
    NSLog(@"paramJson = %@",paramJson);
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在查询实时汇率";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestRateFinished:(ASIHTTPRequest *)request
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
            request.hud.labelText = @"查询失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            NSString *result = [data objectForKey:@"result"];
            self.payRate = [result doubleValue];
            [self initPaypalView];
        }
    }
}

- (void)requestRateFailed:(ASIHTTPRequest *)request
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
