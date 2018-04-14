//
//  WayConfirmPackageViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "WayConfirmPackageViewController.h"

@interface WayConfirmPackageViewController ()

@end

@implementation WayConfirmPackageViewController

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
    
    self.navigationItem.title = @"订单/商品清单";
    
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
    
    float goodsListTableViewHeight = self.way.packageList.count*37.5f + self.way.wayGoodsTypeCount*100.0f;//TableView section+cell的高度
    
    //商品列表TableView的加载
    self.goodsListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f,0.0f,MainScreenWidth, goodsListTableViewHeight) style:UITableViewStylePlain];
    self.goodsListTableView.scrollEnabled = NO;
    self.goodsListTableView.delegate = self;
    self.goodsListTableView.dataSource = self;
    [self.scrollView addSubview:self.goodsListTableView];
    
    self.scrollViewHeight = goodsListTableViewHeight;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth,self.scrollViewHeight);
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
    Package *package = (Package *)self.way.packageList[section];
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
    Package *package = (Package *)self.way.packageList[section];
    
    AllOrderDetailHeaderView *headerView = [[AllOrderDetailHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 37.5f)];//创建一个视图
    headerView.headerLabel.text = [NSString stringWithFormat:@"%@",package.packageIndex];
    return headerView;
}

#pragma mark - 方法:cell的加载和复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Package *package = (Package *)self.way.packageList[indexPath.section];
    if ([package isKindOfClass:[BuyPackage class]])
    {
        static NSString *WayConfirmBuyPackageTableViewCellIdentifier = @"WayConfirmBuyPackageTableViewCellIdentifier";
        
        WayConfirmBuyPackageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WayConfirmBuyPackageTableViewCellIdentifier];
        
        if (cell==nil)
        {
            cell = [[WayConfirmBuyPackageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WayConfirmBuyPackageTableViewCellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.goods = ((BuyPackage *)package).goodsList[indexPath.row];
        
        return cell;
    }
    else
    {
        static NSString *WayConfirmSelfPackageTableViewCellIdentifier = @"WayConfirmSelfPackageTableViewCellIdentifier";
        
        WayConfirmSelfPackageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WayConfirmSelfPackageTableViewCellIdentifier];
        
        if (cell == nil)
        {
            cell = [[WayConfirmSelfPackageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WayConfirmSelfPackageTableViewCellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//点击选中时的颜色类型
        
        cell.selfPackage = (SelfPackage *)package;
        
        return cell;
    }
}

@end
