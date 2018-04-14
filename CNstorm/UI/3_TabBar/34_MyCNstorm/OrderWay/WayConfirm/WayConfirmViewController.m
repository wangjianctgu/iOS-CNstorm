//
//  WayConfirmViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-18.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "WayConfirmViewController.h"

@interface WayConfirmViewController ()

@end

@implementation WayConfirmViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.way = [[Way alloc]init];
        self.wayVaue = [[WayValue alloc]init];
        self.addressList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"国际运单确认";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self initPackageData];
    
    [self initMyView];
    
    [self callAddressListWebService];
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
    self.scrollView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.view addSubview:self.scrollView];
    
    UIView *payView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, MainScreenHeight-NavigationBarHeight-TransparentBarHeight, 320.0f, TransparentBarHeight)];
    payView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.9f];
    [self.view addSubview:payView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 1.0f)];
    lineView.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [payView addSubview:lineView];
    
    float spaceViewHeight = 12.0f;
    float receviceAddressViewHeight = 129.0f;
    self.receviceAddressView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, receviceAddressViewHeight)];
    self.receviceAddressView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:self.receviceAddressView];
    
    float packageViewHeight = 98.5f;
    UIView *packageView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, receviceAddressViewHeight+spaceViewHeight, 320.0f, packageViewHeight)];
    packageView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    packageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:packageView];
    
    float selfServiceViewHeight = 192.0f;
    UIView *selfServiceView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, receviceAddressViewHeight+packageViewHeight+2*spaceViewHeight, 320.0f, selfServiceViewHeight)];
    selfServiceView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:selfServiceView];
    
    float transportViewHeight = 72.0f;
    UIView *transportView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, receviceAddressViewHeight+packageViewHeight+selfServiceViewHeight+3*spaceViewHeight, 320.0f, transportViewHeight)];
    transportView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    transportView.userInteractionEnabled = YES;
    [self.scrollView addSubview:transportView];
    
    //9.备注Remark
    float remarkViewHeight = 90.0f;
    UIView *remarkView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, receviceAddressViewHeight+packageViewHeight+selfServiceViewHeight+transportViewHeight+4*spaceViewHeight, 320.0f,remarkViewHeight)];
    remarkView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:remarkView];
    
    float costCountViewHeight = 208.0f;
    UIView *costCountView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, receviceAddressViewHeight+packageViewHeight+selfServiceViewHeight+transportViewHeight+remarkViewHeight+5*spaceViewHeight, 320.0f, costCountViewHeight)];
    costCountView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:costCountView];
    
    self.scrollViewHeight = TransparentBarHeight+receviceAddressViewHeight+packageViewHeight+selfServiceViewHeight+transportViewHeight+remarkViewHeight+costCountViewHeight+5*spaceViewHeight;
    
    UILabel *receviceAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 310.0f, 32.0f)];
    receviceAddressLabel.text = @"收货信息";
    receviceAddressLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    receviceAddressLabel.font = [UIFont systemFontOfSize:16.0f];
    receviceAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    receviceAddressLabel.numberOfLines = 1;
    receviceAddressLabel.textAlignment = NSTextAlignmentLeft;
    receviceAddressLabel.adjustsFontSizeToFitWidth = YES;
    receviceAddressLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [self.receviceAddressView addSubview:receviceAddressLabel];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 32.0f, 300.0f, 1.0f)];
    lineView1.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [self.receviceAddressView addSubview:lineView1];

    UILabel *recevicerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 37.0f, 140.0f, 23.0f)];
    recevicerLabel.text = @"收货人";
    recevicerLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    recevicerLabel.font = [UIFont systemFontOfSize:15.0f];
    recevicerLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    recevicerLabel.numberOfLines = 1;
    recevicerLabel.textAlignment = NSTextAlignmentLeft;
    recevicerLabel.adjustsFontSizeToFitWidth = YES;
    recevicerLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [self.receviceAddressView addSubview:recevicerLabel];
    
    UILabel *telePhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(150.0f, 37.0f, 140.0f, 23.0f)];
    telePhoneLabel.text = @"电话号码/手机";
    telePhoneLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    telePhoneLabel.font = [UIFont systemFontOfSize:14.0f];
    telePhoneLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    telePhoneLabel.numberOfLines = 1;
    telePhoneLabel.textAlignment = NSTextAlignmentRight;
    telePhoneLabel.adjustsFontSizeToFitWidth = YES;
    telePhoneLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [self.receviceAddressView addSubview:telePhoneLabel];
    
    UILabel *addressDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 60.0f, 280.0f, 69.0f)];
    addressDetailLabel.text = @"街区详细地址/市/省/国家/邮编...";
    addressDetailLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    addressDetailLabel.font = [UIFont systemFontOfSize:14.0f];
    addressDetailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    addressDetailLabel.numberOfLines = 3;
    addressDetailLabel.textAlignment = NSTextAlignmentLeft;
    addressDetailLabel.adjustsFontSizeToFitWidth = YES;
    addressDetailLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [self.receviceAddressView addSubview:addressDetailLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(295.0f,60.0f, 10.0f, 17.0f)];
    [arrowImageView setImage:[UIImage imageNamed:@"arrow"]];
    [self.receviceAddressView addSubview:arrowImageView];
    
    UILabel *packageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 320.0f, 32.0f)];
    packageLabel.text = @"订单清单";
    packageLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    packageLabel.font = [UIFont systemFontOfSize:16.0f];
    packageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    packageLabel.numberOfLines = 1;
    packageLabel.textAlignment = NSTextAlignmentLeft;
    packageLabel.adjustsFontSizeToFitWidth = YES;
    packageLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [packageView addSubview:packageLabel];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 32.0f, 300.0f, 1.0f)];
    lineView2.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [packageView addSubview:lineView2];
    
    UILabel *packageTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 37.0f, 280.0f, 31.5f)];
    packageTitleLabel.text = [NSString stringWithFormat:@"%@",self.way.wayTitel];
    packageTitleLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    packageTitleLabel.font = [UIFont systemFontOfSize:14.0f];
    packageTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    packageTitleLabel.numberOfLines = 1;
    packageTitleLabel.textAlignment = NSTextAlignmentLeft;
    packageTitleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [packageView addSubview:packageTitleLabel];
    
    UILabel *packageWeightLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 68.5f, 200.0f, 30.0f)];
    packageWeightLabel.text = [NSString stringWithFormat:@"物品总重:%.2fg",self.way.weight];
    packageWeightLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    packageWeightLabel.font = [UIFont systemFontOfSize:13.0f];
    packageWeightLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    packageWeightLabel.numberOfLines = 1;
    packageWeightLabel.textAlignment = NSTextAlignmentLeft;
    packageWeightLabel.adjustsFontSizeToFitWidth = YES;
    packageWeightLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [packageView addSubview:packageWeightLabel];

    UILabel *packageListCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(210.0f, 68.5f, 95.0f, 33.0f)];
    packageListCountLabel.text = [NSString stringWithFormat:@"合计:%d件订单",(int)self.way.packageList.count];
    packageListCountLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    packageListCountLabel.font = [UIFont systemFontOfSize:13.0f];
    packageListCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    packageListCountLabel.numberOfLines = 1;
    packageListCountLabel.textAlignment = NSTextAlignmentRight;
    packageListCountLabel.adjustsFontSizeToFitWidth = YES;
    packageListCountLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [packageView addSubview:packageListCountLabel];

    UIImageView *arrowImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(295.0f,48.0f, 6.0f, 10.5f)];
    [arrowImageView2 setImage:[UIImage imageNamed:@"accessoryView"]];
    [packageView addSubview:arrowImageView2];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushWayConfirmPackageView:)];
    tap1.numberOfTapsRequired = 1;//不同的实体数目
    [packageView addGestureRecognizer:tap1];
    
    /*************************自选服务**********************/
    UILabel *selfServiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 310.0f, 32.0f)];
    selfServiceLabel.text = @"自选服务";
    selfServiceLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    selfServiceLabel.font = [UIFont systemFontOfSize:16.0f];
    selfServiceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    selfServiceLabel.numberOfLines = 1;
    selfServiceLabel.textAlignment = NSTextAlignmentLeft;
    selfServiceLabel.adjustsFontSizeToFitWidth = YES;
    selfServiceLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [selfServiceView addSubview:selfServiceLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 32.0f, 300.0f, 1.0f)];
    lineView3.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [selfServiceView addSubview:lineView3];
    
    //打包策略
    UILabel *packagingLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 32.0f, 60.0f, 40.0f)];
    packagingLabel.text = @"打包策略";
    packagingLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    packagingLabel.font = [UIFont systemFontOfSize:14.0f];
    packagingLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    packagingLabel.numberOfLines = 1;
    packagingLabel.textAlignment = NSTextAlignmentLeft;
    packagingLabel.adjustsFontSizeToFitWidth = YES;
    packagingLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    packagingLabel.userInteractionEnabled = YES;
    [selfServiceView addSubview:packagingLabel];
    
    self.packagingValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(70.0f, 32.0f, 220.0f, 40.0f)];
    self.packagingValueLabel.text = @"认证用户免费体验经济打包方案";
    self.packagingValueLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.packagingValueLabel.font = [UIFont systemFontOfSize:13.0f];
    self.packagingValueLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.packagingValueLabel.numberOfLines = 1;
    self.packagingValueLabel.textAlignment = NSTextAlignmentRight;
    self.packagingValueLabel.adjustsFontSizeToFitWidth = YES;
    self.packagingValueLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    self.packagingValueLabel.userInteractionEnabled = YES;
    [selfServiceView addSubview:self.packagingValueLabel];
    
    UIImageView *arrowImageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(295.0f,46.5f, 6.0f, 10.5f)];
    [arrowImageView3 setImage:[UIImage imageNamed:@"accessoryView"]];
    [selfServiceView addSubview:arrowImageView3];

    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 72.0f, 300.0f, 1.0f)];
    lineView4.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [selfServiceView addSubview:lineView4];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(packagingTapped:)];
    tap2.numberOfTapsRequired = 1;
    [packagingLabel addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap22 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(packagingTapped:)];
    tap22.numberOfTapsRequired = 1;
    [self.packagingValueLabel addGestureRecognizer:tap22];
    
    //订单处理
    UILabel *orderDealLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 72.0f, 60.0f, 40.0f)];
    orderDealLabel.text = @"订单处理";
    orderDealLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    orderDealLabel.font = [UIFont systemFontOfSize:14.0f];
    orderDealLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    orderDealLabel.numberOfLines = 1;
    orderDealLabel.textAlignment = NSTextAlignmentLeft;
    orderDealLabel.adjustsFontSizeToFitWidth = YES;
    orderDealLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    orderDealLabel.userInteractionEnabled = YES;
    [selfServiceView addSubview:orderDealLabel];
    
    self.orderDealValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(70.0f, 72.0f, 220.0f, 40.0f)];
    self.orderDealValueLabel.text = @"认证用户免费体验经济保障方案";
    self.orderDealValueLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.orderDealValueLabel.font = [UIFont systemFontOfSize:13.0f];
    self.orderDealValueLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.orderDealValueLabel.numberOfLines = 1;
    self.orderDealValueLabel.textAlignment = NSTextAlignmentRight;
    self.orderDealValueLabel.adjustsFontSizeToFitWidth = YES;
    self.orderDealValueLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    self.orderDealValueLabel.userInteractionEnabled = YES;
    [selfServiceView addSubview:self.orderDealValueLabel];
    
    UIImageView *arrowImageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(295.0f,86.5f, 6.0f, 10.5f)];
    [arrowImageView4 setImage:[UIImage imageNamed:@"accessoryView"]];
    [selfServiceView addSubview:arrowImageView4];
    
    UIView *lineView5 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 112.0f, 300.0f, 1.0f)];
    lineView5.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [selfServiceView addSubview:lineView5];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderDealTapped:)];
    tap3.numberOfTapsRequired = 1;
    [orderDealLabel addGestureRecognizer:tap3];
    
    UITapGestureRecognizer *tap33 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderDealTapped:)];
    tap33.numberOfTapsRequired = 1;
    [self.orderDealValueLabel addGestureRecognizer:tap33];
    
    //包装材料
    UILabel *packageMaterialLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 112.0f, 60.0f, 40.0f)];
    packageMaterialLabel.text = @"包装材料";
    packageMaterialLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    packageMaterialLabel.font = [UIFont systemFontOfSize:14.0f];
    packageMaterialLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    packageMaterialLabel.numberOfLines = 1;
    packageMaterialLabel.textAlignment = NSTextAlignmentLeft;
    packageMaterialLabel.adjustsFontSizeToFitWidth = YES;
    packageMaterialLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    packageMaterialLabel.userInteractionEnabled = YES;
    [selfServiceView addSubview:packageMaterialLabel];
    
    self.packageMaterialValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(70.0f, 112.0f, 220.0f, 40.0f)];
    self.packageMaterialValueLabel.text = @"认证用户免费体验标准耗材";
    self.packageMaterialValueLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.packageMaterialValueLabel.font = [UIFont systemFontOfSize:13.0f];
    self.packageMaterialValueLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.packageMaterialValueLabel.numberOfLines = 1;
    self.packageMaterialValueLabel.textAlignment = NSTextAlignmentRight;
    self.packageMaterialValueLabel.adjustsFontSizeToFitWidth = YES;
    self.packageMaterialValueLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    self.packageMaterialValueLabel.userInteractionEnabled = YES;
    [selfServiceView addSubview:self.packageMaterialValueLabel];
    
    UIImageView *arrowImageView5 = [[UIImageView alloc]initWithFrame:CGRectMake(295.0f,126.5f, 6.0f, 10.5f)];
    [arrowImageView5 setImage:[UIImage imageNamed:@"accessoryView"]];
    [selfServiceView addSubview:arrowImageView5];
    
    UIView *lineView6 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 152.0f, 300.0f, 1.0f)];
    lineView6.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [selfServiceView addSubview:lineView6];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(packageMaterialTapped:)];
    tap4.numberOfTapsRequired = 1;
    [packageMaterialLabel addGestureRecognizer:tap4];
    
    UITapGestureRecognizer *tap44 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(packageMaterialTapped:)];
    tap44.numberOfTapsRequired = 1;
    [self.packageMaterialValueLabel addGestureRecognizer:tap44];
    
    //增值服务
    UILabel *valueServiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 152.0f, 310.0f, 40.0f)];
    valueServiceLabel.text = @"增值服务";
    valueServiceLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    valueServiceLabel.font = [UIFont systemFontOfSize:14.0f];
    valueServiceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    valueServiceLabel.numberOfLines = 1;
    valueServiceLabel.textAlignment = NSTextAlignmentLeft;
    valueServiceLabel.adjustsFontSizeToFitWidth = YES;
    valueServiceLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    valueServiceLabel.userInteractionEnabled = YES;
    [selfServiceView addSubview:valueServiceLabel];
    
    self.valueServiceValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(70.0f, 152.0f, 220.0f, 40.0f)];
    self.valueServiceValueLabel.text = @"免费提供客服支持,在线跟踪功能";
    self.valueServiceValueLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.valueServiceValueLabel.font = [UIFont systemFontOfSize:13.0f];
    self.valueServiceValueLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.valueServiceValueLabel.numberOfLines = 1;
    self.valueServiceValueLabel.textAlignment = NSTextAlignmentRight;
    self.valueServiceValueLabel.adjustsFontSizeToFitWidth = YES;
    self.valueServiceValueLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    self.valueServiceValueLabel.userInteractionEnabled = YES;
    [selfServiceView addSubview:self.valueServiceValueLabel];
    
    UIImageView *arrowImageView6 = [[UIImageView alloc]initWithFrame:CGRectMake(295.0f,166.5f, 6.0f, 10.5f)];
    [arrowImageView6 setImage:[UIImage imageNamed:@"accessoryView"]];
    [selfServiceView addSubview:arrowImageView6];
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(valueServiceTapped:)];
    tap5.numberOfTapsRequired = 1;
    [valueServiceLabel addGestureRecognizer:tap5];
    
    UITapGestureRecognizer *tap55 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(valueServiceTapped:)];
    tap55.numberOfTapsRequired = 1;
    [self.valueServiceValueLabel addGestureRecognizer:tap55];
    
    /*************************运输方式**********************/
    UILabel *transportLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 320.0f, 32.0f)];
    transportLabel.text = @"运输方式";
    transportLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    transportLabel.font = [UIFont systemFontOfSize:16.0f];
    transportLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    transportLabel.numberOfLines = 1;
    transportLabel.textAlignment = NSTextAlignmentLeft;
    transportLabel.adjustsFontSizeToFitWidth = YES;
    transportLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [transportView addSubview:transportLabel];
    
    UIView *lineView7 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 32.0f, 300.0f, 1.0f)];
    lineView7.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [transportView addSubview:lineView7];
    
    self.transportTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 32.0f, 280.0f, 40.0f)];
    self.transportTypeLabel.text = @"选择物流公司或运输线路";
    self.transportTypeLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    self.transportTypeLabel.font = [UIFont systemFontOfSize:14.0f];
    self.transportTypeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.transportTypeLabel.numberOfLines = 1;
    self.transportTypeLabel.textAlignment = NSTextAlignmentLeft;
    self.transportTypeLabel.adjustsFontSizeToFitWidth = YES;
    self.transportTypeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [transportView addSubview:self.transportTypeLabel];
    
    UIImageView *arrowImageView7 = [[UIImageView alloc]initWithFrame:CGRectMake(295.0f,46.5f, 6.0f, 10.5f)];
    [arrowImageView7 setImage:[UIImage imageNamed:@"accessoryView"]];
    [transportView addSubview:arrowImageView7];
    
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deliveryTapped:)];
    tap6.numberOfTapsRequired = 1;
    [transportView addGestureRecognizer:tap6];
    
    //备注
    UILabel *remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 320.0f, 32.0f)];
    remarkLabel.text = @"填写备注";
    remarkLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    remarkLabel.font = [UIFont systemFontOfSize:16.0f];
    remarkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    remarkLabel.numberOfLines = 1;
    remarkLabel.textAlignment = NSTextAlignmentLeft;
    remarkLabel.adjustsFontSizeToFitWidth = YES;
    remarkLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [remarkView addSubview:remarkLabel];
    
    self.remarkTextView = [[UITextView alloc]initWithFrame:CGRectMake(10.0f, 32.0f, 300.0f, 50.0f)];
    self.remarkTextView.delegate = self;
    self.remarkTextView.backgroundColor = [UIColor whiteColor];
    self.remarkTextView.font = [UIFont systemFontOfSize:13.0f];
    self.remarkTextView.textAlignment = NSTextAlignmentLeft;
    self.remarkTextView.layer.cornerRadius = 3.0f;
    self.remarkTextView.layer.borderWidth = 0.5f;
    self.remarkTextView.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
    self.remarkTextView.returnKeyType = UIReturnKeyDone;
    self.remarkTextView.keyboardType = UIKeyboardTypeDefault;
    self.remarkTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    [remarkView addSubview:self.remarkTextView];
    
    //费用结算
    UILabel *costCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 310.0f, 32.0f)];
    costCountLabel.text = @"费用结算";
    costCountLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    costCountLabel.font = [UIFont systemFontOfSize:16.0f];
    costCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    costCountLabel.numberOfLines = 1;
    costCountLabel.textAlignment = NSTextAlignmentLeft;
    costCountLabel.adjustsFontSizeToFitWidth = YES;
    costCountLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [costCountView addSubview:costCountLabel];
    
    UIView *lineView8 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 32.0f, 300.0f, 1.0f)];
    lineView8.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [costCountView addSubview:lineView8];
    
    UILabel *yunfeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 32.0f, 50.0f, 28.0f)];
    yunfeiLabel.text = @"运   费:";
    yunfeiLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    yunfeiLabel.font = [UIFont systemFontOfSize:14.0f];
    yunfeiLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    yunfeiLabel.numberOfLines = 1;
    yunfeiLabel.textAlignment = NSTextAlignmentLeft;
    yunfeiLabel.adjustsFontSizeToFitWidth = YES;
    yunfeiLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [costCountView addSubview:yunfeiLabel];
    
    self.yunfeiInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(60.0f, 32.0f, 250.0f, 28.0f)];
    self.yunfeiInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",0.00f];
    self.yunfeiInfoLabel.textColor = [UIColor colorWithRed:(253.0f/255.0f) green:(78.0f/255.0f) blue:(46.0f/255.0f) alpha:1.0f];
    self.yunfeiInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    self.yunfeiInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.yunfeiInfoLabel.numberOfLines = 1;
    self.yunfeiInfoLabel.textAlignment = NSTextAlignmentLeft;
    self.yunfeiInfoLabel.adjustsFontSizeToFitWidth = YES;
    self.yunfeiInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [costCountView addSubview:self.yunfeiInfoLabel];

    UILabel *tariffLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 60.0f, 50.0f, 28.0f)];
    tariffLabel.text = @"报关税:";
    tariffLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    tariffLabel.font = [UIFont systemFontOfSize:14.0f];
    tariffLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    tariffLabel.numberOfLines = 1;
    tariffLabel.textAlignment = NSTextAlignmentLeft;
    tariffLabel.adjustsFontSizeToFitWidth = YES;
    tariffLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [costCountView addSubview:tariffLabel];
    
    self.tariffInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(60.0f, 60.0f, 250.0f, 28.0f)];
    self.tariffInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",8.00f];
    self.tariffInfoLabel.textColor = [UIColor colorWithRed:(253.0f/255.0f) green:(78.0f/255.0f) blue:(46.0f/255.0f) alpha:1.0f];
    self.tariffInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    self.tariffInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.tariffInfoLabel.numberOfLines = 1;
    self.tariffInfoLabel.textAlignment = NSTextAlignmentLeft;
    self.tariffInfoLabel.adjustsFontSizeToFitWidth = YES;
    self.tariffInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [costCountView addSubview:self.tariffInfoLabel];
    
    UILabel *serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 88.0f, 50.0f, 28.0f)];
    serviceLabel.text = @"服务费:";
    serviceLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    serviceLabel.font = [UIFont systemFontOfSize:14.0f];
    serviceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    serviceLabel.numberOfLines = 1;
    serviceLabel.textAlignment = NSTextAlignmentLeft;
    serviceLabel.adjustsFontSizeToFitWidth = YES;
    serviceLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [costCountView addSubview:serviceLabel];
    
    self.serviceInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(60.0f, 88.0f, 250.0f, 28.0f)];
    self.serviceInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",0.00f];
    self.serviceInfoLabel.textColor = [UIColor colorWithRed:(253.0f/255.0f) green:(78.0f/255.0f) blue:(46.0f/255.0f) alpha:1.0f];
    self.serviceInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    self.serviceInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.serviceInfoLabel.numberOfLines = 1;
    self.serviceInfoLabel.textAlignment = NSTextAlignmentLeft;
    self.serviceInfoLabel.adjustsFontSizeToFitWidth = YES;
    self.serviceInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [costCountView addSubview:self.serviceInfoLabel];
    
    UILabel *preferentialLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 116.0f, 50.0f, 28.0f)];
    preferentialLabel.text = @"优   惠:";
    preferentialLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    preferentialLabel.font = [UIFont systemFontOfSize:14.0f];
    preferentialLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    preferentialLabel.numberOfLines = 1;
    preferentialLabel.textAlignment = NSTextAlignmentLeft;
    preferentialLabel.adjustsFontSizeToFitWidth = YES;
    preferentialLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [costCountView addSubview:preferentialLabel];
    
    self.preferentialInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(60.0f, 116.0f, 250.0f, 28.0f)];
    self.preferentialInfoLabel.text = [NSString stringWithFormat:@"-￥%.2f",0.00f];
    self.preferentialInfoLabel.textColor = [UIColor colorWithRed:(253.0f/255.0f) green:(78.0f/255.0f) blue:(46.0f/255.0f) alpha:1.0f];
    self.preferentialInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    self.preferentialInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.preferentialInfoLabel.numberOfLines = 1;
    self.preferentialInfoLabel.textAlignment = NSTextAlignmentLeft;
    self.preferentialInfoLabel.adjustsFontSizeToFitWidth = YES;
    self.preferentialInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [costCountView addSubview:self.preferentialInfoLabel];
    
    UIView *lineView9 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 144.0f, 300.0f, 1.0f)];
    lineView9.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [costCountView addSubview:lineView9];
    
    self.couponButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 150.0f, 20.0f,20.0f)];
    [self.couponButton setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    [self.couponButton setBackgroundImage:[UIImage imageNamed:@"uncheck_selected"] forState:UIControlStateSelected];
    [self.couponButton addTarget:self action:@selector(couponsView:) forControlEvents:UIControlEventTouchUpInside];
    [costCountView addSubview:self.couponButton];
    
    self.couponLabel = [[UILabel alloc]initWithFrame:CGRectMake(35.0f, 144.0f, 275.0f, 32.0f)];
    self.couponLabel.text = @"优惠券抵扣运费";
    self.couponLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    self.couponLabel.font = [UIFont systemFontOfSize:14.0f];
    self.couponLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.couponLabel.numberOfLines = 1;
    self.couponLabel.textAlignment = NSTextAlignmentLeft;
    self.couponLabel.adjustsFontSizeToFitWidth = YES;
    self.couponLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    self.couponLabel.userInteractionEnabled = YES;
    [costCountView addSubview:self.couponLabel];
    
    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(couponsView:)];
    tap7.numberOfTapsRequired = 1;
    [self.couponLabel addGestureRecognizer:tap7];

    self.scoreButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 182.0f, 20.0f,20.0f)];
    [self.scoreButton setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    [self.scoreButton setBackgroundImage:[UIImage imageNamed:@"uncheck_selected"] forState:UIControlStateSelected];
    [self.scoreButton addTarget:self action:@selector(scoreView:) forControlEvents:UIControlEventTouchUpInside];
    [costCountView addSubview:self.scoreButton];
    
    self.scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(35.0f, 176.0f, 275.0f, 32.0f)];
    self.scoreLabel.text = @"积分抵扣运费";
    self.scoreLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    self.scoreLabel.font = [UIFont systemFontOfSize:14.0f];
    self.scoreLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.scoreLabel.numberOfLines = 1;
    self.scoreLabel.textAlignment = NSTextAlignmentLeft;
    self.scoreLabel.adjustsFontSizeToFitWidth = YES;
    self.scoreLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    self.scoreLabel.userInteractionEnabled = YES;
    [costCountView addSubview:self.scoreLabel];
    
    UITapGestureRecognizer *tap8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scoreView:)];
    tap8.numberOfTapsRequired = 1;
    [self.scoreLabel addGestureRecognizer:tap8];
    
    UILabel *allCostLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 5.0f, 50.0f, 40.0f)];
    allCostLabel.text = @"总计:";
    allCostLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    allCostLabel.font = [UIFont systemFontOfSize:14.0f];
    allCostLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    allCostLabel.numberOfLines = 1;
    allCostLabel.textAlignment = NSTextAlignmentLeft;
    allCostLabel.adjustsFontSizeToFitWidth = YES;
    allCostLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [payView addSubview:allCostLabel];
    
    self.allCostInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(50.0f, 5.0f, 170.0f, 40.0f)];
    self.allCostInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",0.00f];
    self.allCostInfoLabel.textColor = [UIColor colorWithRed:(253.0f/255.0f) green:(78.0f/255.0f) blue:(46.0f/255.0f) alpha:1.0f];
    self.allCostInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    self.allCostInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.allCostInfoLabel.numberOfLines = 1;
    self.allCostInfoLabel.textAlignment = NSTextAlignmentLeft;
    self.allCostInfoLabel.adjustsFontSizeToFitWidth = YES;
    self.allCostInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [payView addSubview:self.allCostInfoLabel];
    
    UIButton *payButton = [[UIButton alloc]initWithFrame:CGRectMake(235.0f, 10.0f, 75.0f,30.0f)];
    [payButton setBackgroundImage:[UIImage imageNamed:@"payBtn"] forState:UIControlStateNormal];
    [payButton setTitle:@"去支付" forState:UIControlStateNormal];
    payButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [payView addSubview:payButton];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.scrollViewHeight-TransparentBarHeight)];
    bgView.backgroundColor = [UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f];
    [self.scrollView insertSubview:bgView atIndex:0];
    
    /** 认证 **/
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    if([customer.verification isEqualToString:@"0"])
    {
        self.packagingValueLabel.text = [NSString stringWithFormat:@"经济打包方案 (+RMB 2.21)"];
        self.wayVaue.dabao = 1;
        self.wayVaue.dabaoValue = 2.21f;
        
        self.orderDealValueLabel.text = [NSString stringWithFormat:@"经济保障方案 (+RMB 4.80)"];
        self.wayVaue.dingdan = 1;
        self.wayVaue.dingdanValue = 4.80f;
        
        self.packageMaterialValueLabel.text = [NSString stringWithFormat:@"标准耗材 (+RMB 1.84)"];
        self.wayVaue.cailiao = 1;
        self.wayVaue.cailiaoValue = 1.84f;
    }
    /** /认证 **/

    [self refreshData];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,self.scrollViewHeight);
}

- (void)initPackageData
{
    if(self.way.packageList.count>0)
    {
        float wayWeight = 0.00f;
        int wayGoodsTypeCount = 0;
        NSString *orderIds = [NSString stringWithFormat:@""];
        int i = 0;
        for (Package *package in self.way.packageList)
        {
            if (i==0)
            {
                self.way.wayTitel = package.packageTitle;
            }
            
            package.packageIndex = [NSString stringWithFormat:@"订单No.%d",i+1];
            wayWeight = wayWeight + package.packageWeight;
            if ([package isKindOfClass:[BuyPackage class]])
            {
                wayGoodsTypeCount = wayGoodsTypeCount + ((BuyPackage *)package).packageGoodTypeCount;
            }
            else
            {
                wayGoodsTypeCount = wayGoodsTypeCount+1;
            }
            i++;
            
            if ([orderIds isEqualToString:@""])
            {
                orderIds = [NSString stringWithFormat:@"%@",package.packageNo];
            }
            else
            {
                orderIds = [NSString stringWithFormat:@"%@,%@",orderIds,package.packageNo];
            }
        }
        self.way.weight = wayWeight;
        self.way.wayGoodsTypeCount = wayGoodsTypeCount;
        
        self.wayVaue.allWeight = wayWeight;
        self.wayVaue.orderIds = [NSString stringWithFormat:@"%@",orderIds];
    }
}

- (void)refreshData
{
    float yunfeiInfo = 0.00f;
    float tariffInfo = 0.00f;
    float serviceInfo = 0.00f;
    float preferentialInfo = 0.00f;
    float allCostInfo = 0.00f;
    
    //运费
    if (self.wayVaue.firstWeight > 0.00f||self.wayVaue.firstFee >0.00f ||self.wayVaue.continueFee> 0.00f) {
        if(self.wayVaue.allWeight <= self.wayVaue.firstWeight)
        {
            yunfeiInfo = self.wayVaue.firstFee;
        }
        else
        {
            if(fmodf(self.wayVaue.allWeight,self.wayVaue.firstWeight) == 0.00f)
            {
                yunfeiInfo = self.wayVaue.firstFee + ((int)((self.wayVaue.allWeight-self.wayVaue.firstWeight)/self.wayVaue.continueWeight))*self.wayVaue.continueFee;
            }
            else
            {
                yunfeiInfo = self.wayVaue.firstFee + ((int)((self.wayVaue.allWeight-self.wayVaue.firstWeight)/self.wayVaue.continueWeight)+1)*self.wayVaue.continueFee;
            }
        }
    }
    self.wayVaue.freight = yunfeiInfo;
    
    //报关费
    tariffInfo = self.wayVaue.customsFee;
    
    //服务费
    serviceInfo = self.wayVaue.dabaoValue + self.wayVaue.dingdanValue + self.wayVaue.cailiaoValue + self.wayVaue.zengzhiValue;
    self.wayVaue.serverfee = serviceInfo;
    
    preferentialInfo = self.wayVaue.scoresValue + self.wayVaue.couponValue;
    
    allCostInfo = yunfeiInfo + tariffInfo + serviceInfo - preferentialInfo;
    self.wayVaue.totalFreight = allCostInfo;
    
    self.yunfeiInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",yunfeiInfo];
    self.tariffInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",tariffInfo];
    self.serviceInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",serviceInfo];
    self.preferentialInfoLabel.text = [NSString stringWithFormat:@"-￥%.2f",preferentialInfo];
    self.allCostInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",allCostInfo];
}

- (void)addAddress:(id)sender
{
    AddressAddViewController *addressAddViewController = [[AddressAddViewController alloc]initWithNibName:@"AddressAddViewController" bundle:nil];
    addressAddViewController.delegate = self;
    [self.navigationController pushViewController:addressAddViewController animated:YES];
}

- (void)pushAddressChooseView:(id)sender
{
    AddressChooseViewController *addressChooseViewController = [[AddressChooseViewController alloc]initWithNibName:@"AddressChooseViewController" bundle:nil];
    addressChooseViewController.delegate = self;
    [self.navigationController pushViewController:addressChooseViewController animated:YES];
}

- (void)pushWayConfirmPackageView:(id)sender
{
    WayConfirmPackageViewController *wayConfirmPackageViewController = [[WayConfirmPackageViewController alloc]initWithNibName:@"WayConfirmPackageViewController" bundle:nil];
    wayConfirmPackageViewController.way = self.way;
    [self.navigationController pushViewController:wayConfirmPackageViewController animated:YES];
}

- (void)pay:(id)sender
{
    if(self.wayVaue.addressId == 0)
    {
        [MBProgressHUD showError:@"请新增收货地址" toView:self.view];
        return;
    }
    
    if(self.wayVaue.deliveryId == 0 || [self.wayVaue.deliveryname isEqual:@""])
    {
        [MBProgressHUD showError:@"请选择运输方式" toView:self.view];
        return;
    }
    
    [self callCommitWayWebService];
}


- (void)couponsView:(id)sender
{
    if (self.couponButton.selected == NO)
    {
        CouponChooseViewController *couponChooseViewController = [[CouponChooseViewController alloc]initWithNibName:@"CouponChooseViewController" bundle:nil];
        couponChooseViewController.delegate = self;
        [self.navigationController pushViewController:couponChooseViewController animated:YES];
    }
    else
    {
        UIAlertView *isCancelCouponAlertView = [[UIAlertView alloc]initWithTitle:@"您确定取消使用该优惠券吗？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        isCancelCouponAlertView.tag = 0;
        [isCancelCouponAlertView show];
    }
}

- (void)scoreView:(id)sender
{
    if (self.scoreButton.selected == NO)
    {
        ScoreRecordUsedViewController *scoreRecordUsedViewController = [[ScoreRecordUsedViewController alloc]initWithNibName:@"ScoreRecordUsedViewController" bundle:nil];
        scoreRecordUsedViewController.delegate = self;
        [self.navigationController pushViewController:scoreRecordUsedViewController animated:YES];
    }
    else
    {
        UIAlertView *isCancelScoreAlertView = [[UIAlertView alloc]initWithTitle:@"您确定取消使用积分吗？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        isCancelScoreAlertView.tag = 1;
        [isCancelScoreAlertView show];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0)
    {
        if (buttonIndex == 1)
        {
            self.couponButton.selected = !self.couponButton.selected;
            self.couponLabel.text = @"优惠券抵扣运费";
        }
    }
    else
    {
        if (buttonIndex == 1)
        {
            self.scoreButton.selected = !self.scoreButton.selected;
            self.scoreLabel.text = @"积分抵扣运费";
        }
    }
}

- (void)deliveryTapped:(id)sender
{
    //通过选择的国家-确定区域-通过区域-选择快递 ［EMS、AIR运送敏感运单］
    DeliveryViewController *deliveryViewController = [[DeliveryViewController alloc]initWithNibName:@"DeliveryViewController" bundle:nil];
    deliveryViewController.delegate = self;
    deliveryViewController.selectedAreaId = (int)self.receviceAddressView.tag;
    deliveryViewController.isSensitive = self.isSensitive;
    [self.navigationController pushViewController:deliveryViewController animated:YES];
}

- (void)didFinishedReturn:(AddressAddViewController *)addressAddViewController
{
    [self callAddressListWebService];
    self.transportTypeLabel.text = [NSString stringWithFormat:@"选择物流公司或运输线路"];
    self.wayVaue.deliveryname = [NSString stringWithFormat:@""];
    self.wayVaue.deliveryId = 0;
}

- (void)didFinishedReturnChoose:(AddressChooseViewController *)addressChooseViewController
{
    [self callAddressListWebService];
    self.transportTypeLabel.text = [NSString stringWithFormat:@"选择物流公司或运输线路"];
    self.wayVaue.deliveryname = [NSString stringWithFormat:@""];
    self.wayVaue.deliveryId = 0;
}

- (void)didFinishedReturnDelivery:(Delivery *)selectedDelivery
{
    if (selectedDelivery)
    {
        self.transportTypeLabel.text = selectedDelivery.deliveryname;
        self.wayVaue.deliveryId = selectedDelivery.did;
        self.wayVaue.deliveryname = [NSString stringWithFormat:@"%@",selectedDelivery.deliveryname];
        
        self.wayVaue.firstWeight = selectedDelivery.first_weight;
        self.wayVaue.firstFee = selectedDelivery.fitst_fee;
        self.wayVaue.continueWeight = selectedDelivery.continue_weight;
        self.wayVaue.continueFee = selectedDelivery.continue_fee;
        self.wayVaue.customsFee = selectedDelivery.customs_fee;
        
        [self refreshData];
    }
}

- (void)didFinishedReturnCoupon:(Coupon *)selectedCoupon;
{
    self.couponButton.selected = !self.couponButton.selected;
    self.couponLabel.text = [NSString stringWithFormat:@"优惠券抵扣运费  -￥%.2f",(float)selectedCoupon.money];
    self.wayVaue.couponId = selectedCoupon.cid;
    self.wayVaue.couponValue = selectedCoupon.money;
    [self refreshData];
}

- (void)didFinishedReturnScoresValue:(float)scoresValue andScores:(int)scores
{
    self.scoreButton.selected = !self.scoreButton.selected;
    self.scoreLabel.text = [NSString stringWithFormat:@"积分抵扣运费  -￥%.2f",scoresValue];
    self.wayVaue.scoresValue = scoresValue;
    self.wayVaue.scores = scores;
    [self refreshData];
}


- (void)packagingTapped:(id)sender
{
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(@"请选择打包方案", nil)];
    
    /** 认证 **/
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    
    if([customer.verification isEqualToString:@"1"])
    {
        [actionSheet addButtonWithTitle:NSLocalizedString(@"认证用户免费体验经济打包方案", nil)
                                  image:[UIImage imageNamed:@"uncheck_selected"]
                                   type:AHKActionSheetButtonTypeDestructive
                                handler:^(AHKActionSheet *as) {
                                    self.packagingValueLabel.text = [NSString stringWithFormat:@"认证用户免费体验经济打包方案"];
                                    self.wayVaue.dabao = 0;
                                    self.wayVaue.dabaoValue = 0.00f;
                                    [self refreshData];
                                }];
    }
    /** /认证 **/


    [actionSheet addButtonWithTitle:NSLocalizedString(@"经济打包方案 (+RMB 2.21)", nil)
                              image:[UIImage imageNamed:@"uncheck"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                self.packagingValueLabel.text = [NSString stringWithFormat:@"经济打包方案 (+RMB 2.21)"];
                                self.wayVaue.dabao = 1;
                                self.wayVaue.dabaoValue = 2.21f;
                                [self refreshData];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"标准打包方案 (+RMB 3.69)", nil)
                              image:[UIImage imageNamed:@"uncheck"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                self.packagingValueLabel.text = [NSString stringWithFormat:@"标准打包方案 (+RMB 3.69)"];
                                self.wayVaue.dabao = 2;
                                self.wayVaue.dabaoValue = 3.69f;
                                [self refreshData];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"高级打包方案 (+RMB 6.15)", nil)
                              image:[UIImage imageNamed:@"uncheck"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                self.packagingValueLabel.text = [NSString stringWithFormat:@"高级打包方案 (+RMB 6.15)"];
                                self.wayVaue.dabao = 3;
                                self.wayVaue.dabaoValue = 6.15f;
                                [self refreshData];
                            }];
    
    [actionSheet show];
}

- (void)orderDealTapped:(id)sender
{
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(@"请选择订单处理方案", nil)];
    
    /** 认证 **/
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    
    if([customer.verification isEqualToString:@"1"])
    {
        [actionSheet addButtonWithTitle:NSLocalizedString(@"认证用户免费体验经济保障方案", nil)
                                  image:[UIImage imageNamed:@"uncheck_selected"]
                                   type:AHKActionSheetButtonTypeDestructive
                                handler:^(AHKActionSheet *as) {
                                    self.orderDealValueLabel.text = [NSString stringWithFormat:@"认证用户免费体验经济保障方案"];
                                    self.wayVaue.dingdan = 0;
                                    self.wayVaue.dingdanValue = 0.00f;
                                    [self refreshData];
                                }];
    }
    /** /认证 **/

    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"经济保障方案（＋RMB 4.80）", nil)
                              image:[UIImage imageNamed:@"uncheck"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                self.orderDealValueLabel.text = [NSString stringWithFormat:@"经济保障方案 (+RMB 4.80)"];
                                self.wayVaue.dingdan = 1;
                                self.wayVaue.dingdanValue = 4.80f;
                                [self refreshData];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"标准保障方案 (+RMB 7.26)", nil)
                              image:[UIImage imageNamed:@"uncheck"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                self.orderDealValueLabel.text = [NSString stringWithFormat:@"标准保障方案 (+RMB 7.26)"];
                                self.wayVaue.dingdan = 2;
                                self.wayVaue.dingdanValue = 7.26f;
                                [self refreshData];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"高级保障方案 (+RMB 8.49)", nil)
                              image:[UIImage imageNamed:@"uncheck"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                self.orderDealValueLabel.text = [NSString stringWithFormat:@"高级保障方案 (+RMB 8.49)"];
                                self.wayVaue.dingdan = 3;
                                self.wayVaue.dingdanValue = 8.49f;
                                [self refreshData];
                            }];
    
    [actionSheet show];
}

- (void)packageMaterialTapped:(id)sender
{
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(@"请选择包装材料", nil)];
    
    /** 认证 **/
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    
    if([customer.verification isEqualToString:@"1"])
    {
        [actionSheet addButtonWithTitle:NSLocalizedString(@"认证用户免费体验标准耗材", nil)
                                  image:[UIImage imageNamed:@"uncheck_selected"]
                                   type:AHKActionSheetButtonTypeDestructive
                                handler:^(AHKActionSheet *as) {
                                    self.packageMaterialValueLabel.text = [NSString stringWithFormat:@"认证用户免费体验标准耗材"];
                                    self.wayVaue.cailiao = 0;
                                    self.wayVaue.cailiaoValue = 0.00f;
                                    [self refreshData];
                                }];
    }
    /** /认证 **/
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"标准耗材 (+RMB 1.84)", nil)
                              image:[UIImage imageNamed:@"uncheck"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                self.packageMaterialValueLabel.text = [NSString stringWithFormat:@"标准耗材 (+RMB 1.84)"];
                                self.wayVaue.cailiao = 1;
                                self.wayVaue.cailiaoValue = 1.84f;
                                [self refreshData];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"坚固耗材 (+RMB 3.69)", nil)
                              image:[UIImage imageNamed:@"uncheck"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                self.packageMaterialValueLabel.text = [NSString stringWithFormat:@"坚固耗材 (+RMB 3.69)"];
                                self.wayVaue.cailiao = 2;
                                self.wayVaue.cailiaoValue = 3.69f;
                                [self refreshData];
                            }];
    [actionSheet show];
}

- (void)valueServiceTapped:(id)sender
{
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(@"请选择增值服务", nil)];
    actionSheet.cancelButtonTitle = @"取消";
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"免费提供客服支持,在线跟踪功能", nil)
                              image:[UIImage imageNamed:@"uncheck_selected"]
                               type:AHKActionSheetButtonTypeDestructive
                            handler:^(AHKActionSheet *as) {
                                self.valueServiceValueLabel.text = [NSString stringWithFormat:@"免费提供客服支持,在线跟踪功能"];
                                self.wayVaue.zengzhi = 0;
                                self.wayVaue.zengzhiValue = 0.00f;
                                [self refreshData];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"提供大包裹邮寄方案 (+RMB 1.50)", nil)
                              image:[UIImage imageNamed:@"uncheck"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                self.valueServiceValueLabel.text = [NSString stringWithFormat:@"提供大包裹邮寄方案 (+RMB 1.50)"];
                                self.wayVaue.zengzhi = 1;
                                self.wayVaue.zengzhiValue = 1.50f;
                                [self refreshData];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"为运单拍照 (+RMB 3.50)", nil)
                              image:[UIImage imageNamed:@"uncheck"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                self.valueServiceValueLabel.text = [NSString stringWithFormat:@"为运单拍照 (+RMB 3.50)"];
                                self.wayVaue.zengzhi = 2;
                                self.wayVaue.zengzhiValue = 3.50f;
                                [self refreshData];
                            }];
    
    [actionSheet show];
}

//备注名 textView
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}

- (void)textViewDidEndEditing:(UITextView *)textView;
{
    [textView resignFirstResponder];
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
    
    if (range.location > 100)//可以输入50个字符包括汉字
    {
        //控制输入文本的长度
        return  NO;
    }
    
    return YES;
}

/*****************************收货地址列表接口**********************************/
//获取收货地址列表接口
- (void)callAddressListWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/address/address_list"];
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
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableContainers error:nil];
        
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
            NSArray *result = [data objectForKey:@"result"];
            
            if (![self resolveAddressListJson:result])
            {
                request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
                request.hud.mode = MBProgressHUDModeCustomView;
                request.hud.removeFromSuperViewOnHide = YES;
                request.hud.labelText = @"解析失败";
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
    
    if ([request error])
    {
        request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
        request.hud.mode = MBProgressHUDModeCustomView;
        request.hud.removeFromSuperViewOnHide = YES;
        request.hud.labelText = @"网络异常";
        request.hud.detailsLabelText = @"请检查网络重试";
    }
}

- (BOOL)resolveAddressListJson:(NSArray *)result
{
    [self.addressList removeAllObjects];
    
    for(NSDictionary *addressDictionary in result)
    {
        Address *address = [[Address alloc]init];
        address.addressId = [[addressDictionary objectForKey:@"addressId"]intValue];
        address.recevicer = [addressDictionary objectForKey:@"recevicer"];
        address.telePhone = [addressDictionary objectForKey:@"telePhone"];
        address.areaId = [[addressDictionary objectForKey:@"areaid"]intValue];
        address.countryId = [[addressDictionary objectForKey:@"countryId"]intValue];
        address.provinceId = [[addressDictionary objectForKey:@"provinceId"]intValue];
        address.country = [addressDictionary objectForKey:@"country"];
        address.province = [addressDictionary objectForKey:@"province"];
        address.addressDetail = [addressDictionary objectForKey:@"addressDetail"];
        address.mailCode = [addressDictionary objectForKey:@"mailCode"];
        address.isDefault = [[addressDictionary objectForKey:@"isDefault"] intValue];
        if (address.isDefault)
        {
            [self.addressList insertObject:address atIndex:0];
        }
        else
        {
            [self.addressList addObject:address];
        }
    }
    
    for (UIView *view in self.receviceAddressView.subviews)
    {
        [view removeFromSuperview];
    }
    
    if (self.addressList.count == 0)
    {
        self.wayVaue.addressId = 0;//无收货地址
        UILabel *receviceAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 310.0f, 32.0f)];
        receviceAddressLabel.text = @"收货信息";
        receviceAddressLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        receviceAddressLabel.font = [UIFont systemFontOfSize:16.0f];
        receviceAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        receviceAddressLabel.numberOfLines = 1;
        receviceAddressLabel.textAlignment = NSTextAlignmentLeft;
        receviceAddressLabel.adjustsFontSizeToFitWidth = YES;
        receviceAddressLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.receviceAddressView addSubview:receviceAddressLabel];
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 32.0f, 300.0f, 1.0f)];
        lineView1.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
        [self.receviceAddressView addSubview:lineView1];
        
        UILabel *nullReceviceAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(50.0f, 65.0f, 150.0f, 30.0f)];
        nullReceviceAddressLabel.text = @"您无收货地址信息,请";
        nullReceviceAddressLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        nullReceviceAddressLabel.font = [UIFont systemFontOfSize:14.0f];
        nullReceviceAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        nullReceviceAddressLabel.numberOfLines = 1;
        nullReceviceAddressLabel.textAlignment = NSTextAlignmentCenter;
        nullReceviceAddressLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.receviceAddressView addSubview:nullReceviceAddressLabel];
        
        UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(200.0f, 65.0f, 50.0f,25.0f)];
        [addButton setBackgroundImage:[UIImage imageNamed:@"payBtn"] forState:UIControlStateNormal];
        [addButton setTitle:@"新增" forState:UIControlStateNormal];
        addButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
        [self.receviceAddressView addSubview:addButton];
    }
    else
    {
        Address *address = self.addressList[0];
        
        self.wayVaue.addressId = address.addressId;
        UILabel *receviceAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 310.0f, 32.0f)];
        receviceAddressLabel.text = @"收货信息";
        receviceAddressLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
        receviceAddressLabel.font = [UIFont systemFontOfSize:16.0f];
        receviceAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        receviceAddressLabel.numberOfLines = 1;
        receviceAddressLabel.textAlignment = NSTextAlignmentLeft;
        receviceAddressLabel.adjustsFontSizeToFitWidth = YES;
        receviceAddressLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.receviceAddressView addSubview:receviceAddressLabel];
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 32.0f, 300.0f, 1.0f)];
        lineView1.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
        [self.receviceAddressView addSubview:lineView1];
        
        UILabel *recevicerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 37.0f, 140.0f, 23.0f)];
        recevicerLabel.text = [NSString stringWithFormat:@"%@",address.recevicer];
        recevicerLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        recevicerLabel.font = [UIFont systemFontOfSize:15.0f];
        recevicerLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        recevicerLabel.numberOfLines = 1;
        recevicerLabel.textAlignment = NSTextAlignmentLeft;
        recevicerLabel.adjustsFontSizeToFitWidth = YES;
        recevicerLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.receviceAddressView addSubview:recevicerLabel];
        
        UILabel *telePhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(150.0f, 37.0f, 140.0f, 23.0f)];
        telePhoneLabel.text = [NSString stringWithFormat:@"%@",address.telePhone];
        telePhoneLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        telePhoneLabel.font = [UIFont systemFontOfSize:14.0f];
        telePhoneLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        telePhoneLabel.numberOfLines = 1;
        telePhoneLabel.textAlignment = NSTextAlignmentRight;
        telePhoneLabel.adjustsFontSizeToFitWidth = YES;
        telePhoneLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.receviceAddressView addSubview:telePhoneLabel];
        
        UILabel *addressDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 60.0f, 280.0f, 69.0f)];
        addressDetailLabel.text = [NSString stringWithFormat:@"%@, %@, %@, %@",address.addressDetail,address.province,address.country,address.mailCode];
        addressDetailLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        addressDetailLabel.font = [UIFont systemFontOfSize:14.0f];
        addressDetailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        addressDetailLabel.numberOfLines = 3;
        addressDetailLabel.textAlignment = NSTextAlignmentLeft;
        addressDetailLabel.adjustsFontSizeToFitWidth = YES;
        addressDetailLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.receviceAddressView addSubview:addressDetailLabel];
        
        UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(295.0f,60.0f, 10.0f, 17.0f)];
        [arrowImageView setImage:[UIImage imageNamed:@"arrow"]];
        [self.receviceAddressView addSubview:arrowImageView];
        
        self.receviceAddressView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushAddressChooseView:)];
        tap0.numberOfTapsRequired = 1;//不同的实体数目
        self.receviceAddressView.tag = address.areaId;
        [self.receviceAddressView addGestureRecognizer:tap0];
    }
    
    return YES;
}

/*****************************生成国际运单接口**********************************/
- (void)callCommitWayWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/guoji/submit"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kLongTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestCommitWayFailed:)];
    [request setDidFinishSelector:@selector(requestCommitWayFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    //  address_id,customerId,zengzhi,cailiao,dingdan,dabao,orderIds（订单编号逗号分隔）,deliveryname（快递名）,freight（运费）,total_freight（总价）,all_weight（总重）,serverfee（服务费）
    [param setValue:[NSString stringWithFormat:@"%d",self.wayVaue.addressId] forKey:@"address_id"];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];

//    打包策略：经济方案传0,标准1,高级2,免费3
//    订单处理：经济0,标准1,高级2,免费3
//    包装材料：标准0,坚固1
//    增值服务：免费0,提供大包裹1,拍照2
    
    [param setValue:[NSString stringWithFormat:@"%d",self.wayVaue.zengzhi] forKey:@"zengzhi"];
    [param setValue:[NSString stringWithFormat:@"%d",self.wayVaue.cailiao] forKey:@"cailiao"];
    [param setValue:[NSString stringWithFormat:@"%d",self.wayVaue.dingdan] forKey:@"dingdan"];
    [param setValue:[NSString stringWithFormat:@"%d",self.wayVaue.dabao] forKey:@"dabao"];
    
    [param setValue:[NSString stringWithFormat:@"%@",self.wayVaue.orderIds] forKey:@"orderIds"];
    [param setValue:[NSString stringWithFormat:@"%@",self.wayVaue.deliveryname] forKey:@"deliveryname"];
    [param setValue:[NSString stringWithFormat:@"%d",self.wayVaue.deliveryId] forKey:@"did"];
    
    [param setValue:[NSString stringWithFormat:@"%.2f",self.wayVaue.freight] forKey:@"freight"];
    [param setValue:[NSString stringWithFormat:@"%.2f",self.wayVaue.totalFreight] forKey:@"total_freight"];
    [param setValue:[NSString stringWithFormat:@"%.2f",self.wayVaue.allWeight] forKey:@"all_weight"];
    [param setValue:[NSString stringWithFormat:@"%.2f",self.wayVaue.serverfee] forKey:@"serverfee"];
    [param setValue:[NSString stringWithFormat:@"%@",self.remarkTextView.text] forKey:@"remark"];
    [param setValue:[NSString stringWithFormat:@"%d",self.wayVaue.scores] forKey:@"scoreuse"];
    [param setValue:[NSString stringWithFormat:@"%d",self.wayVaue.couponId] forKey:@"couponId"];
    
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    
    NSLog(@"paramJson = %@",paramJson);
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在提交";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
    
    [request startAsynchronous];//异步传输
}

- (void)requestCommitWayFinished:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSString *responseString = [request responseString];
        
        NSLog(@"responseString = %@",responseString);
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
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
            NSString *wayIdStr = [data objectForKey:@"data"];
            WayPayViewController *wayPayViewController = [[WayPayViewController alloc]initWithNibName:@"WayPayViewController" bundle:nil];
            wayPayViewController.wayIdStr = wayIdStr;
            wayPayViewController.inputType = 1;//进入方式:确认运单
            wayPayViewController.wayTotalCost = self.wayVaue.totalFreight;
            [self.navigationController pushViewController:wayPayViewController animated:YES];
        }
    }
}

- (void)requestCommitWayFailed:(ASIHTTPRequest *)request
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
