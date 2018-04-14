//
//  SelfBuyOrderDetailViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-14.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "SelfBuyOrderDetailViewController.h"

@interface SelfBuyOrderDetailViewController ()

@end

@implementation SelfBuyOrderDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.selfBuyOrder = [[SelfBuyOrder alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"自助购订单详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self initMyView];
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
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    [self.view addSubview:self.scrollView];
    
    UIView *orderStatusView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, MainScreenHeight-NavigationBarHeight-TransparentBarHeight, MainScreenWidth,TransparentBarHeight)];
    orderStatusView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.9f];
    orderStatusView.layer.borderWidth = 0.5f;
    orderStatusView.layer.borderColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:1].CGColor;
    [self.view addSubview:orderStatusView];
    
    float goodsListTableViewHeight = self.selfBuyOrder.goodsList.count*100.0f+37.5f;//TableView section+cell的高度
    //商品列表TableView的加载
    self.goodsListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,MainScreenWidth, goodsListTableViewHeight) style:UITableViewStylePlain];
    self.goodsListTableView.scrollEnabled = NO;
    self.goodsListTableView.delegate = self;
    self.goodsListTableView.dataSource = self;
    [self.scrollView addSubview:self.goodsListTableView];
    
    float receviceInfoViewHeight = 160.0f;
    UIView *receviceInfoView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, goodsListTableViewHeight, MainScreenWidth, receviceInfoViewHeight)];
    [self.scrollView addSubview:receviceInfoView];
    
    float orderInfoViewHeight = 120.0f;
    UIView *orderInfoView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, goodsListTableViewHeight+receviceInfoViewHeight, MainScreenWidth, orderInfoViewHeight)];
    [self.scrollView addSubview:orderInfoView];
    
    self.scrollViewHeight = goodsListTableViewHeight+receviceInfoViewHeight+orderInfoViewHeight;
    
    UILabel *receviceInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 320.0f, 30.0f)];
    receviceInfoLabel.text = @"收货信息";
    receviceInfoLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:(1.0f)];
    receviceInfoLabel.font = [UIFont systemFontOfSize:15.0f];
    receviceInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    receviceInfoLabel.numberOfLines = 1;
    receviceInfoLabel.textAlignment = NSTextAlignmentLeft;
    receviceInfoLabel.adjustsFontSizeToFitWidth = YES;
    receviceInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:receviceInfoLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 30.0f, 300.0f, 1.0f)];
    lineView.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [receviceInfoView addSubview:lineView];
    
    UILabel *receviceAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 30.0f, 70.0f, 40.0f)];
    receviceAddressLabel.text = @"地   址:";
    receviceAddressLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    receviceAddressLabel.font = [UIFont systemFontOfSize:14.0f];
    receviceAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    receviceAddressLabel.numberOfLines = 1;
    receviceAddressLabel.textAlignment = NSTextAlignmentLeft;
    receviceAddressLabel.adjustsFontSizeToFitWidth = YES;
    receviceAddressLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:receviceAddressLabel];
    
    UILabel *receviceAddressInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 25.0f, 210.0f, 50.0f)];
    receviceAddressInfoLabel.text = self.selfBuyOrder.receiveAddress;
    receviceAddressInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:1.0f];
    receviceAddressInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    receviceAddressInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    receviceAddressInfoLabel.numberOfLines = 2;
    receviceAddressInfoLabel.textAlignment = NSTextAlignmentLeft;
    receviceAddressInfoLabel.adjustsFontSizeToFitWidth = YES;
    receviceAddressInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:receviceAddressInfoLabel];
    
    UILabel *mailCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 70.0f, 70.0f, 30.0f)];
    mailCodeLabel.text = @"邮   编:";
    mailCodeLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    mailCodeLabel.font = [UIFont systemFontOfSize:14.0f];
    mailCodeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    mailCodeLabel.numberOfLines = 1;
    mailCodeLabel.textAlignment = NSTextAlignmentLeft;
    mailCodeLabel.adjustsFontSizeToFitWidth = YES;
    mailCodeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:mailCodeLabel];
    
    UILabel *mailCodeInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 70.0f, 200.0f, 30.0f)];
    mailCodeInfoLabel.text = self.selfBuyOrder.mailCode;
    mailCodeInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:1.0f];
    mailCodeInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    mailCodeInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    mailCodeInfoLabel.numberOfLines = 1;
    mailCodeInfoLabel.textAlignment = NSTextAlignmentLeft;
    mailCodeInfoLabel.adjustsFontSizeToFitWidth = YES;
    mailCodeInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:mailCodeInfoLabel];
    
    UILabel *recevicerLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 100.0f, 70.0f, 30.0f)];
    recevicerLabel.text = @"收 货 人:";
    recevicerLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    recevicerLabel.font = [UIFont systemFontOfSize:13.0f];
    recevicerLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    recevicerLabel.numberOfLines = 1;
    recevicerLabel.textAlignment = NSTextAlignmentLeft;
    recevicerLabel.adjustsFontSizeToFitWidth = YES;
    recevicerLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:recevicerLabel];
    
    UILabel *recevicerInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 100.0f, 200.0f, 30.0f)];
    recevicerInfoLabel.text = self.selfBuyOrder.receiver;
    recevicerInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:1.0f];
    recevicerInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    recevicerInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    recevicerInfoLabel.numberOfLines = 1;
    recevicerInfoLabel.textAlignment = NSTextAlignmentLeft;
    recevicerInfoLabel.adjustsFontSizeToFitWidth = YES;
    recevicerInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:recevicerInfoLabel];
    
    UILabel *telePhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 130.0f, 70.0f, 30.0f)];
    telePhoneLabel.text = @"电   话:";
    telePhoneLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    telePhoneLabel.font = [UIFont systemFontOfSize:13.0f];
    telePhoneLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    telePhoneLabel.numberOfLines = 1;
    telePhoneLabel.textAlignment = NSTextAlignmentLeft;
    telePhoneLabel.adjustsFontSizeToFitWidth = YES;
    telePhoneLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:telePhoneLabel];
    
    UILabel *telePhoneInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 130.0f, 200.0f, 30.0f)];
    telePhoneInfoLabel.text = self.selfBuyOrder.telePhone;
    telePhoneInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:1.0f];
    telePhoneInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    telePhoneInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    telePhoneInfoLabel.numberOfLines = 1;
    telePhoneInfoLabel.textAlignment = NSTextAlignmentLeft;
    telePhoneInfoLabel.adjustsFontSizeToFitWidth = YES;
    telePhoneInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:telePhoneInfoLabel];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 159.0f, 320.0f, 1.0f)];
    lineView2.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [receviceInfoView addSubview:lineView2];
    
    UILabel *orderInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 320.0f, 30.0f)];
    orderInfoLabel.text = @"订单信息";
    orderInfoLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:(1.0f)];
    orderInfoLabel.font = [UIFont systemFontOfSize:15.0f];
    orderInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    orderInfoLabel.numberOfLines = 1;
    orderInfoLabel.textAlignment = NSTextAlignmentLeft;
    orderInfoLabel.adjustsFontSizeToFitWidth = YES;
    orderInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [orderInfoView addSubview:orderInfoLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 30.0f, 300.0f, 1.0f)];
    lineView3.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [orderInfoView addSubview:lineView3];
    
    UILabel *storeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 30.0f, 70.0f, 30.0f)];
    storeNameLabel.text = @"店   铺:";
    storeNameLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    storeNameLabel.font = [UIFont systemFontOfSize:13.0f];
    storeNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    storeNameLabel.numberOfLines = 1;
    storeNameLabel.textAlignment = NSTextAlignmentLeft;
    storeNameLabel.adjustsFontSizeToFitWidth = YES;
    storeNameLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [orderInfoView addSubview:storeNameLabel];
    
    UILabel *storeNameInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 30.0f, 200.0f, 30.0f)];
    storeNameInfoLabel.text = [NSString stringWithFormat:@"%@",self.selfBuyOrder.storeName];
    storeNameInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:1.0f];
    storeNameInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    storeNameInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    storeNameInfoLabel.numberOfLines = 1;
    storeNameInfoLabel.textAlignment = NSTextAlignmentLeft;
    storeNameInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [orderInfoView addSubview:storeNameInfoLabel];
    
    UILabel *orderNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 60.0f, 70.0f, 30.0f)];
    orderNoLabel.text = @"订单编号:";
    orderNoLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    orderNoLabel.font = [UIFont systemFontOfSize:13.0f];
    orderNoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    orderNoLabel.numberOfLines = 1;
    orderNoLabel.textAlignment = NSTextAlignmentLeft;
    orderNoLabel.adjustsFontSizeToFitWidth = YES;
    orderNoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [orderInfoView addSubview:orderNoLabel];
    
    UILabel *wayNoInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 60.0f, 200.0f, 30.0f)];
    wayNoInfoLabel.text = self.selfBuyOrder.orderNo;
    wayNoInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:1.0f];
    wayNoInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    wayNoInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    wayNoInfoLabel.numberOfLines = 1;
    wayNoInfoLabel.textAlignment = NSTextAlignmentLeft;
    wayNoInfoLabel.adjustsFontSizeToFitWidth = YES;
    wayNoInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [orderInfoView addSubview:wayNoInfoLabel];
    
    UILabel *orderDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 90.0f, 70.0f, 30.0f)];
    orderDateLabel.text = @"日   期:";
    orderDateLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    orderDateLabel.font = [UIFont systemFontOfSize:13.0f];
    orderDateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    orderDateLabel.numberOfLines = 1;
    orderDateLabel.textAlignment = NSTextAlignmentLeft;
    orderDateLabel.adjustsFontSizeToFitWidth = YES;
    orderDateLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [orderInfoView addSubview:orderDateLabel];
    
    UILabel *orderDateInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 90.0f, 200.0f, 30.0f)];
    orderDateInfoLabel.text = self.selfBuyOrder.orderDate;
    orderDateInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:1.0f];
    orderDateInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    orderDateInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    orderDateInfoLabel.numberOfLines = 1;
    orderDateInfoLabel.textAlignment = NSTextAlignmentLeft;
    orderDateInfoLabel.adjustsFontSizeToFitWidth = YES;
    orderDateInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [orderInfoView addSubview:orderDateInfoLabel];
    
    NSLog(@"状态 yyy %d",self.selfBuyOrder.orderStatus);
    
    NSString *orderStatusButtonTitle = @"";
    if (self.selfBuyOrder.orderStatus == 1)
    {
        orderStatusButtonTitle = @"立即付款";//待付款
    }
    else if (self.selfBuyOrder.orderStatus == 2)
    {
        orderStatusButtonTitle = @"待发货";//已付款
    }
    else if (self.selfBuyOrder.orderStatus == 3)
    {
        orderStatusButtonTitle = @"待发货";
    }
    else if (self.selfBuyOrder.orderStatus ==4)
    {
        orderStatusButtonTitle = @"待收货";//已发货
    }
    else if (self.selfBuyOrder.orderStatus ==5)
    {
        orderStatusButtonTitle = @"待收货";//待入库
    }
    else if (self.selfBuyOrder.orderStatus ==6)
    {
        orderStatusButtonTitle = @"已确认收货";//已入库
    }
    else if (self.selfBuyOrder.orderStatus ==7)
    {
        orderStatusButtonTitle = @"缺货";
    }
    else if (self.selfBuyOrder.orderStatus ==8)
    {
        orderStatusButtonTitle = @"已提交运送";
    }
    else if (self.selfBuyOrder.orderStatus ==9)
    {
        orderStatusButtonTitle = @"待确认费用";
    }
    
    UIButton *orderStatusButton = [[UIButton alloc]initWithFrame:CGRectMake(70.0f, 10.0f, 75.0f,30.0f)];
    [orderStatusButton setTitle:orderStatusButtonTitle forState:UIControlStateNormal];
    orderStatusButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [orderStatusButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
    orderStatusButton.backgroundColor = [UIColor colorWithRed:(240.0f)/255.0f green:(240.0f)/255.0f blue:(240.0f)/255.0f alpha:1];
    [orderStatusButton.layer setCornerRadius:3.0f];
    orderStatusButton.layer.borderWidth = 0.5f;
    orderStatusButton.layer.borderColor = [UIColor colorWithRed:(200.0f)/255.0f green:(200.0f)/255.0f blue:(200.0f)/255.0f alpha:1].CGColor;
    [orderStatusView addSubview:orderStatusButton];
    
    if (self.selfBuyOrder.orderStatus == 1)
    {
        [orderStatusButton setTitleColor:[UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        orderStatusButton.backgroundColor = [UIColor colorWithRed:(255.0f)/255.0f green:(219.0f)/255.0f blue:(61.0f)/255.0f alpha:1];
        orderStatusButton.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(195.0f)/255.0f blue:(39.0f)/255.0f alpha:1].CGColor;
    }
    else
    {
        [orderStatusButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        orderStatusButton.backgroundColor = [UIColor colorWithRed:(240.0f)/255.0f green:(240.0f)/255.0f blue:(240.0f)/255.0f alpha:1];
        orderStatusButton.layer.borderColor = [UIColor colorWithRed:(200.0f)/255.0f green:(200.0f)/255.0f blue:(200.0f)/255.0f alpha:1].CGColor;
    }
    
    UIButton *expressButton = [[UIButton alloc]initWithFrame:CGRectMake(175.0f, 10.0f,75.0f,30.0f)];
    [expressButton setTitle:@"" forState:UIControlStateNormal];
    expressButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [expressButton setTitleColor:[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
    expressButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [expressButton.layer setCornerRadius:3.0f];
    expressButton.layer.borderWidth = 0.5f;
    expressButton.layer.borderColor = [UIColor colorWithRed:(200.0f)/255.0f green:(200.0f)/255.0f blue:(200.0f)/255.0f alpha:1].CGColor;
    expressButton.hidden = YES;
    [orderStatusView addSubview:expressButton];
    
    if (self.selfBuyOrder.expressNumber.length != 0 || ![self.selfBuyOrder.expressNumber isEqualToString:@""])
    {
        expressButton.hidden = NO;
        [expressButton setTitle:@"查看物流" forState:UIControlStateNormal];
        [expressButton addTarget:self action:@selector(expressShowView:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        expressButton.hidden = NO;
        [expressButton setTitle:@"补填快递" forState:UIControlStateNormal];
        [expressButton addTarget:self action:@selector(expressAddView:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,self.scrollViewHeight);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)expressShowView:(id)sender
{
    NSString *url = [NSString stringWithFormat:@"http://m.kuaidi100.com/index_all.html?type=%@&postid=%@",self.selfBuyOrder.express,self.selfBuyOrder.expressNumber];

    ExpressShowViewController *expressShowViewController = [[ExpressShowViewController alloc]initWithNibName:@"ExpressShowViewController" bundle:nil];
    MJNavigationController *goodsSellerNC = [[MJNavigationController alloc]initWithRootViewController:expressShowViewController];
    expressShowViewController.url = url;
    [self presentViewController:goodsSellerNC animated:YES completion:NULL];
}

- (void)expressAddView:(id)sender
{
    ExpressAddViewController *expressAddViewController = [[ExpressAddViewController alloc]initWithNibName:@"ExpressAddViewController" bundle:nil];
    expressAddViewController.orderId = self.selfBuyOrder.orderNo;
    expressAddViewController.delegate = self;
    [self.navigationController pushViewController:expressAddViewController animated:YES];
}

- (void)didFinishedWithExpress:(NSString *)express andNo:(NSString *)expressNo andHud:(MBProgressHUD *)hud
{
    [self.view addSubview:hud];
    
    self.selfBuyOrder.express = express;
    self.selfBuyOrder.expressNumber = expressNo;
    [self viewDidLoad];
}

//设置SectionHeader高度:
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 37.5f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //遮挡无数据部分tableView的分割线
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    
    return 1;
}

#pragma mark - UITableViewDelegate TableView委托
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断dataSouce的数据个数,如果为零可以隐藏分割线
    if (self.selfBuyOrder.goodsList.count == 0)
    {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else
    {
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return self.selfBuyOrder.goodsList.count;//每个订单，只显示1件商品
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AllOrderDetailHeaderView *headerView = [[AllOrderDetailHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 37.5f)];//创建一个视图
    headerView.headerLabel.text = [NSString stringWithFormat:@"%@",self.selfBuyOrder.storeName];
    return headerView;
}


#pragma mark - 方法:cell的加载和复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SelfBuyOrderDetailTableViewCellIdentifier = @"SelfBuyOrderDetailTableViewCellIdentifier";
    
    SelfBuyOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SelfBuyOrderDetailTableViewCellIdentifier];
    
    if (cell==nil)
    {
        cell=[[SelfBuyOrderDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelfBuyOrderDetailTableViewCellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    cell.goods = self.selfBuyOrder.goodsList[indexPath.row];
    
    return cell;
}

@end