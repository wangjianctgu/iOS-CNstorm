//
//  AwaitPayViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-9.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "AwaitPayViewController.h"

NSString *const AwaitPayOrderTableViewCellIdentifier = @"AwaitPayOrderTableViewCellIdentifier";

NSString *const AwaitPayWayTableViewCellIdentifier = @"AwaitPayWayTableViewCellIdentifier";

@interface AwaitPayViewController ()
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@end

@implementation AwaitPayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.orderList = [NSMutableArray arrayWithCapacity:0];
        
        self.wayList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"待付款";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    //初始化分段选择控件视图
    [self initSegmentedControlView];
    
    [self initWayTableView];
    
    [self initOrderTableView];
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

//初始化分段选择控件视图
- (void)initSegmentedControlView
{
    //初始化
    UIView *segmentedControlView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,MainScreenWidth,TransparentBarHeight)];
    segmentedControlView.backgroundColor =[UIColor colorWithRed:(255.0f)/255.0f green:(255.0f)/255.0f blue:(255.0f)/255.0f alpha:1];
    [self.view addSubview:segmentedControlView];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"代购订单",@"国际运单",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(10.0f, 10.0f, 300.0f, 30.0f);
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    segmentedControl.tintColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1];
    [segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    [segmentedControl addTarget:self action:@selector(selectedSegmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    segmentedControl.layer.cornerRadius = 6.0f;
    segmentedControl.layer.borderWidth = 0.5f;
    segmentedControl.layer.borderColor = [UIColor colorWithRed:(195.0f)/255.0f green:(60.0f)/255.0f blue:(33.0f)/255.0f alpha:1].CGColor;
    [segmentedControlView addSubview:segmentedControl];
}

- (void)selectedSegmentAction:(UISegmentedControl *)segmentedControl
{
    NSInteger index = segmentedControl.selectedSegmentIndex;
    
    switch (index)
    {
        case 0:
            [self.view insertSubview:self.orderTableView aboveSubview:self.wayTableView];
            break;
        case 1:
            [self.view insertSubview:self.wayTableView aboveSubview:self.orderTableView];
            break;
        default:
            break;
    }
}

- (void)orderPayView:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    ReplaceBuyOrder *replaceBuyOrder = self.orderList[btn.tag];
    
    OrderPayViewController *orderPayViewController = [[OrderPayViewController alloc]initWithNibName:@"OrderPayViewController" bundle:nil];
    orderPayViewController.hidesBottomBarWhenPushed = YES;
    orderPayViewController.orderIdsStr = replaceBuyOrder.orderNo;
    orderPayViewController.orderTotalCost = replaceBuyOrder.orderAllCost;
    [self.navigationController pushViewController:orderPayViewController animated:YES];
}

- (void)wayPayView:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    Way *way = (Way *)self.wayList[btn.tag];
    
    WayPayViewController *wayPayViewController = [[WayPayViewController alloc]initWithNibName:@"WayPayViewController" bundle:nil];
    wayPayViewController.wayIdStr = way.wayNo;
    wayPayViewController.wayTotalCost = way.yunfei;
    [self.navigationController pushViewController:wayPayViewController animated:YES];
}

//-------------------------------订单TableView初始化------------------------//
- (void)initOrderTableView
{
    //商品列表TableView的加载
    self.orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, TransparentBarHeight, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TransparentBarHeight) style:UITableViewStylePlain];
    self.orderTableView.delegate = self;
    self.orderTableView.dataSource = self;
    [self.view addSubview:self.orderTableView];
    
    // 1.注册
    [self.orderTableView registerClass:[AwaitPayOrderTableViewCell class] forCellReuseIdentifier:AwaitPayOrderTableViewCellIdentifier];
    
    //集成刷新控件
    //下拉刷新
    [self addHeader];
    
    //上拉加载更多
    [self addFooter];
}

- (void)addHeader
{
    __unsafe_unretained AwaitPayViewController *awaitPayViewController = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.scrollView = self.orderTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        //调用获取商品列表接口，获取数据
        self.downUp = 0;
        self.value = 1;
        [self callAwaitPayOrderListWebService];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [awaitPayViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        
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
    __unsafe_unretained AwaitPayViewController *awaitPayViewController = self;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    
    footer.scrollView = self.orderTableView;
    
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        //调用获取商品列表接口，获取数据
        self.downUp = 1;
        if(self.orderList.count%10 == 0)
        {
            self.value = (int)(self.orderList.count/10)+1;
            [self callAwaitPayOrderListWebService];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [awaitPayViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    
    _footer = footer;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    NSLog(@"doneWithView");
    // 刷新表格
    [self.orderTableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

//-------------------------------运单TableView初始化------------------------//
- (void)initWayTableView
{
    //商品列表TableView的加载
    self.wayTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, TransparentBarHeight, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TransparentBarHeight) style:UITableViewStylePlain];
    self.wayTableView.delegate = self;
    self.wayTableView.dataSource = self;
    [self.view addSubview:self.wayTableView];
    
    // 1.注册
    [self.wayTableView registerClass:[AllWayTableViewCell class] forCellReuseIdentifier:AwaitPayWayTableViewCellIdentifier];
    //集成刷新控件
    //下拉刷新
    [self addHeaderWay];
    
    //上拉加载更多
    [self addFooterWay];
}

- (void)addHeaderWay
{
    __unsafe_unretained AwaitPayViewController *awaitPayViewController = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.scrollView = self.wayTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        //调用获取接口，获取数据
        self.downUp2 = 0;
        self.value2 = 1;
        [self callAwaitPayWayListWebService];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [awaitPayViewController performSelector:@selector(doneWithViewWay:) withObject:refreshView afterDelay:2.0];
        
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

- (void)addFooterWay
{
    __unsafe_unretained AwaitPayViewController *awaitPayViewController = self;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    
    footer.scrollView = self.wayTableView;
    
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        //调用获取商品列表接口，获取数据
        self.downUp2 = 1;
        if(self.wayList.count%10 == 0)
        {
            self.value2 = (int)(self.wayList.count/10)+1;
            [self callAwaitPayWayListWebService];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [awaitPayViewController performSelector:@selector(doneWithViewWay:) withObject:refreshView afterDelay:2.0];
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    
    _footer = footer;
}

- (void)doneWithViewWay:(MJRefreshBaseView *)refreshView
{
    NSLog(@"doneWithViewWay");
    // 刷新表格
    [self.wayTableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

//-------------------------------UITableView------------------------//
//设置SectionHeader高度:
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.orderTableView)
    {
        return 32.0f;
    }
    
    return 0.0f;//运单wayTableViewCell 高度为0
}

//自定义section的头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.orderTableView)
    {
        ReplaceBuyOrder *replaceBuyOrder =  self.orderList[section];
        
        AwaitPayOrderTableViewHeaderView *headerView = [[AwaitPayOrderTableViewHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 32.0f)];//创建一个视图
        
        headerView.storeNameLabel.text = replaceBuyOrder.storeName;
        
        if (replaceBuyOrder.orderStatus ==1)//如果取消，则关闭按钮
        {
            headerView.cancelButton.hidden = NO;
            [headerView.cancelButton addTarget:self action:@selector(isCancelOrder:) forControlEvents:UIControlEventTouchUpInside];
            headerView.cancelButton.tag = section;
        }
  
        return headerView;
    }
    
    return nil;//运单wayTableViewCell 没有headView
}

- (void)isCancelOrder:(id)sender
{
    self.orderAlertView = [[UIAlertView alloc]initWithTitle:@"确认删除该订单吗？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.orderAlertView.tag = ((UIButton *)sender).tag;
    [self.orderAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.orderAlertView && buttonIndex == 1)
    {
        ReplaceBuyOrder *replaceBuyOrder =  self.orderList[alertView.tag];
        [self callDeleteOrderWebService:replaceBuyOrder.orderNo];
        
        [self.orderList removeObjectAtIndex:alertView.tag];
        [self.orderTableView reloadData];
    }
    else if (alertView == self.wayAlertView && buttonIndex == 1)
    {
        Way *way = self.wayList[alertView.tag];
        
        [self callDeleteWayWebService:way.wayNo];
        
        [self.wayList removeObjectAtIndex:alertView.tag];
        [self.wayTableView reloadData];

    }
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
    
    if (tableView == self.orderTableView)
    {
        //判断dataSouce的数据个数,如果为零可以隐藏分割线
        if (self.orderList.count == 0)
        {
            self.orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        else
        {
            self.orderTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        return self.orderList.count;
    }
    else
    {
        return 1;//运单默认一个section
    }
}

#pragma mark - UITableViewDelegate TableView委托
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.orderTableView)
    {
        return 1;//每个订单，只显示1件商品
    }
    else
    {
        //判断dataSouce的数据个数,如果为零可以隐藏分割线
        if (self.wayList.count == 0)
        {
            self.wayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        else
        {
            self.wayTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        
        return self.wayList.count;
    }
}

#pragma mark - 方法:cell的加载和复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.orderTableView)
    {
        AwaitPayOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AwaitPayOrderTableViewCellIdentifier forIndexPath:indexPath];

        if (cell == nil)
        {
            cell = [[AwaitPayOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AwaitPayOrderTableViewCellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//点击选中时的颜色类型
        
        ReplaceBuyOrder *replaceBuyOrder =  self.orderList[indexPath.section];
        cell.replaceBuyOrder = replaceBuyOrder;
        
        [cell.orderStatusButton addTarget:self action:@selector(orderPayView:) forControlEvents:UIControlEventTouchUpInside];
         cell.orderStatusButton.tag = indexPath.section;
        
        return cell;
    }
    else
    {
        AllWayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AwaitPayWayTableViewCellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[AllWayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AwaitPayWayTableViewCellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//点击选中时的颜色类型
        
        Way *way = (Way *)self.wayList[indexPath.row];
        cell.way = way;
        
        if (way.wayStatus == 0)
        {
            [cell.wayStatusButton addTarget:self action:@selector(wayPayView:) forControlEvents:UIControlEventTouchUpInside];
            cell.wayStatusButton.tag = indexPath.row;
            
            [cell.isCancelButton addTarget:self action:@selector(isCancelWay:) forControlEvents:UIControlEventTouchUpInside];
            cell.isCancelButton.hidden = NO;
            cell.isCancelButton.tag = indexPath.row;
        }
        else
        {
            [cell.wayStatusButton removeTarget:self action:@selector(wayPayView:) forControlEvents:UIControlEventTouchUpInside];
            [cell.isCancelButton removeTarget:self action:@selector(isCancelWay:) forControlEvents:UIControlEventTouchUpInside];
            cell.isCancelButton.hidden = YES;
        }
        
        return cell;
    }
}

- (void)isCancelWay:(id)sender
{
    self.wayAlertView = [[UIAlertView alloc]initWithTitle:@"确认删除该订运单吗？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.wayAlertView.tag = ((UIButton *)sender).tag;
    [self.wayAlertView show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.orderTableView)
    {
        return 110.0f;
    }
    else
    {
        return 116.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.orderTableView)
    {
        AwaitPayOrderDetailViewController *awaitPayOrderDetailViewController = [[AwaitPayOrderDetailViewController alloc]initWithNibName:@"AwaitPayOrderDetailViewController" bundle:nil];
        awaitPayOrderDetailViewController.replaceBuyOrder = self.orderList[indexPath.section];
        [self.navigationController pushViewController:awaitPayOrderDetailViewController animated:YES];
    }
    else
    {
        AwaitPayWayDetailViewController *awaitPayWayDetailViewController = [[AwaitPayWayDetailViewController alloc]initWithNibName:@"AwaitPayWayDetailViewController" bundle:nil];
        awaitPayWayDetailViewController.way = (Way *)self.wayList[indexPath.row];
        [self.navigationController pushViewController:awaitPayWayDetailViewController animated:YES];
    }
}

/*****************************未付款订单列表接口**********************************/
- (IBAction)reLoadOrderTableView:(id)sender
{
    self.downUp = 0;
    self.value = 1;
    [self callAwaitPayOrderListWebService];
}

//获取未付款订单列表接口
- (void)callAwaitPayOrderListWebService
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
    [request setDidFailSelector:@selector(requestOrderListFailed:)];
    [request setDidFinishSelector:@selector(requestOrderListFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    [param setValue:[NSString stringWithFormat:@"%d",self.value] forKey:@"value"];
    [param setValue:@"1" forKey:@"order_status_buy"];//代购
    [param setValue:@"1" forKey:@"order_status_id"];//未付款
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];
}

- (void)requestOrderListFinished:(ASIHTTPRequest *)request
{
    if (![request error])
    {
        NSString *responseString =[request responseString];
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 0)
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
        else
        {
             NSArray *result = [data objectForKey:@"result"];
            if (![self resolveAwaitPayOrderList:result])
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
                [self.orderTableView reloadData];
            }
        }
    }
}

- (BOOL)resolveAwaitPayOrderList:(NSArray *)result
{
    if (self.downUp == 0)
    {
        [self.orderList removeAllObjects];
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
        replaceBuyOrder.telePhone= [replaceBuyOrderDictionary objectForKey:@"telePhone"];
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
        
        [self.orderList addObject:replaceBuyOrder];
    }
    
    return YES;
}

- (void)requestOrderListFailed:(ASIHTTPRequest *)request
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

/*****************************未付款运单列表接口**********************************/
//重新加载未付款运单列表WayTableView
- (IBAction)reLoadWayTableView:(id)sender
{
    self.downUp = 0;
    self.value = 1;
    [self callAwaitPayWayListWebService];
}

//获取未付款运单列表接口
- (void)callAwaitPayWayListWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/guoji/guoji_list"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestWayListFailed:)];
    [request setDidFinishSelector:@selector(requestWayListFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    [param setValue:[NSString stringWithFormat:@"%d",self.value] forKey:@"value"];
    [param setValue:[NSString stringWithFormat:@"1"] forKey:@"status"];
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
}

- (void)requestWayListFinished:(ASIHTTPRequest *)request
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
            
            //解析商品列表数据
            if (![self resolveAwaitPayWayListJson:result])
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
                [self.wayTableView reloadData];
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

- (void)requestWayListFailed:(ASIHTTPRequest *)request
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

- (BOOL)resolveAwaitPayWayListJson:(NSArray *)result
{
    if (self.downUp == 0)
    {
        [self.wayList removeAllObjects];
    }
    
    for(NSDictionary *allWayDictionary in result)
    {
        Way *way = [[Way alloc]init];
        
        way.yunfei = [[allWayDictionary objectForKey:@"yunfei"]floatValue];
        way.wayStatus = [[allWayDictionary objectForKey:@"wayStatus"]intValue];
        way.wayNo= [allWayDictionary objectForKey:@"wayNo"];
        way.weight = [[allWayDictionary objectForKey:@"weight"] floatValue];
        way.wayDate = [allWayDictionary objectForKey:@"wayDate"];
        
        way.receiveAddress= [allWayDictionary objectForKey:@"receiveAddress"];
        way.mailCode= [allWayDictionary objectForKey:@"mailCode"];
        way.receiver= [allWayDictionary objectForKey:@"receiver"];
        way.telePhone= [allWayDictionary objectForKey:@"telePhone"];
        way.express = [allWayDictionary objectForKey:@"express"];
        way.expressNumber = [allWayDictionary objectForKey:@"express_number"];
        
        NSMutableArray *packageList = [allWayDictionary objectForKey:@"ordersList"];
        way.wayPackageCount = (int)packageList.count;
        
        int wayGoodsTypeCount = 0;
        int i = 0;
        for(NSDictionary *packageListDictionary in packageList)
        {
            int packageType = 0;
            if ([packageListDictionary objectForKey:@"type"]&&![[packageListDictionary objectForKey:@"type"] isEqual:[NSNull null]]) {
                packageType = [[packageListDictionary objectForKey:@"type"]intValue];
            }
            
            if (packageType == 1 || packageType == 2 )
            {
                BuyPackage *buyPackage = [[BuyPackage alloc]init];
                //计算运单中商品数目
                NSMutableArray *goodsList = [packageListDictionary objectForKey:@"goodsList"];
                wayGoodsTypeCount = wayGoodsTypeCount + (int)goodsList.count;
                buyPackage.packageIndex = [NSString stringWithFormat:@"订单No.%d",i+1];
                
                int j=0;
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
                    
                    if (j==0) {
                        way.wayTitel = goods.name;
                    }
                    j++;
                }
                [way.packageList addObject:buyPackage];
            }
            else if (packageType == 3)
            {
                SelfPackage *selfPackage = [[SelfPackage alloc]init];
                
                //计算运单中商品数目
                NSMutableArray *goodsList = [packageListDictionary objectForKey:@"goodsList"];
                wayGoodsTypeCount = wayGoodsTypeCount + (int)goodsList.count;
                selfPackage.packageIndex = [NSString stringWithFormat:@"订单No.%d",i+1];
                
                int j=0;
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
                    

                    if (j==0) {
                        way.wayTitel = selfPackage.packageTitle;
                    }
                    j++;
                }
                [way.packageList addObject:selfPackage];
            }
            i++;
        }
        way.wayGoodsTypeCount = wayGoodsTypeCount;
        [self.wayList addObject:way];
    }
    
    return YES;
}

/*****************************删除运单接口**********************************/
- (void)callDeleteWayWebService:(NSString *)WayId
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/guoji/cancel"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestDeleteWayFinished:)];
    [request setDidFailSelector:@selector(requestDeleteWayFailed:)];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:WayId forKey:@"wayId"];
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在删除";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestDeleteWayFinished:(ASIHTTPRequest *)request
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

- (void)requestDeleteWayFailed:(ASIHTTPRequest *)request
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
