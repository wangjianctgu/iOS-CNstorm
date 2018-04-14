//
//  AwaitSendWayDetailViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-17.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "AwaitSendWayDetailViewController.h"

@interface AwaitSendWayDetailViewController ()

@end

@implementation AwaitSendWayDetailViewController

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
    self.navigationItem.title = @"待发货国际运单详情";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self initMyView];
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
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    [self.view addSubview:self.scrollView];
    
    UIView *wayStatusView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, MainScreenHeight-NavigationBarHeight-TransparentBarHeight, 320.0f, 50.0f)];
    wayStatusView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:wayStatusView];
    
    float packageViewHeight = 30.0f;
    UIView *packageView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 30.0f)];
    [self.scrollView addSubview:packageView];
    
    float goodsListTableViewHeight = self.way.packageList.count*30.0f + self.way.wayGoodsTypeCount*100.0f;//TableView section+cell的高度
    //商品列表TableView的加载
    self.goodsListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f,packageViewHeight,320.0f, goodsListTableViewHeight) style:UITableViewStylePlain];
    self.goodsListTableView.scrollEnabled = NO;
    self.goodsListTableView.delegate = self;
    self.goodsListTableView.dataSource = self;
    [self.scrollView addSubview:self.goodsListTableView];
    
    float receviceInfoViewHeight = 160.0f;
    UIView *receviceInfoView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, packageViewHeight+goodsListTableViewHeight,320.0f, receviceInfoViewHeight)];
    [self.scrollView addSubview:receviceInfoView];
    
    float wayInfoViewHeight = 150.0f;
    UIView *wayInfoView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, packageViewHeight+goodsListTableViewHeight+receviceInfoViewHeight, 320.0f, wayInfoViewHeight)];
    [self.scrollView addSubview:wayInfoView];
    
    self.scrollViewHeight = packageViewHeight+goodsListTableViewHeight+receviceInfoViewHeight+wayInfoViewHeight;
    
    UILabel *packageInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 320.0f, 30.0f)];
    packageInfoLabel.text = @"订单清单";
    packageInfoLabel.textColor = [UIColor darkGrayColor];
    packageInfoLabel.font = [UIFont systemFontOfSize:15.0f];
    packageInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    packageInfoLabel.numberOfLines = 1;
    packageInfoLabel.textAlignment = NSTextAlignmentLeft;
    packageInfoLabel.adjustsFontSizeToFitWidth = YES;
    packageInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [packageView addSubview:packageInfoLabel];
    
    UILabel *receviceInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 320.0f, 30.0f)];
    receviceInfoLabel.text = @"收货信息";
    receviceInfoLabel.textColor = [UIColor darkGrayColor];
    receviceInfoLabel.font = [UIFont systemFontOfSize:15.0f];
    receviceInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    receviceInfoLabel.numberOfLines = 1;
    receviceInfoLabel.textAlignment = NSTextAlignmentLeft;
    receviceInfoLabel.adjustsFontSizeToFitWidth = YES;
    receviceInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:receviceInfoLabel];
    
    UILabel *receviceAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 30.0f, 320.0f, 40.0f)];
    receviceAddressLabel.text = @"地   址:";
    receviceAddressLabel.textColor = [UIColor darkGrayColor];
    receviceAddressLabel.font = [UIFont systemFontOfSize:13.0f];
    receviceAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    receviceAddressLabel.numberOfLines = 1;
    receviceAddressLabel.textAlignment = NSTextAlignmentLeft;
    receviceAddressLabel.adjustsFontSizeToFitWidth = YES;
    receviceAddressLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:receviceAddressLabel];
    
    UILabel *receviceAddressInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 25.0f, 200.0f, 50.0f)];
    receviceAddressInfoLabel.text = self.way.receiveAddress;
    receviceAddressInfoLabel.textColor = [UIColor darkGrayColor];
    receviceAddressInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    receviceAddressInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    receviceAddressInfoLabel.numberOfLines = 3;
    receviceAddressInfoLabel.textAlignment = NSTextAlignmentLeft;
    receviceAddressInfoLabel.adjustsFontSizeToFitWidth = YES;
    receviceAddressInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:receviceAddressInfoLabel];
    
    UILabel *mailCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 70.0f, 320.0f, 30.0f)];
    mailCodeLabel.text = @"邮   编:";
    mailCodeLabel.textColor = [UIColor darkGrayColor];
    mailCodeLabel.font = [UIFont systemFontOfSize:13.0f];
    mailCodeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    mailCodeLabel.numberOfLines = 1;
    mailCodeLabel.textAlignment = NSTextAlignmentLeft;
    mailCodeLabel.adjustsFontSizeToFitWidth = YES;
    mailCodeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:mailCodeLabel];
    
    UILabel *mailCodeInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 70.0f, 200.0f, 30.0f)];
    mailCodeInfoLabel.text = self.way.mailCode;
    mailCodeInfoLabel.textColor = [UIColor darkGrayColor];
    mailCodeInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    mailCodeInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    mailCodeInfoLabel.numberOfLines = 1;
    mailCodeInfoLabel.textAlignment = NSTextAlignmentLeft;
    mailCodeInfoLabel.adjustsFontSizeToFitWidth = YES;
    mailCodeInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:mailCodeInfoLabel];
    
    UILabel *recevicerLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 100.0f, 320.0f, 30.0f)];
    recevicerLabel.text = @"收货人:";
    recevicerLabel.textColor = [UIColor darkGrayColor];
    recevicerLabel.font = [UIFont systemFontOfSize:13.0f];
    recevicerLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    recevicerLabel.numberOfLines = 1;
    recevicerLabel.textAlignment = NSTextAlignmentLeft;
    recevicerLabel.adjustsFontSizeToFitWidth = YES;
    recevicerLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:recevicerLabel];
    
    UILabel *recevicerInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 100.0f, 200.0f, 30.0f)];
    recevicerInfoLabel.text = self.way.receiver;
    recevicerInfoLabel.textColor = [UIColor darkGrayColor];
    recevicerInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    recevicerInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    recevicerInfoLabel.numberOfLines = 1;
    recevicerInfoLabel.textAlignment = NSTextAlignmentLeft;
    recevicerInfoLabel.adjustsFontSizeToFitWidth = YES;
    recevicerInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:recevicerInfoLabel];
    
    UILabel *telePhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 130.0f, 320.0f, 30.0f)];
    telePhoneLabel.text = @"电   话:";
    telePhoneLabel.textColor = [UIColor darkGrayColor];
    telePhoneLabel.font = [UIFont systemFontOfSize:13.0f];
    telePhoneLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    telePhoneLabel.numberOfLines = 1;
    telePhoneLabel.textAlignment = NSTextAlignmentLeft;
    telePhoneLabel.adjustsFontSizeToFitWidth = YES;
    telePhoneLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:telePhoneLabel];
    
    UILabel *telePhoneInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 130.0f, 200.0f, 30.0f)];
    telePhoneInfoLabel.text = self.way.telePhone;
    telePhoneInfoLabel.textColor = [UIColor darkGrayColor];
    telePhoneInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    telePhoneInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    telePhoneInfoLabel.numberOfLines = 1;
    telePhoneInfoLabel.textAlignment = NSTextAlignmentLeft;
    telePhoneInfoLabel.adjustsFontSizeToFitWidth = YES;
    telePhoneInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [receviceInfoView addSubview:telePhoneInfoLabel];
    
    UILabel *wayInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 320.0f, 30.0f)];
    wayInfoLabel.text = @"运单信息";
    wayInfoLabel.textColor = [UIColor darkGrayColor];
    wayInfoLabel.font = [UIFont systemFontOfSize:15.0f];
    wayInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    wayInfoLabel.numberOfLines = 1;
    wayInfoLabel.textAlignment = NSTextAlignmentLeft;
    wayInfoLabel.adjustsFontSizeToFitWidth = YES;
    wayInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:wayInfoLabel];
    
    UILabel *weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 30.0f, 320.0f, 30.0f)];
    weightLabel.text = @"实际重量:";
    weightLabel.textColor = [UIColor darkGrayColor];
    weightLabel.font = [UIFont systemFontOfSize:13.0f];
    weightLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    weightLabel.numberOfLines = 1;
    weightLabel.textAlignment = NSTextAlignmentLeft;
    weightLabel.adjustsFontSizeToFitWidth = YES;
    weightLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:weightLabel];
    
    UILabel *weightLabelInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 30.0f, 200.0f, 30.0f)];
    weightLabelInfoLabel.text = [NSString stringWithFormat:@"%.2fg",self.way.weight];
    weightLabelInfoLabel.textColor = [UIColor darkGrayColor];
    weightLabelInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    weightLabelInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    weightLabelInfoLabel.numberOfLines = 1;
    weightLabelInfoLabel.textAlignment = NSTextAlignmentLeft;
    weightLabelInfoLabel.adjustsFontSizeToFitWidth = YES;
    weightLabelInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:weightLabelInfoLabel];
    
    UILabel *volumeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 60.0f, 320.0f, 30.0f)];
    volumeLabel.text = @"体积重量:";
    volumeLabel.textColor = [UIColor darkGrayColor];
    volumeLabel.font = [UIFont systemFontOfSize:13.0f];
    volumeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    volumeLabel.numberOfLines = 1;
    volumeLabel.textAlignment = NSTextAlignmentLeft;
    volumeLabel.adjustsFontSizeToFitWidth = YES;
    volumeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:volumeLabel];
    
    UILabel *volumeInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 60.0f, 200.0f, 30.0f)];
    volumeInfoLabel.text = [NSString stringWithFormat:@"%.2fg",self.way.volume];
    volumeInfoLabel.textColor = [UIColor darkGrayColor];
    volumeInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    volumeInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    volumeInfoLabel.numberOfLines = 1;
    volumeInfoLabel.textAlignment = NSTextAlignmentLeft;
    volumeInfoLabel.adjustsFontSizeToFitWidth = YES;
    volumeInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:volumeInfoLabel];
    
    UILabel *wayNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 90.0f, 320.0f, 30.0f)];
    wayNoLabel.text = @"运单编号:";
    wayNoLabel.textColor = [UIColor darkGrayColor];
    wayNoLabel.font = [UIFont systemFontOfSize:13.0f];
    wayNoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    wayNoLabel.numberOfLines = 1;
    wayNoLabel.textAlignment = NSTextAlignmentLeft;
    wayNoLabel.adjustsFontSizeToFitWidth = YES;
    wayNoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:wayNoLabel];
    
    UILabel *wayNoInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 90.0f, 200.0f, 30.0f)];
    wayNoInfoLabel.text = self.way.wayNo;
    wayNoInfoLabel.textColor = [UIColor darkGrayColor];
    wayNoInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    wayNoInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    wayNoInfoLabel.numberOfLines = 1;
    wayNoInfoLabel.textAlignment = NSTextAlignmentLeft;
    wayNoInfoLabel.adjustsFontSizeToFitWidth = YES;
    wayNoInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:wayNoInfoLabel];
    
    UILabel *wayDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 120.0f, 320.0f, 30.0f)];
    wayDateLabel.text = @"日   期:";
    wayDateLabel.textColor = [UIColor darkGrayColor];
    wayDateLabel.font = [UIFont systemFontOfSize:13.0f];
    wayDateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    wayDateLabel.numberOfLines = 1;
    wayDateLabel.textAlignment = NSTextAlignmentLeft;
    wayDateLabel.adjustsFontSizeToFitWidth = YES;
    wayDateLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:wayDateLabel];
    
    UILabel *wayDateInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 120.0f, 200.0f, 30.0f)];
    wayDateInfoLabel.text = self.way.wayDate;
    wayDateInfoLabel.textColor = [UIColor darkGrayColor];
    wayDateInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    wayDateInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    wayDateInfoLabel.numberOfLines = 1;
    wayDateInfoLabel.textAlignment = NSTextAlignmentLeft;
    wayDateInfoLabel.adjustsFontSizeToFitWidth = YES;
    wayDateInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayInfoView addSubview:wayDateInfoLabel];
    
    UILabel *yunfeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 10.0f, 200.0f, 30.0f)];
    yunfeiLabel.text = [NSString stringWithFormat:@"运费:￥%.2f",self.way.yunfei];
    yunfeiLabel.textColor = [UIColor darkGrayColor];
    yunfeiLabel.font = [UIFont systemFontOfSize:15.0f];
    yunfeiLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    yunfeiLabel.numberOfLines = 1;
    yunfeiLabel.textAlignment = NSTextAlignmentLeft;
    yunfeiLabel.adjustsFontSizeToFitWidth = YES;
    yunfeiLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayStatusView addSubview:yunfeiLabel];
    
    NSString *wayStatusButtonTitle = nil;
    
    if (self.way.wayStatus ==0)
    {
        wayStatusButtonTitle = @"待发货";
    }
    else
    {
        wayStatusButtonTitle = @"已发货";
    }
    
    UIButton *wayStatusButton = [[UIButton alloc]initWithFrame:CGRectMake(220.0f, 10.0f, 100.0f, 30.0f)];
    wayStatusButton.backgroundColor = [UIColor darkGrayColor];
    [wayStatusButton setTitle:wayStatusButtonTitle forState:UIControlStateNormal];
    [wayStatusView addSubview:wayStatusButton];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,self.scrollViewHeight);
}

//设置SectionHeader高度:
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
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
    BuyPackage *buyPackage = (BuyPackage *)self.way.packageList[section];
    return buyPackage.goodsList.count;//每个订单，只显示1件商品
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0.0f, 0, 320, 30)];//创建一个视图
    Package *package = (Package *)self.way.packageList[section];
    headerView.textLabel.text = package.packageIndex;
    headerView.textLabel.textColor = [UIColor lightGrayColor];
    
    return headerView;
}


#pragma mark - 方法:cell的加载和复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *AwaitSendWayDetailTableViewCellIdentifier = @"AwaitSendWayDetailTableViewCellIdentifier";
    
    AwaitSendWayDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AwaitSendWayDetailTableViewCellIdentifier];
    
    if (cell==nil)
    {
        cell = [[AwaitSendWayDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AwaitSendWayDetailTableViewCellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    BuyPackage *buyPackage = (BuyPackage *)self.way.packageList[indexPath.section];
    cell.goods = buyPackage.goodsList[indexPath.row];
    
    return cell;
}

@end
