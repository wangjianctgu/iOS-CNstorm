//
//  MyStorageViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-16.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "MyStorageViewController.h"

NSString *const BuyPackageTableViewCellIdentifier = @"BuyPackageTableViewCellIdentifier";
NSString *const SelfPackageTableViewCellIdentifier = @"SelfPackageTableViewCellIdentifier";

@interface MyStorageViewController ()
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@end

@implementation MyStorageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.packageList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我的仓库";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self initMyView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    BadgeKeyValue *badgeKeyValue = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:[NSString stringWithFormat:@"%lld",customer.customerid]]];
    badgeKeyValue.tabBadge4 = badgeKeyValue.tabBadge4 - badgeKeyValue.myStorageBadge;
    badgeKeyValue.myStorageBadge = 0;
    [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:badgeKeyValue] forKey:[NSString stringWithFormat:@"%lld",customer.customerid]];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
    [self initTableView];
    
    UIView *transparentBarView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,MainScreenHeight-NavigationBarHeight-TransparentBarHeight,MainScreenWidth,TransparentBarHeight)];
    transparentBarView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.9f];
    transparentBarView.layer.borderWidth = 0.5f;
    transparentBarView.layer.borderColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:1].CGColor;
    [self.view addSubview:transparentBarView];
    
    //全选/全不选  总重量 提交（全部提交/部分提交）默认全不选
    self.isAllSelected = NO;
    self.allSelectedButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 15.0f, 20.0f, 20.0f)];
    [self.allSelectedButton setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    [self.allSelectedButton setImage:[UIImage imageNamed:@"uncheck_selected"] forState:UIControlStateSelected];
    self.allSelectedButton.selected = self.isAllSelected;
    [self.allSelectedButton addTarget:self action:@selector(selectedAll:) forControlEvents:UIControlEventTouchUpInside];
    [transparentBarView addSubview:self.allSelectedButton];
    
    UILabel *allSelectedLabel = [[UILabel alloc]initWithFrame:CGRectMake(30.0f, 0.0f,35.0f, 50.0f)];
    allSelectedLabel.text = [NSString stringWithFormat:@"全选"];
    allSelectedLabel.textAlignment = NSTextAlignmentCenter;
    allSelectedLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1];
    allSelectedLabel.font = [UIFont systemFontOfSize:14.0f];
    allSelectedLabel.userInteractionEnabled = YES;
    [transparentBarView addSubview:allSelectedLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAll:)];
    tap.numberOfTapsRequired = 1;
    [allSelectedLabel addGestureRecognizer:tap];
    
    //合计
    UILabel *totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(70.0f, 0.0f, 45.0f, 50.0f)];
    totalLabel.text = [NSString stringWithFormat:@"总重:"];
    totalLabel.textAlignment = NSTextAlignmentCenter;
    totalLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1];
    totalLabel.font = [UIFont systemFontOfSize:14.0f];
    [transparentBarView addSubview:totalLabel];
    
    //总计重量
    self.totalWeight = 0.00;
    self.totalWeightLabel = [[UILabel alloc]initWithFrame:CGRectMake(115.0f, 10.0f, 110.0f, 30.0f)];
    self.totalWeightLabel.text = [NSString stringWithFormat:@"%.2fg",self.totalWeight];
    self.totalWeightLabel.textAlignment = NSTextAlignmentLeft;
    self.totalWeightLabel.textColor = [UIColor colorWithRed:(253.0f)/255.0f green:(78.0f)/255.0f blue:(46.0f)/255.0f alpha:1];
    self.totalWeightLabel.font = [UIFont systemFontOfSize:14.0f];
    self.totalWeightLabel.numberOfLines = 2;
    [transparentBarView addSubview:self.totalWeightLabel];
    
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(230.0f, 10.0f, 75.0f,30.0f)];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [commitButton.layer setCornerRadius:3.0f];
    commitButton.layer.borderWidth = 0.5f;
    commitButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [commitButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [transparentBarView addSubview:commitButton];
}

//点击全选按钮
- (void)selectedAll:(id)sender
{
    //改变选择数据
    //self.isAllSelected = !self.isAllSelected;
    for(Package *package in self.packageList)
    {
        package.isSelected = !self.isAllSelected;
    }
    
    [self refreshDataAndView];
}

- (void)refreshDataAndView
{
    //获取新的数据data
    float totalWeight = 0.0f;
    for(Package *package in self.packageList)
    {
        if (package.isSelected)
        {
            totalWeight = totalWeight+package.packageWeight;
        }
    }
    self.totalWeight = totalWeight;
    
    BOOL isAllSelected = YES;
    for (Package *package in self.packageList)
    {
        isAllSelected = isAllSelected && package.isSelected;
    }
    self.isAllSelected = isAllSelected;
    
    //刷新tableView
    [self.packageTableView reloadData];
    
    self.allSelectedButton.selected = self.isAllSelected;
    
    self.totalWeightLabel.text = [NSString stringWithFormat:@"%.2fg",self.totalWeight];
}

//提交
- (void)commit:(id)sender
{
    NSMutableArray *selectedPackageList = [NSMutableArray arrayWithCapacity:0];
    for (Package *packageItem in self.packageList)
    {
        if (packageItem.isSelected)
        {
            if ([packageItem isKindOfClass:[BuyPackage class]])
            {
                BuyPackage *buyPackageItem = (BuyPackage *)packageItem;
                BuyPackage *selectedPackage = [[BuyPackage alloc]init];
                selectedPackage.goodsList = [buyPackageItem.goodsList mutableCopy];//深copy
                selectedPackage.packageGoodTypeCount = buyPackageItem.packageGoodTypeCount;
                selectedPackage.packageNo = buyPackageItem.packageNo;
                selectedPackage.packageIndex = buyPackageItem.packageIndex;
                selectedPackage.packageTitle = buyPackageItem.packageTitle;
                selectedPackage.packageWeight = buyPackageItem.packageWeight;
                selectedPackage.isSensitive = buyPackageItem.isSensitive;
                selectedPackage.isSelected = buyPackageItem.isSelected;
                selectedPackage.packageDate = buyPackageItem.packageDate;
                selectedPackage.packageType = buyPackageItem.packageType;
                
                [selectedPackageList addObject:selectedPackage];
            }
            else
            {
                SelfPackage *selfPackageItem = (SelfPackage *)packageItem;
                SelfPackage *selectedPackage = [[SelfPackage alloc]init];
                
                selectedPackage.packageRemark = selfPackageItem.packageRemark;
                selectedPackage.packageNo = selfPackageItem.packageNo;
                selectedPackage.packageIndex = selfPackageItem.packageIndex;
                selectedPackage.packageTitle = selfPackageItem.packageTitle;
                selectedPackage.packageWeight = selfPackageItem.packageWeight;
                selectedPackage.isSensitive = selfPackageItem.isSensitive;
                selectedPackage.isSelected = selfPackageItem.isSelected;
                selectedPackage.packageDate = selfPackageItem.packageDate;
                selectedPackage.packageType = selfPackageItem.packageType;
                
                [selectedPackageList addObject:selectedPackage];
            }
        }
    }

    int isSensitiveCount = 0;
    if (selectedPackageList.count == 0)
    {
        [MBProgressHUD showError:@"请选择一个订单" toView:self.view];
        return;
    }
    else
    {
        for (Package *packageItem in selectedPackageList)
        {
            if (packageItem.isSensitive)
            {
                isSensitiveCount = isSensitiveCount + 1;
            }
        }
    }

    if (isSensitiveCount == 0||(isSensitiveCount == selectedPackageList.count))
    {
        //没有敏感订单，则运单类型为非敏感运单、敏感订单，则运单类型为敏感运单
        WayConfirmViewController *wayConfirmViewController = [[WayConfirmViewController alloc]initWithNibName:@"WayConfirmViewController" bundle:nil];
        wayConfirmViewController.way.packageList = selectedPackageList;
        if (isSensitiveCount == 0)
        {
            wayConfirmViewController.isSensitive = 1;
        }
        else
        {
            wayConfirmViewController.isSensitive = 2;
        }
        [self.navigationController pushViewController:wayConfirmViewController animated:YES];
    }
    else
    {
       [MBProgressHUD showError:@"非敏感和敏感订单请分开提交" toView:self.view];
    }
}

- (void)initTableView
{
    //国际运单TableView的加载
    self.packageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,MainScreenWidth,MainScreenHeight-NavigationBarHeight) style:UITableViewStylePlain];
    self.packageTableView.delegate = self;
    self.packageTableView.dataSource = self;
    self.packageTableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.packageTableView];
    
    // 1.注册
    [self.packageTableView registerClass:[BuyPackageTableViewCell class] forCellReuseIdentifier:BuyPackageTableViewCellIdentifier];
    [self.packageTableView registerClass:[SelfPackageTableViewCell class] forCellReuseIdentifier:SelfPackageTableViewCellIdentifier];
    
    //集成刷新控件
    //下拉刷新
    [self addHeader];
    
    //上拉加载更多
    [self addFooter];
}

- (void)addHeader
{
    __unsafe_unretained MyStorageViewController *myStorageViewController = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.scrollView = self.packageTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        // 调用获取所有运单列表接口，获取数据
        self.downUp = 0;
        self.value = 1;
        [self callPackageListWebService];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [myStorageViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 刷新完毕就会回调这个Block
        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state)
    {
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
                NSLog(@"%@----切换到:普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                NSLog(@"%@----切换到:松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                NSLog(@"%@----切换到:正在刷新状态", refreshView.class);
                break;
            default:
                break;
        }
    };
    
    [header beginRefreshing];
    
    _header = header;
}

- (void)addFooter
{
    __unsafe_unretained MyStorageViewController *myStorageViewController = self;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    
    footer.scrollView = self.packageTableView;
    
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        //调用获取接口，获取数据
        self.downUp = 1;
        if(self.packageList.count%10 == 0)
        {
            self.value = (int)(self.packageList.count/10)+1;
            [self callPackageListWebService];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [myStorageViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    
    _footer = footer;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.packageTableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

//-------------------------------UITableView------------------------//
//设置SectionHeader高度:
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;//国际运单TableViewCell 高度为0
}

//自定义section的头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //遮挡无数据部分tableView的分割线
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    tableView.separatorInset = UIEdgeInsetsZero;
    tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    
    return 1;
}

#pragma mark - UITableViewDelegate TableView委托
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断dataSouce的数据个数,如果为零可以隐藏分割线
    if (self.packageList.count == 0)
    {
        self.packageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else
    {
        self.packageTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return self.packageList.count;
}

#pragma mark - 方法:cell的加载和复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float tableViewContentHeight = self.packageList.count*85.0f;
    tableView.contentSize = CGSizeMake(MainScreenWidth,tableViewContentHeight+TransparentBarHeight);
    
    Package *package =  (Package *)self.packageList[indexPath.row];
    
    if ([package isKindOfClass:[BuyPackage class]])
    {
        BuyPackageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BuyPackageTableViewCellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[BuyPackageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BuyPackageTableViewCellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//点击选中时的颜色类型
        [cell.isSelectedButton addTarget:self action:@selector(isSelectedButtonOnCell:) forControlEvents:UIControlEventTouchUpInside];
        cell.isSelectedButton.tag = indexPath.row;
        
        [cell.detailButton addTarget:self action:@selector(myStorageDetailView:)  forControlEvents:UIControlEventTouchUpInside];
        cell.detailButton.tag = indexPath.row;
        
        cell.buyPackage = (BuyPackage *)package;

        return cell;
    }
    else
    {
        SelfPackageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SelfPackageTableViewCellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[SelfPackageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelfPackageTableViewCellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//点击选中时的颜色类型
        
        [cell.isSelectedButton addTarget:self action:@selector(isSelectedButtonOnCell:) forControlEvents:UIControlEventTouchUpInside];
        cell.isSelectedButton.tag = indexPath.row;
        
        [cell.detailButton addTarget:self action:@selector(myStorageDetailView:)  forControlEvents:UIControlEventTouchUpInside];
        cell.detailButton.tag = indexPath.row;
        
        cell.selfPackage = (SelfPackage *)package;
        return cell;
    }
}

- (void)isSelectedButtonOnCell:(id)sender
{
    UIButton *button = (UIButton *)sender;
    Package *package = (Package *)self.packageList[button.tag];
    package.isSelected = !package.isSelected;
    //刷新数据
    [self refreshDataAndView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中后的反显颜色即刻消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Package *package = (Package *)self.packageList[indexPath.row];
    package.isSelected = !package.isSelected;
    //刷新数据
    [self refreshDataAndView];
}

- (void)myStorageDetailView:(id)sender
{
    UIButton *button = (UIButton *)sender;
    Package *package = (Package *)self.packageList[button.tag];
    MyStorageDetailViewController *myStorageDetailViewController = [[MyStorageDetailViewController alloc]initWithNibName:@"MyStorageDetailViewController" bundle:nil];
    myStorageDetailViewController.package = package;
    [self.navigationController pushViewController:myStorageDetailViewController animated:YES];
}
/*****************************国际运单列表接口**********************************/
//重新加载国际运单列表allWayTableView
- (IBAction)reLoadPackageTableView:(id)sender
{
    self.downUp = 0;
    self.value = 1;
    [self callPackageListWebService];
}

- (void)callPackageListWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/order/order_myhome"];
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
    [param setValue:[NSString stringWithFormat:@"%d",self.value]  forKey:@"value"];
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
            
            NSLog(@"result = %@",result);
            
            //解析商品列表数据
            if (![self resolvePackageListJson:result])
            {
                request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
                request.hud.mode = MBProgressHUDModeCustomView;
                request.hud.removeFromSuperViewOnHide = YES;
                request.hud.labelText = @"解析失败";
            }
            else
            {
                [self.packageTableView reloadData];
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

- (BOOL)resolvePackageListJson:(NSArray *)result
{
    if (self.downUp == 0)
    {
        [self.packageList removeAllObjects];
    }
    
    for(NSDictionary *packageDictionary in result)
    {
        int packageType = [[packageDictionary objectForKey:@"packageType"]intValue];
        
        if (packageType == 1 || packageType == 2 )
        {
            BuyPackage *buyPackage = [[BuyPackage alloc]init];
            buyPackage.packageNo = [packageDictionary objectForKey:@"packageNo"];
            buyPackage.packageWeight = [[packageDictionary objectForKey:@"packageWeight"]floatValue];
            buyPackage.isSelected = NO;
            buyPackage.packageDate = [packageDictionary objectForKey:@"packageDate"];
            buyPackage.packageType = [[packageDictionary objectForKey:@"packageType"]intValue];
            
            NSMutableArray *goodsList = [packageDictionary objectForKey:@"goodsList"];
            buyPackage.packageGoodTypeCount = (int)goodsList.count;
            
            int i=0;
            for(NSDictionary *goodsListDictionary in goodsList)
            {
                Goods *goods = [[Goods alloc]init];
                goods.url = [goodsListDictionary objectForKey:@"url"];
                goods.goodsImage = [goodsListDictionary objectForKey:@"goodsImage"];
                goods.name = [goodsListDictionary objectForKey:@"name"];
                goods.color = [goodsListDictionary objectForKey:@"buyColor"];
                goods.buySize = [goodsListDictionary objectForKey:@"buySize"];
                goods.realPrice = [[goodsListDictionary objectForKey:@"realPrice"]floatValue];
                if ([goodsListDictionary objectForKey:@"remark"]&&![[goodsListDictionary objectForKey:@"remark"] isEqual:[NSNull null]])
                {
                    goods.remark = [goodsListDictionary objectForKey:@"remark"];
                }
                else
                {
                    goods.remark = @"";
                }
                goods.buyQuantity = [[goodsListDictionary objectForKey:@"buyQuantity"]intValue];
                [buyPackage.goodsList addObject:goods];
                if (i==0)
                {
                    buyPackage.packageTitle = goods.name;
                    buyPackage.isSensitive = [[goodsListDictionary objectForKey:@"isSensitive"]intValue];
                }
                i++;
            }
            
            [self.packageList addObject:buyPackage];
        }
        else
        {
            SelfPackage *selfPackage = [[SelfPackage alloc]init];
            selfPackage.packageNo = [packageDictionary objectForKey:@"packageNo"];
            selfPackage.packageWeight = [[packageDictionary objectForKey:@"packageWeight"]floatValue];
            
            selfPackage.isSelected = NO;
            selfPackage.packageDate = [packageDictionary objectForKey:@"packageDate"];
            
            selfPackage.packageType = [[packageDictionary objectForKey:@"packageType"]intValue];
            
            NSMutableArray *goodsList = [packageDictionary objectForKey:@"goodsList"];
            for(NSDictionary *goodsListDictionary in goodsList)
            {
                selfPackage.packageTitle = [goodsListDictionary objectForKey:@"name"];
                if ([goodsListDictionary objectForKey:@"remark"]&&![[goodsListDictionary objectForKey:@"remark"] isEqual:[NSNull null]])
                {
                    selfPackage.packageRemark = [goodsListDictionary objectForKey:@"remark"];
                }
                else
                {
                    selfPackage.packageRemark = @"";
                }
                selfPackage.isSensitive = [[goodsListDictionary objectForKey:@"isSensitive"]intValue];
            }

            [self.packageList addObject:selfPackage];
        }
    }
    
    return YES;
}

@end
