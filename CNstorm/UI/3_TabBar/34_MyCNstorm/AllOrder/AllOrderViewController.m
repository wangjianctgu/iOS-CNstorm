//
//  AllOrderViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-13.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "AllOrderViewController.h"

NSString *const ReplaceBuyOrderTableViewCellIdentifier = @"ReplaceBuyOrderTableViewCellIdentifier";

NSString *const SelfBuyOrderTableViewCellIdentifier = @"SelfBuyOrderTableViewCellIdentifier";
NSString *const TransportOrderTableViewCellIdentifier = @"TransportOrderTableViewCellIdentifier";

@interface AllOrderViewController ()
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}
@end

@implementation AllOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.chooseArray = [NSMutableArray arrayWithArray:
                       @[@[@"代购",@"自助购",@"代寄"]]];
        
        self.replaceBuyOrderList = [NSMutableArray arrayWithCapacity:0];
        self.selfBuyOrderList = [NSMutableArray arrayWithCapacity:0];
        self.transportOrderList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    DropDownListView *dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0.0f,0.0f,100.0f,44.0f) dataSource:self delegate:self];
    dropDownView.backgroundColor = [UIColor clearColor];
    dropDownView.mSuperView = self.view;
    self.navigationItem.titleView = dropDownView;
    
    [self initTransportOrderTableView];
    [self initSelfBuyOrderTableView];
    [self initReplaceBuyOrderTableView];
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

//-----------------------------导航栏选择订单 delegate------------------------//
#pragma mark -- dropDownListDelegate
- (void)chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    NSLog(@"选了section:%ld ,index:%ld",(long)section,(long)index);
    self.defaultSelectedRow = index;
    
    if (section == 0 && index == 0)
    {
        [self.view bringSubviewToFront:self.replaceBuyOrderTableView];
    }
    else if (section == 0 && index == 1)
    {
        [self.view bringSubviewToFront:self.selfBuyOrderTableView];
    }
    else
    {
        [self.view bringSubviewToFront:self.transportOrderTableView];
    }
}

#pragma mark -- dropdownList DataSource
- (NSInteger)numberOfSections
{
    return [self.chooseArray count];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return [self.chooseArray[section] count];
}

- (NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return self.chooseArray[section][index];
}

//设置选择row的默认值
- (NSInteger)defaultShowSection:(NSInteger)section
{
    return self.defaultSelectedRow;
}

- (void)orderPayView:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    ReplaceBuyOrder *replaceBuyOrder = self.replaceBuyOrderList[btn.tag];
    
    OrderPayViewController *orderPayViewController = [[OrderPayViewController alloc]initWithNibName:@"OrderPayViewController" bundle:nil];
    orderPayViewController.hidesBottomBarWhenPushed = YES;
    orderPayViewController.orderIdsStr = replaceBuyOrder.orderNo;
    orderPayViewController.orderTotalCost = replaceBuyOrder.orderAllCost;
    [self.navigationController pushViewController:orderPayViewController animated:YES];
}

//-------------------------------代购订单TableView初始化------------------------//
- (void)initReplaceBuyOrderTableView
{
    //代购订单TableView的加载
    self.replaceBuyOrderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight) style:UITableViewStylePlain];
    self.replaceBuyOrderTableView.delegate = self;
    self.replaceBuyOrderTableView.dataSource = self;
    [self.view addSubview:self.replaceBuyOrderTableView];
    
    // 1.注册
    [self.replaceBuyOrderTableView registerClass:[ReplaceBuyOrderTableViewCell class] forCellReuseIdentifier:ReplaceBuyOrderTableViewCellIdentifier];
    
    //集成刷新控件
    //下拉刷新
    [self addHeader];
    
    //上拉加载更多
    [self addFooter];
}

- (void)addHeader
{
    __unsafe_unretained AllOrderViewController *allOrderViewController = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.scrollView = self.replaceBuyOrderTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        // 调用获取代购订单列表接口，获取数据
        self.downUp = 0;
        self.value = 1;
        
        [self callReplaceBuyOrderListWebService];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [allOrderViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0f];
        
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
    __unsafe_unretained AllOrderViewController *allOrderViewController = self;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    
    footer.scrollView = self.replaceBuyOrderTableView;
    
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        //调用获取商品列表接口，获取数据
        self.downUp = 1;
        if(self.replaceBuyOrderList.count%10 == 0)
        {
            self.value = (int)(self.replaceBuyOrderList.count/10)+1;
            [self callReplaceBuyOrderListWebService];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [allOrderViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0f];
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    
    _footer = footer;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    NSLog(@"doneWithView");
    // 刷新表格
    [self.replaceBuyOrderTableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

//-------------------------------自助购订单TableView初始化------------------------//
- (void)initSelfBuyOrderTableView
{
    //TableView的加载
    self.selfBuyOrderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight) style:UITableViewStylePlain];
    self.selfBuyOrderTableView.delegate = self;
    self.selfBuyOrderTableView.dataSource = self;
    [self.view addSubview:self.selfBuyOrderTableView];
    
    // 1.注册
    [self.selfBuyOrderTableView registerClass:[SelfBuyOrderTableViewCell class] forCellReuseIdentifier:SelfBuyOrderTableViewCellIdentifier];
    
    //集成刷新控件
    //下拉刷新
    [self addHeaderSelfBuyOrder];
    
    //上拉加载更多
    [self addFooterSelfBuyOrder];
}

- (void)addHeaderSelfBuyOrder
{
    __unsafe_unretained AllOrderViewController *allOrderViewController = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.scrollView = self.selfBuyOrderTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        // 调用获取代购订单列表接口，获取数据
        self.downUp2 = 0;
        self.value2 = 1;
        [self callSelfBuyOrderListWebService];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [allOrderViewController performSelector:@selector(doneWithViewSelfBuyOrder:) withObject:refreshView afterDelay:2.0];
        
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

- (void)addFooterSelfBuyOrder
{
    __unsafe_unretained AllOrderViewController *allOrderViewController = self;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    
    footer.scrollView = self.selfBuyOrderTableView;
    
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        //调用获取商品列表接口，获取数据
        self.downUp2 = 1;
        if(self.selfBuyOrderList.count%10 == 0)
        {
            self.value2 = (int)(self.selfBuyOrderList.count/10)+1;
            [self callSelfBuyOrderListWebService];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [allOrderViewController performSelector:@selector(doneWithViewSelfBuyOrder:) withObject:refreshView afterDelay:2.0f];
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    
    _footer = footer;
}

- (void)doneWithViewSelfBuyOrder:(MJRefreshBaseView *)refreshView
{
    NSLog(@"doneWithView");
    // 刷新表格
    [self.selfBuyOrderTableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

//--------------------------国际转运订单TableView初始化------------------------//
- (void)initTransportOrderTableView
{
    //TableView的加载
    self.transportOrderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight) style:UITableViewStylePlain];
    self.transportOrderTableView.delegate = self;
    self.transportOrderTableView.dataSource = self;
    [self.view addSubview:self.transportOrderTableView];
    
    // 1.注册
    [self.transportOrderTableView registerClass:[TransportOrderTableViewCell class] forCellReuseIdentifier:TransportOrderTableViewCellIdentifier];
    
    //集成刷新控件
    //下拉刷新
    [self addHeaderTransportOrder];
    
    //上拉加载更多
    [self addFooterTransportOrder];
}

- (void)addHeaderTransportOrder
{
    __unsafe_unretained AllOrderViewController *allOrderViewController = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.scrollView = self.transportOrderTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        // 调用获取代购订单列表接口，获取数据
        self.downUp3 = 0;
        self.value3 = 1;
        [self callTransportOrderListWebService];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [allOrderViewController performSelector:@selector(doneWithViewTransportOrder:) withObject:refreshView afterDelay:2.0f];
        
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

- (void)addFooterTransportOrder
{
    __unsafe_unretained AllOrderViewController *allOrderViewController = self;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    
    footer.scrollView = self.transportOrderTableView;
    
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        //调用获取商品列表接口，获取数据
        self.downUp3 = 1;
        if(self.transportOrderList.count%10 == 0)
        {
            self.value3 = (int)(self.transportOrderList.count/10)+1;
            [self callTransportOrderListWebService];
        }
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [allOrderViewController performSelector:@selector(doneWithViewTransportOrder:) withObject:refreshView afterDelay:2.0];
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    
    _footer = footer;
}

- (void)doneWithViewTransportOrder:(MJRefreshBaseView *)refreshView
{
    NSLog(@"doneWithView");
    // 刷新表格
    [self.transportOrderTableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

//-------------------------------UITableView------------------------//
//设置SectionHeader高度:
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.transportOrderTableView)//国际转运订单高度为0
    {
        return 0.0f;
    }
    
    return 32.0f;//代购、自助购TableViewCell 高度为32
}

//自定义section的头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //代购订单
    if (tableView == self.replaceBuyOrderTableView)
    {
        ReplaceBuyOrder *replaceBuyOrder = self.replaceBuyOrderList[section];
        ReplaceBuyOrderTableViewHeaderView *headerView = [[ReplaceBuyOrderTableViewHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 32.0f)];//创建一个视图
        headerView.storeNameLabel.text = replaceBuyOrder.storeName;
        
        if (replaceBuyOrder.orderStatus == 1)
        {
            headerView.isCancelButton.hidden = NO;
            [headerView.isCancelButton addTarget:self action:@selector(isCancelROrder:) forControlEvents:UIControlEventTouchUpInside];
            headerView.isCancelButton.tag = section;
        }
        else
        {
            [headerView.isCancelButton removeTarget:self action:@selector(isCancelROrder:) forControlEvents:UIControlEventTouchUpInside];
            headerView.isCancelButton.hidden = YES;
        }
        return headerView;
    }
    else if(tableView == self.selfBuyOrderTableView)
    {
        SelfBuyOrder *selfBuyOrder = self.selfBuyOrderList[section];
        
        SelfBuyOrderTableViewHeaderView *headerView = [[SelfBuyOrderTableViewHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 32.0f)];//创建一个视图
        headerView.storeNameLabel.text = selfBuyOrder.storeName;
        
        if (selfBuyOrder.orderStatus <= 5)//如果取消，则关闭按钮
        {
            headerView.isCancelButton.hidden = NO;
            [headerView.isCancelButton addTarget:self action:@selector(isCancelSOrder:) forControlEvents:UIControlEventTouchUpInside];
            headerView.isCancelButton.tag = section;
        }
        else
        {
            headerView.isCancelButton.hidden = YES;
        }
        
        return headerView;
    }
    
    return nil;//运单wayTableViewCell 没有headView
}

- (void)isCancelROrder:(id)sender
{
    self.rOrderAlertView = [[UIAlertView alloc]initWithTitle:@"确认删除该订单吗？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.rOrderAlertView.tag = ((UIButton *)sender).tag;
    [self.rOrderAlertView show];
}

- (void)isCancelSOrder:(id)sender
{
    self.sOrderAlertView = [[UIAlertView alloc]initWithTitle:@"确认删除该订单吗？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.sOrderAlertView.tag = ((UIButton *)sender).tag;
    [self.sOrderAlertView show];
}

- (void)isCancelTOrder:(id)sender
{
    self.tOrderAlertView = [[UIAlertView alloc]initWithTitle:@"确认删除该订单吗？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.tOrderAlertView.tag = ((UIButton *)sender).tag;
    [self.tOrderAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.rOrderAlertView && buttonIndex == 1)
    {
        ReplaceBuyOrder *replaceBuyOrder = self.replaceBuyOrderList[alertView.tag];
        [self callDeleteOrderWebService:replaceBuyOrder.orderNo];
        
        [self.replaceBuyOrderList removeObjectAtIndex:alertView.tag];
        [self.replaceBuyOrderTableView reloadData];
    }
    else if (alertView == self.sOrderAlertView && buttonIndex == 1)
    {
        SelfBuyOrder *selfBuyOrder = self.selfBuyOrderList[alertView.tag];
        [self callDeleteOrderWebService:selfBuyOrder.orderNo];
        
        [self.selfBuyOrderList removeObjectAtIndex:alertView.tag];
        [self.selfBuyOrderTableView reloadData];
    }
    else if (alertView == self.tOrderAlertView && buttonIndex == 1)
    {
        TransportOrder *transportOrder =  self.transportOrderList[alertView.tag];
        [self callDeleteOrderWebService:transportOrder.orderNo];
        
        [self.transportOrderList removeObjectAtIndex:alertView.tag];
        [self.transportOrderTableView reloadData];
    }
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //遮挡无数据部分tableView的分割线
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    
    if (tableView == self.replaceBuyOrderTableView)
    {
        //判断dataSouce的数据个数,如果为零可以隐藏分割线
        if (self.replaceBuyOrderList.count == 0)
        {
            self.replaceBuyOrderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        else
        {
            self.replaceBuyOrderTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        return self.replaceBuyOrderList.count;
    }
    else if(tableView == self.selfBuyOrderTableView)
    {
        //判断dataSouce的数据个数,如果为零可以隐藏分割线
        if (self.selfBuyOrderList.count == 0)
        {
            self.selfBuyOrderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        else
        {
            self.selfBuyOrderTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        return self.selfBuyOrderList.count;
    }
    else
    {
        return 1;//运单默认一个section
    }
}

#pragma mark - UITableViewDelegate TableView委托
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.replaceBuyOrderTableView)
    {
        return 1;//每个代购订单，只显示1件商品
    }
    else if(tableView == self.selfBuyOrderTableView)
    {
        return 1;//每个自助购订单，只显示1件商品
    }
    else
    {
        //判断dataSouce的数据个数,如果为零可以隐藏分割线
        if (self.transportOrderList.count == 0)
        {
            self.transportOrderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        else
        {
            self.transportOrderTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        
        return self.transportOrderList.count;
    }
}

#pragma mark - 方法:cell的加载和复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.replaceBuyOrderTableView)
    {
        ReplaceBuyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReplaceBuyOrderTableViewCellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[ReplaceBuyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReplaceBuyOrderTableViewCellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//点击选中时的颜色类型
        
        ReplaceBuyOrder *replaceBuyOrder =  self.replaceBuyOrderList[indexPath.section];
        cell.replaceBuyOrder = replaceBuyOrder;
                
        if (replaceBuyOrder.orderStatus == 1)
        {
            [cell.orderStatusButton addTarget:self action:@selector(orderPayView:) forControlEvents:UIControlEventTouchUpInside];
            cell.orderStatusButton.tag = indexPath.section;
        }
        else
        {
            [cell.orderStatusButton removeTarget:self action:@selector(orderPayView:) forControlEvents:UIControlEventTouchUpInside];
        }

        return cell;
    }
    else if(tableView == self.selfBuyOrderTableView)
    {
        SelfBuyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SelfBuyOrderTableViewCellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[SelfBuyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelfBuyOrderTableViewCellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//点击选中时的颜色类型
        
        SelfBuyOrder *selfBuyOrder =  (SelfBuyOrder *)self.selfBuyOrderList[indexPath.section];
        cell.selfBuyOrder = selfBuyOrder;

        return cell;
    }
    else
    {
        TransportOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TransportOrderTableViewCellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[TransportOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TransportOrderTableViewCellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//点击选中时的颜色类型
        
        TransportOrder *transportOrder =  (TransportOrder *)self.transportOrderList[indexPath.row];
        
        cell.transportOrder = transportOrder;
        
        if (transportOrder.orderStatus <= 5)//如果取消，则关闭按钮
        {
            cell.isCancelButton.hidden = NO;
            [cell.isCancelButton addTarget:self action:@selector(isCancelTOrder:) forControlEvents:UIControlEventTouchUpInside];
            cell.isCancelButton.tag = indexPath.row;
        }
        else
        {
            cell.isCancelButton.hidden = YES;
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.transportOrderTableView)
    {
        return 90.0f;
    }
    return 110.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.replaceBuyOrderTableView)
    {
        ReplaceBuyOrderDetailViewController *replaceBuyOrderDetailViewController = [[ReplaceBuyOrderDetailViewController alloc]initWithNibName:@"ReplaceBuyOrderDetailViewController" bundle:nil];
        replaceBuyOrderDetailViewController.replaceBuyOrder = self.replaceBuyOrderList[indexPath.section];
        [self.navigationController pushViewController:replaceBuyOrderDetailViewController animated:YES];
    }
    else if(tableView == self.selfBuyOrderTableView)
    {
        SelfBuyOrderDetailViewController *selfBuyOrderDetailViewController = [[SelfBuyOrderDetailViewController alloc]initWithNibName:@"SelfBuyOrderDetailViewController" bundle:nil];
        selfBuyOrderDetailViewController.selfBuyOrder = self.selfBuyOrderList[indexPath.section];
        [self.navigationController pushViewController:selfBuyOrderDetailViewController animated:YES];
    }
    else
    {
        TransportOrderDetailViewController *transportOrderDetailViewController = [[TransportOrderDetailViewController alloc]initWithNibName:@"TransportOrderDetailViewController" bundle:nil];
        transportOrderDetailViewController.transportOrder = self.transportOrderList[indexPath.row];
        [self.navigationController pushViewController:transportOrderDetailViewController animated:YES];
    }
}

/*****************************代购订单列表接口**********************************/
- (void)callReplaceBuyOrderListWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/order/orders_search"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
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
    [param setValue:[NSString stringWithFormat:@"%d",self.value] forKey:@"value"];
    [param setValue:@"1" forKey:@"order_status_buy"];
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (![request error])
    {
        NSString *responseString =[request responseString];
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
                
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 1)
        {
            NSArray *result = [data objectForKey:@"result"];
            if (![self resolveReplaceBuyOrderList:result])
            {
                request.hud = [[MBProgressHUD alloc] initWithView:self.view];
                request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
                request.hud.mode = MBProgressHUDModeCustomView;
                [request.hud hide:YES afterDelay:1.5f];
                request.hud.labelText = @"解析失败";
                request.hud.square = YES;
                [request.hud show:YES];
                [self.view addSubview:request.hud];
            }
            else
            {
                [self.replaceBuyOrderTableView reloadData];
            }
        }
        else
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud = [[MBProgressHUD alloc] initWithView:self.view];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            [request.hud hide:YES afterDelay:1.5f];
            request.hud.labelText = @"加载失败";
            request.hud.detailsLabelText = errorMessage;
            request.hud.square = YES;
            [request.hud show:YES];
            [self.view addSubview:request.hud];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    if ([request error])
    {
        request.hud = [[MBProgressHUD alloc] initWithView:self.view];
        request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
        request.hud.mode = MBProgressHUDModeCustomView;
        [request.hud hide:YES afterDelay:1.5f];
        request.hud.labelText = @"网络异常";
        request.hud.detailsLabelText = @"请检查网络重试";
        request.hud.square = YES;
        [request.hud show:YES];
        [self.view addSubview:request.hud];
    }
}

- (BOOL)resolveReplaceBuyOrderList:(NSArray *)result
{
    if (self.downUp == 0)
    {
        [self.replaceBuyOrderList removeAllObjects];
    }
    
    for(NSDictionary *replaceBuyOrderDictionary in result)
    {
        ReplaceBuyOrder *replaceBuyOrder = [[ReplaceBuyOrder alloc]init];
        
        replaceBuyOrder.orderNo = [replaceBuyOrderDictionary objectForKey:@"orderId"];
        
        replaceBuyOrder.storeName = [replaceBuyOrderDictionary objectForKey:@"storeName"];
        
        replaceBuyOrder.orderStatus = [[replaceBuyOrderDictionary objectForKey:@"orderStatus"]intValue];
        replaceBuyOrder.orderStatusC = [replaceBuyOrderDictionary objectForKey:@"orderStatusC"];
        replaceBuyOrder.yunfei = [[replaceBuyOrderDictionary objectForKey:@"yunfei"] floatValue];
        
        replaceBuyOrder.orderAllCost= [[replaceBuyOrderDictionary objectForKey:@"orderAllCost"]floatValue];
        
        replaceBuyOrder.orderDate = [replaceBuyOrderDictionary objectForKey:@"orderDate"];
        
        replaceBuyOrder.receiveAddress = [replaceBuyOrderDictionary objectForKey:@"receiveAddress"];
        replaceBuyOrder.mailCode = [replaceBuyOrderDictionary objectForKey:@"mailCode"];
        replaceBuyOrder.receiver = [replaceBuyOrderDictionary objectForKey:@"receiver"];
        replaceBuyOrder.telePhone = [replaceBuyOrderDictionary objectForKey:@"telePhone"];
        
        replaceBuyOrder.express = [replaceBuyOrderDictionary objectForKey:@"express"];
        
        replaceBuyOrder.expressNumber = [replaceBuyOrderDictionary objectForKey:@"express_number"];
        
        NSMutableArray *goodsList = [replaceBuyOrderDictionary objectForKey:@"goodsList"];
        replaceBuyOrder.orderGoodTypeCount = (int)goodsList.count;
        
        int i = 0;
        for(NSDictionary *goodsListDictionary in goodsList)
        {
            Goods *goods = [[Goods alloc]init];
            goods.url = [goodsListDictionary objectForKey:@"url"];
            goods.goodsImage = [NSString stringWithFormat:@"%@",[goodsListDictionary objectForKey:@"goodsImage"]];
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
            [replaceBuyOrder.goodsList addObject:goods];
            
            if (i == 0)
            {
                replaceBuyOrder.orderImage = goods.goodsImage;
                replaceBuyOrder.orderTitle = goods.name;
            }
            i++;
        }
        
        [self.replaceBuyOrderList addObject:replaceBuyOrder];
    }
    
    return YES;
}

/*****************************自助购订单列表接口**********************************/
- (void)callSelfBuyOrderListWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/order/orders_search"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestSelfBuyOrderFinished:)];
    [request setDidFailSelector:@selector(requestSelfBuyOrderFailed:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    [param setValue:[NSString stringWithFormat:@"%d",self.value2] forKey:@"value"];
    [param setValue:@"2" forKey:@"order_status_buy"];
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
}

- (void)requestSelfBuyOrderFinished:(ASIHTTPRequest *)request
{
    if (![request error])
    {
        NSString *responseString =[request responseString];
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 1)
        {
            NSArray *result = [data objectForKey:@"result"];
            if (![self resolveSelfBuyOrderList:result])
            {
                request.hud = [[MBProgressHUD alloc] initWithView:self.view];
                request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
                request.hud.mode = MBProgressHUDModeCustomView;
                [request.hud hide:YES afterDelay:1.5f];
                request.hud.labelText = @"解析失败";
                request.hud.square = YES;
                [request.hud show:YES];
                [self.view addSubview:request.hud];
            }
            else
            {
                [self.selfBuyOrderTableView reloadData];
            }
        }
        else
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud = [[MBProgressHUD alloc] initWithView:self.view];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            [request.hud hide:YES afterDelay:1.5f];
            request.hud.labelText = @"加载失败";
            request.hud.detailsLabelText = errorMessage;
            request.hud.square = YES;
            [request.hud show:YES];
            [self.view addSubview:request.hud];
        }
    }
}

- (void)requestSelfBuyOrderFailed:(ASIHTTPRequest *)request
{
    if ([request error])
    {
        request.hud = [[MBProgressHUD alloc] initWithView:self.view];
        request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
        request.hud.mode = MBProgressHUDModeCustomView;
        [request.hud hide:YES afterDelay:1.5f];
        request.hud.labelText = @"网络异常";
        request.hud.detailsLabelText = @"请检查网络重试";
        request.hud.square = YES;
        [request.hud show:YES];
        [self.view addSubview:request.hud];
    }
}

- (BOOL)resolveSelfBuyOrderList:(NSArray *)result
{
    if (self.downUp2 == 0)
    {
        [self.selfBuyOrderList removeAllObjects];
    }
    
    for(NSDictionary *selfBuyOrderDictionary in result)
    {
        SelfBuyOrder *selfBuyOrder = [[SelfBuyOrder alloc]init];
        
        selfBuyOrder.orderNo = [selfBuyOrderDictionary objectForKey:@"orderId"];
        selfBuyOrder.storeName = [selfBuyOrderDictionary objectForKey:@"storeName"];
        selfBuyOrder.orderStatus = [[selfBuyOrderDictionary objectForKey:@"orderStatus"]intValue];
        selfBuyOrder.orderStatusC = [selfBuyOrderDictionary objectForKey:@"orderStatusC"];
        selfBuyOrder.orderAllCost= [[selfBuyOrderDictionary objectForKey:@"orderAllCost"]floatValue];
        selfBuyOrder.orderDate = [selfBuyOrderDictionary objectForKey:@"orderDate"];
        
        selfBuyOrder.receiveAddress = [selfBuyOrderDictionary objectForKey:@"receiveAddress"];
        selfBuyOrder.mailCode = [selfBuyOrderDictionary objectForKey:@"mailCode"];
        selfBuyOrder.receiver = [selfBuyOrderDictionary objectForKey:@"receiver"];
        selfBuyOrder.telePhone= [selfBuyOrderDictionary objectForKey:@"telePhone"];
        selfBuyOrder.express = [selfBuyOrderDictionary objectForKey:@"express"];
        selfBuyOrder.expressNumber = [selfBuyOrderDictionary objectForKey:@"express_number"];
        
        NSMutableArray *goodsList = [selfBuyOrderDictionary objectForKey:@"goodsList"];
        selfBuyOrder.orderGoodTypeCount = (int)goodsList.count;
        
        int i = 0;
        for(NSDictionary *goodsListDictionary in goodsList)
        {
            Goods *goods = [[Goods alloc]init];
            goods.url = [goodsListDictionary objectForKey:@"url"];
            goods.goodsImage =  [NSString stringWithFormat:@"%@",[goodsListDictionary objectForKey:@"goodsImage"]];
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
            [selfBuyOrder.goodsList addObject:goods];
            
            if (i == 0)
            {
                selfBuyOrder.orderImage = goods.goodsImage;
                selfBuyOrder.orderTitle = goods.name;
            }
            i++;
        }
        [self.selfBuyOrderList addObject:selfBuyOrder];
    }
    return YES;
}

/************************代寄订单列表接口******************************/
- (void)callTransportOrderListWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/order/orders_search"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestTransportOrderFinished:)];
    [request setDidFailSelector:@selector(requestTransportOrderFailed:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    [param setValue:[NSString stringWithFormat:@"%d",self.value3] forKey:@"value"];
    [param setValue:@"3" forKey:@"order_status_buy"];
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];
}

- (void)requestTransportOrderFinished:(ASIHTTPRequest *)request
{
    if (![request error])
    {
        NSString *responseString =[request responseString];
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 1)
        {
            NSArray *result = [data objectForKey:@"result"];
            if (![self resolveTransportOrderList:result])
            {
                request.hud = [[MBProgressHUD alloc] initWithView:self.view];
                request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
                request.hud.mode = MBProgressHUDModeCustomView;
                [request.hud hide:YES afterDelay:1.5f];
                request.hud.labelText = @"解析失败";
                request.hud.square = YES;
                [request.hud show:YES];
                [self.view addSubview:request.hud];
            }
            else
            {
                [self.transportOrderTableView reloadData];
            }
        }
        else
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud = [[MBProgressHUD alloc] initWithView:self.view];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            [request.hud hide:YES afterDelay:1.5f];
            request.hud.labelText = @"加载失败";
            request.hud.detailsLabelText = errorMessage;
            request.hud.square = YES;
            [request.hud show:YES];
            [self.view addSubview:request.hud];
        }
    }
}

- (void)requestTransportOrderFailed:(ASIHTTPRequest *)request
{
    if ([request error])
    {
        request.hud = [[MBProgressHUD alloc] initWithView:self.view];
        request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
        request.hud.mode = MBProgressHUDModeCustomView;
        [request.hud hide:YES afterDelay:1.5f];
        request.hud.labelText = @"网络异常";
        request.hud.detailsLabelText = @"请检查网络重试";
        request.hud.square = YES;
        [request.hud show:YES];
        [self.view addSubview:request.hud];
    }
}

- (BOOL)resolveTransportOrderList:(NSArray *)result
{
    if (self.downUp3 == 0)
    {
        [self.transportOrderList removeAllObjects];
    }
    
    for(NSDictionary *transportOrderDictionary in result)
    {
        TransportOrder *transportOrder = [[TransportOrder alloc]init];
        
        transportOrder.orderNo = [transportOrderDictionary objectForKey:@"orderId"];
        transportOrder.orderStatus = [[transportOrderDictionary objectForKey:@"orderStatus"]intValue];
        transportOrder.orderStatusC = [transportOrderDictionary objectForKey:@"orderStatusC"];
        transportOrder.orderDate = [transportOrderDictionary objectForKey:@"orderDate"];
  
        transportOrder.receiveAddress = [transportOrderDictionary objectForKey:@"receiveAddress"];
        transportOrder.mailCode = [transportOrderDictionary objectForKey:@"mailCode"];
        transportOrder.receiver = [transportOrderDictionary objectForKey:@"receiver"];
        transportOrder.telePhone= [transportOrderDictionary objectForKey:@"telePhone"];
        transportOrder.express = [transportOrderDictionary objectForKey:@"express"];
        transportOrder.expressNumber = [transportOrderDictionary objectForKey:@"express_number"];
        
        NSMutableArray *goodsList = [transportOrderDictionary objectForKey:@"goodsList"];
        for(NSDictionary *goodsListDictionary in goodsList)
        {
            transportOrder.orderTitle = [goodsListDictionary objectForKey:@"name"];
            if ([goodsListDictionary objectForKey:@"remark"]&&![[goodsListDictionary objectForKey:@"remark"] isEqual:[NSNull null]])
            {
                transportOrder.orderRemark = [goodsListDictionary objectForKey:@"remark"];
            }
            else
            {
                transportOrder.orderRemark = @"";
            }
        }

        [self.transportOrderList addObject:transportOrder];
    }
    return YES;
}

/*****************************删除订单接口**********************************/
- (void)callDeleteOrderWebService:(NSString *)orderId
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/order/order_cancel"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestDeleteOrderFinished:)];
    [request setDidFailSelector:@selector(requestDeleteOrderFailed:)];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:orderId forKey:@"orderId"];
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在删除";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestDeleteOrderFinished:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSString *responseString =[request responseString];
                
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 1)
        {
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"success"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"删除成功";
        }
        else
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"删除失败";
            request.hud.detailsLabelText = errorMessage;
        }
    }
}

- (void)requestDeleteOrderFailed:(ASIHTTPRequest *)request
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

