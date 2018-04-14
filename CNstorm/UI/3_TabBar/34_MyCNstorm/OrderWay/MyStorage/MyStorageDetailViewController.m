//
//  MyStorageDetailViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-17.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "MyStorageDetailViewController.h"

@interface MyStorageDetailViewController ()

@end

@implementation MyStorageDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.package = [[Package alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    
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
    [self.view addSubview:self.scrollView];
    
    float goodsHeadViewHeight = 37.5f;
    UIView *goodsView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, goodsHeadViewHeight)];
    [self.scrollView addSubview:goodsView];
    
    float goodsViewHeight = 0.0f;
    if ([self.package isKindOfClass:[BuyPackage class]])
    {
        BuyPackage *buyPackage = (BuyPackage *)self.package;
        goodsViewHeight = buyPackage.goodsList.count*100.0f;
        //商品列表TableView的加载
        self.goodsListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f,goodsHeadViewHeight,MainScreenWidth, goodsViewHeight) style:UITableViewStylePlain];
        self.goodsListTableView.scrollEnabled = NO;
        self.goodsListTableView.delegate = self;
        self.goodsListTableView.dataSource = self;
        [self.scrollView addSubview:self.goodsListTableView];
    }
    else
    {
        SelfPackage *selfPackage = (SelfPackage *)self.package;

        goodsViewHeight = 90.0f;
        UIView *packageRemarkView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, goodsHeadViewHeight, 320.0f, goodsViewHeight)];
        [self.scrollView addSubview:packageRemarkView];
        
        UILabel *packageTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 0.0f, 280.0f, 30.0f)];
        packageTitleLabel.text = [NSString stringWithFormat:@"名称:%@",selfPackage.packageTitle];
        packageTitleLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:(1.0f)];
        packageTitleLabel.font = [UIFont systemFontOfSize:14.0f];
        packageTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        packageTitleLabel.numberOfLines = 1;
        packageTitleLabel.textAlignment = NSTextAlignmentLeft;
        packageTitleLabel.adjustsFontSizeToFitWidth = YES;
        packageTitleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [packageRemarkView addSubview:packageTitleLabel];
        
        MyLabel *packageRemarkInfoLabel = [[MyLabel alloc]initWithFrame:CGRectMake(20.0f, 30.0f, 280.0f, 60.0f)];
        packageRemarkInfoLabel.text = [NSString stringWithFormat:@"备注:%@",selfPackage.packageRemark];
        packageRemarkInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:(1.0f)];
        packageRemarkInfoLabel.font = [UIFont systemFontOfSize:13.0f];
        packageRemarkInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        packageRemarkInfoLabel.numberOfLines = 3;
        packageRemarkInfoLabel.textAlignment = NSTextAlignmentLeft;
        [packageRemarkInfoLabel setVerticalAlignment:VerticalAlignmentTop];
        packageRemarkInfoLabel.adjustsFontSizeToFitWidth = YES;
        packageRemarkInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [packageRemarkView addSubview:packageRemarkInfoLabel];
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 89.0f, 320.0f, 1.0f)];
        lineView1.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
        [packageRemarkView addSubview:lineView1];
    }
    
    //订单信息视图
    float packageInfoViewHeight = 150.0f;
    UIView *packageInfoView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, goodsHeadViewHeight + goodsViewHeight,320.0f,packageInfoViewHeight)];
    [self.scrollView addSubview:packageInfoView];
    
    self.scrollViewHeight = goodsHeadViewHeight+goodsViewHeight +packageInfoViewHeight;
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 36.0f, 300.0f, 1.0f)];
    lineView2.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [goodsView addSubview:lineView2];
    
    UILabel *goodsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 37.5f)];
    goodsLabel.text = @"订单清单";
    goodsLabel.font = [UIFont systemFontOfSize:15.0];
    goodsLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:(1.0f)];
    goodsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    goodsLabel.numberOfLines = 1;
    goodsLabel.textAlignment = NSTextAlignmentLeft;
    goodsLabel.adjustsFontSizeToFitWidth = YES;
    goodsLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [goodsView addSubview:goodsLabel];

    UILabel *packageInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 320.0f, 30.0f)];
    packageInfoLabel.text = @"订单信息";
    packageInfoLabel.font = [UIFont systemFontOfSize:15.0f];
    packageInfoLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:(1.0f)];
    packageInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    packageInfoLabel.numberOfLines = 1;
    packageInfoLabel.textAlignment = NSTextAlignmentLeft;
    packageInfoLabel.adjustsFontSizeToFitWidth = YES;
    packageInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [packageInfoView addSubview:packageInfoLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 30.0f, 300.0f, 1.0f)];
    lineView3.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [packageInfoView addSubview:lineView3];
    
    UILabel *isSensitiveLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 60.0f, 70.0f, 30.0f)];
    isSensitiveLabel.text = @"敏感品:";
    isSensitiveLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:(1.0f)];
    isSensitiveLabel.font = [UIFont systemFontOfSize:14.0f];
    isSensitiveLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    isSensitiveLabel.numberOfLines = 1;
    isSensitiveLabel.textAlignment = NSTextAlignmentLeft;
    isSensitiveLabel.adjustsFontSizeToFitWidth = YES;
    isSensitiveLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [packageInfoView addSubview:isSensitiveLabel];
    
    UILabel *isSensitiveInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 60.0f, 200.0f, 30.0f)];
    isSensitiveInfoLabel.text = @"否";
    if (self.package.isSensitive)
    {
        isSensitiveInfoLabel.text = @"是";
    }
    isSensitiveInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:(1.0f)];
    isSensitiveInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    isSensitiveInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    isSensitiveInfoLabel.numberOfLines = 1;
    isSensitiveInfoLabel.textAlignment = NSTextAlignmentLeft;
    isSensitiveInfoLabel.adjustsFontSizeToFitWidth = YES;
    isSensitiveInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [packageInfoView addSubview:isSensitiveInfoLabel];
    
    UILabel *packageNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 30.0f, 70.0f, 30.0f)];
    packageNoLabel.text = @"订单编号:";
    packageNoLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:(1.0f)];
    packageNoLabel.font = [UIFont systemFontOfSize:14.0f];
    packageNoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    packageNoLabel.numberOfLines = 1;
    packageNoLabel.textAlignment = NSTextAlignmentLeft;
    packageNoLabel.adjustsFontSizeToFitWidth = YES;
    packageNoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [packageInfoView addSubview:packageNoLabel];
    
    UILabel *packageNoInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 30.0f, 200.0f, 30.0f)];
    packageNoInfoLabel.text = self.package.packageNo;
    packageNoInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:(1.0f)];
    packageNoInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    packageNoInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    packageNoInfoLabel.numberOfLines = 1;
    packageNoInfoLabel.textAlignment = NSTextAlignmentLeft;
    packageNoInfoLabel.adjustsFontSizeToFitWidth = YES;
    packageNoInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [packageInfoView addSubview:packageNoInfoLabel];
    
    UILabel *packageWeightLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 90.0f, 70.0f, 30.0f)];
    packageWeightLabel.text = @"订单重量:";
    packageWeightLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:(1.0f)];
    packageWeightLabel.font = [UIFont systemFontOfSize:14.0f];
    packageWeightLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    packageWeightLabel.numberOfLines = 1;
    packageWeightLabel.textAlignment = NSTextAlignmentLeft;
    packageWeightLabel.adjustsFontSizeToFitWidth = YES;
    packageWeightLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [packageInfoView addSubview:packageWeightLabel];
    
    UILabel *packageWeightInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 90.0f, 200.0f, 30.0f)];
    packageWeightInfoLabel.text = [NSString stringWithFormat:@"%.2fg", self.package.packageWeight ];
    packageWeightInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:(1.0f)];
    packageWeightInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    packageWeightInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    packageWeightInfoLabel.numberOfLines = 1;
    packageWeightInfoLabel.textAlignment = NSTextAlignmentLeft;
    packageWeightInfoLabel.adjustsFontSizeToFitWidth = YES;
    packageWeightInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [packageInfoView addSubview:packageWeightInfoLabel];
    
    UILabel *packageDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 120.0f, 70.0f, 30.0f)];
    packageDateLabel.text = @"入库时间:";
    packageDateLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:(1.0f)];
    packageDateLabel.font = [UIFont systemFontOfSize:14.0f];
    packageDateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    packageDateLabel.numberOfLines = 1;
    packageDateLabel.textAlignment = NSTextAlignmentLeft;
    packageDateLabel.adjustsFontSizeToFitWidth = YES;
    packageDateLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [packageInfoView addSubview:packageDateLabel];
    
    UILabel *packageDateInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 120.0f, 200.0f, 30.0f)];
    packageDateInfoLabel.text = self.package.packageDate;
    packageDateInfoLabel.textColor = [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:(1.0f)];
    packageDateInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    packageDateInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    packageDateInfoLabel.numberOfLines = 1;
    packageDateInfoLabel.textAlignment = NSTextAlignmentLeft;
    packageDateInfoLabel.adjustsFontSizeToFitWidth = YES;
    packageDateInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [packageInfoView addSubview:packageDateInfoLabel];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,self.scrollViewHeight);
}

//设置SectionHeader高度:
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
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
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - UITableViewDelegate TableView委托
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BuyPackage *buyPackage = (BuyPackage *)self.package;
    
    //判断dataSouce的数据个数,如果为零可以隐藏分割线
    if (buyPackage.goodsList.count == 0)
    {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else
    {
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return buyPackage.goodsList.count;
}

#pragma mark - 方法:cell的加载和复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyStorageDetailTableViewCellIdentifier = @"MyStorageDetailTableViewCellIdentifier";
    
    MyStorageDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyStorageDetailTableViewCellIdentifier];
    
    if (cell==nil)
    {
        cell = [[MyStorageDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyStorageDetailTableViewCellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    BuyPackage *buyPackage = (BuyPackage *)self.package;
    cell.goods = buyPackage.goodsList[indexPath.row];
    return cell;
}

@end
