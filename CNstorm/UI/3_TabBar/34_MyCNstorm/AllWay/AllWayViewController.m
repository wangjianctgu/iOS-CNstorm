//
//  AllWayViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-16.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "AllWayViewController.h"

NSString *const AllWayTableViewCellIdentifier = @"AllWayTableViewCellIdentifier";

@interface AllWayViewController ()
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@end

@implementation AllWayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.allWayList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"国际运单";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self initAllWayTableView];
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
    badgeKeyValue.tabBadge4 = badgeKeyValue.tabBadge4 - badgeKeyValue.allWayBadge;
    badgeKeyValue.allWayBadge = 0;
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

//-------------------------------国际运单TableView初始化------------------------//
- (void)initAllWayTableView
{
    //国际运单TableView的加载
    self.allWayTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,MainScreenWidth, MainScreenHeight-NavigationBarHeight) style:UITableViewStylePlain];
    self.allWayTableView.delegate = self;
    self.allWayTableView.dataSource = self;
    [self.view addSubview:self.allWayTableView];
    
    // 1.注册
    [self.allWayTableView registerClass:[AllWayTableViewCell class] forCellReuseIdentifier:AllWayTableViewCellIdentifier];
    
    //集成刷新控件
    //下拉刷新
    [self addHeader];
    
    //上拉加载更多
    [self addFooter];
}

- (void)addHeader
{
    __unsafe_unretained AllWayViewController *allWayViewController = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.scrollView = self.allWayTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        // 调用获取所有运单列表接口，获取数据
        self.downUp = 0;
        self.value = 1;
        [self callAllWayListWebService];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [allWayViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0f];
        
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
    __unsafe_unretained AllWayViewController *allWayViewController = self;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    
    footer.scrollView = self.allWayTableView;
    
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        // 调用接口，获取数据
        self.downUp = 1;
        if(self.allWayList.count%10 == 0)
        {
            self.value = (int)(self.allWayList.count/10)+1;
            [self callAllWayListWebService];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [allWayViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0f];
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    
    _footer = footer;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    NSLog(@"doneWithView");
    // 刷新表格
    [self.allWayTableView reloadData];
    
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
    return nil;//国际运单allWayTableViewCell 没有headView
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
    
    return 1;//运单默认一个section
}

#pragma mark - UITableViewDelegate TableView委托
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断dataSouce的数据个数,如果为零可以隐藏分割线
    if (self.allWayList.count == 0)
    {
        self.allWayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else
    {
        self.allWayTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return self.allWayList.count;
}

#pragma mark - 方法:cell的加载和复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllWayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AllWayTableViewCellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[AllWayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AllWayTableViewCellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//点击选中时的颜色类型
    
    Way *way =  (Way *)self.allWayList[indexPath.row];
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

- (void)isCancelWay:(id)sender
{
    UIAlertView *wayAlertView = [[UIAlertView alloc]initWithTitle:@"确认删除该运单吗？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    wayAlertView.tag = ((UIButton *)sender).tag;
    [wayAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        Way *way = self.allWayList[alertView.tag];
        
        [self callDeleteWayWebService:way.wayNo];
        
        [self.allWayList removeObjectAtIndex:alertView.tag];
        [self.allWayTableView reloadData];
    }
}

- (void)wayPayView:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    Way *way = (Way *)self.allWayList[btn.tag];
    
    WayPayViewController *wayPayViewController = [[WayPayViewController alloc]initWithNibName:@"WayPayViewController" bundle:nil];
    wayPayViewController.wayIdStr = way.wayNo;
    wayPayViewController.wayTotalCost = way.yunfei;
    [self.navigationController pushViewController:wayPayViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 116.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllWayDetailViewController *allWayDetailViewController = [[AllWayDetailViewController alloc]initWithNibName:@"AllWayDetailViewController" bundle:nil];
    allWayDetailViewController.way = (Way *)self.allWayList[indexPath.row];
    [self.navigationController pushViewController:allWayDetailViewController animated:YES];
}

/*****************************国际运单列表接口**********************************/
//重新加载国际运单列表allWayTableView
- (IBAction)reLoadAllWayTableView:(id)sender
{
    self.downUp = 0;
    self.value = 1;
    [self callAllWayListWebService];
}

//获取代购订单列表接口
- (void)callAllWayListWebService
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
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setDidFinishSelector:@selector(requestFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    [param setValue:[NSString stringWithFormat:@"0"] forKey:@"status"];
    [param setValue:[NSString stringWithFormat:@"%d",self.value] forKey:@"value"];
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
            if (![self resolveAllWayListJson:result])
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
                [self.allWayTableView reloadData];
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

- (BOOL)resolveAllWayListJson:(NSArray *)result
{
    if (self.downUp == 0)
    {
        [self.allWayList removeAllObjects];
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
        way.telePhone = [allWayDictionary objectForKey:@"telePhone"];
        way.express = [allWayDictionary objectForKey:@"express"];
        way.expressNumber = [allWayDictionary objectForKey:@"express_number"];
        
        NSMutableArray *packageList = [allWayDictionary objectForKey:@"ordersList"];
        way.wayPackageCount = (int)packageList.count;
        
        NSInteger wayGoodsTypeCount = 0;
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
                wayGoodsTypeCount = wayGoodsTypeCount + goodsList.count;
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
            else if(packageType == 3)
            {
                SelfPackage *selfPackage = [[SelfPackage alloc]init];
                
                //计算运单中商品数目
                NSMutableArray *goodsList = [packageListDictionary objectForKey:@"goodsList"];
                wayGoodsTypeCount = wayGoodsTypeCount + goodsList.count;
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
        way.wayGoodsTypeCount = (int)wayGoodsTypeCount;
        [self.allWayList addObject:way];
    }
    return YES;
}

/*****************************删除订单接口**********************************/
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


@end
