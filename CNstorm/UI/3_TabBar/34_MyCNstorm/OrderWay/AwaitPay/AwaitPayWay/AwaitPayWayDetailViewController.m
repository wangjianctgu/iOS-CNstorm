//
//  AwaitPayWayDetailViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-13.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "AwaitPayWayDetailViewController.h"

@interface AwaitPayWayDetailViewController ()

@end

@implementation AwaitPayWayDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.way = [[Way alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"国际运单详情";
    
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
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    [self.view addSubview:self.scrollView];
    
    UIView *wayStatusView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, MainScreenHeight-NavigationBarHeight-TransparentBarHeight, MainScreenWidth,TransparentBarHeight)];
    wayStatusView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.9f];
    wayStatusView.layer.borderWidth = 0.5f;
    wayStatusView.layer.borderColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:1].CGColor;
    [self.view addSubview:wayStatusView];
    
    float goodsListTableViewHeight = self.way.packageList.count*37.5f + self.way.wayGoodsTypeCount*100.0f;//TableView section+cell的高度
    //商品列表TableView的加载
    self.goodsListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f,0.0f,320.0f, goodsListTableViewHeight) style:UITableViewStylePlain];
    self.goodsListTableView.scrollEnabled = NO;
    self.goodsListTableView.delegate = self;
    self.goodsListTableView.dataSource = self;
    [self.scrollView addSubview:self.goodsListTableView];
    
    float receviceInfoViewHeight = 160.0f;
    UIView *receviceInfoView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,goodsListTableViewHeight,320.0f, receviceInfoViewHeight)];
    [self.scrollView addSubview:receviceInfoView];
    
    float wayInfoViewHeight = 120.0f;
    UIView *wayInfoView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,goodsListTableViewHeight+receviceInfoViewHeight, 320.0f, wayInfoViewHeight)];
    [self.scrollView addSubview:wayInfoView];
    
    self.scrollViewHeight = goodsListTableViewHeight+receviceInfoViewHeight+wayInfoViewHeight;
    
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
    receviceAddressInfoLabel.text = self.way.receiveAddress;
    receviceAddressInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:1.0f];
    receviceAddressInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    receviceAddressInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    receviceAddressInfoLabel.numberOfLines = 3;
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
    mailCodeInfoLabel.text = self.way.mailCode;
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
    recevicerInfoLabel.text = self.way.receiver;
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
    telePhoneInfoLabel.text = self.way.telePhone;
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
    
    UILabel *wayInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 320.0f, 30.0f)];
    wayInfoLabel.text = @"运单信息";
    wayInfoLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:(1.0f)];
    wayInfoLabel.font = [UIFont systemFontOfSize:15.0f];
    wayInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    wayInfoLabel.numberOfLines = 1;
    wayInfoLabel.textAlignment = NSTextAlignmentLeft;
    wayInfoLabel.adjustsFontSizeToFitWidth = YES;
    wayInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:wayInfoLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 30.0f, 300.0f, 1.0f)];
    lineView3.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [wayInfoView addSubview:lineView3];
    
    UILabel *weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 30.0f, 70.0f, 30.0f)];
    weightLabel.text = @"实际重量:";
    weightLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    weightLabel.font = [UIFont systemFontOfSize:13.0f];
    weightLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    weightLabel.numberOfLines = 1;
    weightLabel.textAlignment = NSTextAlignmentLeft;
    weightLabel.adjustsFontSizeToFitWidth = YES;
    weightLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:weightLabel];
    
    UILabel *weightLabelInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 30.0f, 200.0f, 30.0f)];
    weightLabelInfoLabel.text = [NSString stringWithFormat:@"%.2fg",self.way.weight];
    weightLabelInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:1.0f];
    weightLabelInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    weightLabelInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    weightLabelInfoLabel.numberOfLines = 1;
    weightLabelInfoLabel.textAlignment = NSTextAlignmentLeft;
    weightLabelInfoLabel.adjustsFontSizeToFitWidth = YES;
    weightLabelInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:weightLabelInfoLabel];
    
    UILabel *wayNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 60.0f, 70.0f, 30.0f)];
    wayNoLabel.text = @"运单编号:";
    wayNoLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    wayNoLabel.font = [UIFont systemFontOfSize:13.0f];
    wayNoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    wayNoLabel.numberOfLines = 1;
    wayNoLabel.textAlignment = NSTextAlignmentLeft;
    wayNoLabel.adjustsFontSizeToFitWidth = YES;
    wayNoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:wayNoLabel];
    
    UILabel *wayNoInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 60.0f, 200.0f, 30.0f)];
    wayNoInfoLabel.text = self.way.wayNo;
    wayNoInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:1.0f];
    wayNoInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    wayNoInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    wayNoInfoLabel.numberOfLines = 1;
    wayNoInfoLabel.textAlignment = NSTextAlignmentLeft;
    wayNoInfoLabel.adjustsFontSizeToFitWidth = YES;
    wayNoInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:wayNoInfoLabel];
    
    UILabel *wayDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 90.0f, 70.0f, 30.0f)];
    wayDateLabel.text = @"日   期:";
    wayDateLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    wayDateLabel.font = [UIFont systemFontOfSize:13.0f];
    wayDateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    wayDateLabel.numberOfLines = 1;
    wayDateLabel.textAlignment = NSTextAlignmentLeft;
    wayDateLabel.adjustsFontSizeToFitWidth = YES;
    wayDateLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:wayDateLabel];
    
    UILabel *wayDateInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 90.0f, 200.0f, 30.0f)];
    wayDateInfoLabel.text = self.way.wayDate;
    wayDateInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:1.0f];
    wayDateInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    wayDateInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    wayDateInfoLabel.numberOfLines = 1;
    wayDateInfoLabel.textAlignment = NSTextAlignmentLeft;
    wayDateInfoLabel.adjustsFontSizeToFitWidth = YES;
    wayDateInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:wayDateInfoLabel];
    
    UILabel *yunfeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 10.0f, 110.0f, 30.0f)];
    yunfeiLabel.text = [NSString stringWithFormat:@"运费:￥%.2f",self.way.yunfei];
    yunfeiLabel.textColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:1.0f];
    yunfeiLabel.font = [UIFont systemFontOfSize:15.0f];
    yunfeiLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    yunfeiLabel.numberOfLines = 1;
    yunfeiLabel.textAlignment = NSTextAlignmentLeft;
    yunfeiLabel.adjustsFontSizeToFitWidth = YES;
    yunfeiLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayStatusView addSubview:yunfeiLabel];
    
    NSString *wayStatusButtonTitle = nil;
    
    if (self.way.wayStatus == 0)
    {
        wayStatusButtonTitle = @"立即付款";
    }
    else if (self.way.wayStatus == 1)
    {
        wayStatusButtonTitle = @"待发货";
    }
    else if (self.way.wayStatus == 2)
    {
        wayStatusButtonTitle = @"待收货";
    }
    else if (self.way.wayStatus == 3)
    {
        wayStatusButtonTitle = @"已确认收货";
    }
    else if (self.way.wayStatus == 4)
    {
        wayStatusButtonTitle = @"无效订单";
    }
    else if (self.way.wayStatus == 5)
    {
        wayStatusButtonTitle = @"待发货";
    }
    else if (self.way.wayStatus == 6)
    {
        wayStatusButtonTitle = @"待补交运费";
    }
    else if (self.way.wayStatus == 7)
    {
        wayStatusButtonTitle = @"信息不全";
    }
    else
    {
        wayStatusButtonTitle = @"已评价";
    }
    
    UIButton *wayStatusButton = [[UIButton alloc]initWithFrame:CGRectMake(140.0f, 10.0f, 75.0f,30.0f)];
    [wayStatusButton setTitle:wayStatusButtonTitle forState:UIControlStateNormal];
    wayStatusButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [wayStatusButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
    wayStatusButton.backgroundColor = [UIColor colorWithRed:(240.0f)/255.0f green:(240.0f)/255.0f blue:(240.0f)/255.0f alpha:1];
    [wayStatusButton.layer setCornerRadius:3.0f];
    wayStatusButton.layer.borderWidth = 0.5f;
    wayStatusButton.layer.borderColor = [UIColor colorWithRed:(200.0f)/255.0f green:(200.0f)/255.0f blue:(200.0f)/255.0f alpha:1].CGColor;
    [wayStatusView addSubview:wayStatusButton];
    
    if (self.way.wayStatus == 0)
    {
        [wayStatusButton setTitleColor:[UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        wayStatusButton.backgroundColor = [UIColor colorWithRed:(255.0f)/255.0f green:(219.0f)/255.0f blue:(61.0f)/255.0f alpha:1];
        wayStatusButton.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(195.0f)/255.0f blue:(39.0f)/255.0f alpha:1].CGColor;
        [wayStatusButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [wayStatusButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        wayStatusButton.backgroundColor = [UIColor colorWithRed:(240.0f)/255.0f green:(240.0f)/255.0f blue:(240.0f)/255.0f alpha:1];
        wayStatusButton.layer.borderColor = [UIColor colorWithRed:(200.0f)/255.0f green:(200.0f)/255.0f blue:(200.0f)/255.0f alpha:1].CGColor;
    }
    
    if (self.way.expressNumber.length != 0 || ![self.way.expressNumber isEqualToString:@""])
    {
        UIButton *expressButton = [[UIButton alloc]initWithFrame:CGRectMake(235.0f, 10.0f,75.0f,30.0f)];
        [expressButton setTitle:@"查看物流" forState:UIControlStateNormal];
        [expressButton addTarget:self action:@selector(expressShowView:) forControlEvents:UIControlEventTouchUpInside];
        expressButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [expressButton setTitleColor:[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        expressButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
        [expressButton.layer setCornerRadius:3.0f];
        expressButton.layer.borderWidth = 0.5f;
        expressButton.layer.borderColor = [UIColor colorWithRed:(200.0f)/255.0f green:(200.0f)/255.0f blue:(200.0f)/255.0f alpha:1].CGColor;
        [wayStatusView addSubview:expressButton];
    }
    else
    {
        [wayStatusButton setFrame:CGRectMake(230.0f, 10.0f, 75.0f, 30.0f)];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,self.scrollViewHeight);
}

- (void)expressShowView:(id)sender
{
    NSString *url = [NSString stringWithFormat:@"http://m.kuaidi100.com/index_all.html?type=%@&postid=%@",self.way.express,self.way.expressNumber];
    
    if ([self.way.express isEqualToString:@"东马专线"]||[self.way.express isEqualToString:@"西马专线"]||[self.way.express isEqualToString:@"新马专线"]) {
        url = [NSString stringWithFormat:@"http://www.com1express.com/tracking/hawb/%@",self.way.expressNumber];
    }
    
    if ([self.way.express isEqualToString:@"DHL"]) {
        url = [NSString stringWithFormat:@"http://www.1001000.cc/page/queryTrack?queryCode=%@",self.way.expressNumber];
    }
    
    if ([self.way.express isEqualToString:@"SAL水陆联运"]) {
        url = [NSString stringWithFormat:@"http://m.kuaidi100.com/result.jsp?nu=%@",self.way.expressNumber];
    }
    
    ExpressShowViewController *expressShowViewController = [[ExpressShowViewController alloc]initWithNibName:@"ExpressShowViewController" bundle:nil];
    MJNavigationController *goodsSellerNC = [[MJNavigationController alloc]initWithRootViewController:expressShowViewController];
    expressShowViewController.url = url;
    [self presentViewController:goodsSellerNC animated:YES completion:NULL];
}

- (void)commit:(id)sender
{
    WayPayViewController *wayPayViewController = [[WayPayViewController alloc]initWithNibName:@"WayPayViewController" bundle:nil];
    wayPayViewController.wayIdStr = self.way.wayNo;
    wayPayViewController.wayTotalCost = self.way.yunfei;
    [self.navigationController pushViewController:wayPayViewController animated:YES];
}


//设置SectionHeader高度:
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 37.5f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //遮挡无数据部分tableView的分割线
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    
    //判断dataSouce的数据个数,如果为零可以隐藏分割线
    if (self.way.packageList.count == 0)
    {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else
    {
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return self.way.packageList.count;
}

#pragma mark - UITableViewDelegate TableView委托
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Package *package =  (Package *)self.way.packageList[section];
    
    if ([package isKindOfClass:[BuyPackage class]])
    {
        return ((BuyPackage *)package).goodsList.count;
    }
    else
    {
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AllWayDetailHeaderView *headerView = [[AllWayDetailHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 37.5f)];//创建一个视图
    Package *package = (Package *)self.way.packageList[section];
    headerView.headerLabel.text = package.packageIndex;
    return headerView;
}

#pragma mark - 方法:cell的加载和复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Package *package = (Package *)self.way.packageList[indexPath.section];
    
    if ([package isKindOfClass:[BuyPackage class]])
    {
        static NSString *AllWayDetailTableViewCellIdentifier = @"AllWayDetailTableViewCellIdentifier";
        
        AllWayDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AllWayDetailTableViewCellIdentifier];
        
        if (cell==nil)
        {
            cell = [[AllWayDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AllWayDetailTableViewCellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        cell.goods = ((BuyPackage *)package).goodsList[indexPath.row];
        
        return cell;
    }
    else
    {
        static NSString *AllWayDetail2TableViewCellIdentifier = @"AllWayDetail2TableViewCellIdentifier";
        
        AllWayDetail2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AllWayDetail2TableViewCellIdentifier];
        
        if (cell==nil)
        {
            cell = [[AllWayDetail2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AllWayDetail2TableViewCellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        cell.selfPackage = (SelfPackage *)package;
        
        return cell;
    }
}

@end
