//
//  RechargeRecordViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "RechargeRecordViewController.h"

NSString *const RechargeRecordTableViewCellIdentifier = @"RechargeRecordTableViewCellIdentifier";

@interface RechargeRecordViewController ()
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}
@end

@implementation RechargeRecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.chooseArray = [NSMutableArray arrayWithArray:
            @[@[@"全部记录",@"近一个月",@"近三个月",@"近半年",@"近一年"]]];
        self.rechargeRecordList = [NSMutableArray arrayWithCapacity:0];
        self.scope = 0;
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
    
    [self initRechargeRecordTableView];
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


//-----------------------------导航栏选择 delegate------------------------//
#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    NSLog(@"选了section:%ld ,index:%ld",(long)section,(long)index);
    self.defaultSelectedRow = index;
    
    if (section == 0 && index == 0)
    {
        self.scope = 0;
        self.downUp = 0;
        self.value = 1;
        
        [self callRechargeRecordListWebService];
    }
    else if (section == 0 && index == 1)
    {
        self.scope = 1;
        self.downUp = 0;
        self.value = 1;
        
        [self callRechargeRecordListWebService];
    }
    else if (section == 0 && index == 2)
    {
        self.scope = 2;
        self.downUp = 0;
        self.value = 1;
        
        [self callRechargeRecordListWebService];
    }
    else if (section == 0 && index == 3)
    {
        self.scope = 3;
        self.downUp = 0;
        self.value = 1;
        
        [self callRechargeRecordListWebService];
    }
    else
    {
        self.scope = 4;
        self.downUp = 0;
        self.value = 1;
        
        [self callRechargeRecordListWebService];
    }
}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [self.chooseArray count];
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return [self.chooseArray[section] count];
}

-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return self.chooseArray[section][index];
}

//设置选择row的默认值
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return self.defaultSelectedRow;
}

//-------------------------------代购订单TableView初始化------------------------//
- (void)initRechargeRecordTableView
{
    self.rechargeRecordTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight) style:UITableViewStylePlain];
    self.rechargeRecordTableView.delegate = self;
    self.rechargeRecordTableView.dataSource = self;
    [self.view addSubview:self.rechargeRecordTableView];
    
    // 1.注册
    [self.rechargeRecordTableView registerClass:[RechargeRecordTableViewCell class] forCellReuseIdentifier:RechargeRecordTableViewCellIdentifier];
    
    //集成刷新控件
    //下拉刷新
    [self addHeader];
    
    //上拉加载更多
    [self addFooter];
}

- (void)addHeader
{
    __unsafe_unretained RechargeRecordViewController *rechargeRecordViewController = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.scrollView = self.rechargeRecordTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        self.downUp = 0;
        self.value = 1;
        [self callRechargeRecordListWebService];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [rechargeRecordViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        
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
    __unsafe_unretained RechargeRecordViewController *rechargeRecordViewController = self;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    
    footer.scrollView = self.rechargeRecordTableView;
    
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        self.downUp = 1;
        if(self.rechargeRecordList.count%10 == 0)
        {
            self.value = (int)(self.rechargeRecordList.count/10)+1;
            [self callRechargeRecordListWebService];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [rechargeRecordViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    
    _footer = footer;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.rechargeRecordTableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

//-------------------------------UITableView------------------------//
//设置SectionHeader高度:
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
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
    tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    
    return 1;
}

#pragma mark - UITableViewDelegate TableView委托
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断dataSouce的数据个数,如果为零可以隐藏分割线
    if (self.rechargeRecordList.count == 0)
    {
        self.rechargeRecordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else
    {
        self.rechargeRecordTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return self.rechargeRecordList.count;
}

#pragma mark - 方法:cell的加载和复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RechargeRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RechargeRecordTableViewCellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[RechargeRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RechargeRecordTableViewCellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//点击选中时的颜色类型
    
    RechargeRecord *rechargeRecord =  self.rechargeRecordList[indexPath.row];
    
    cell.rechargeRecord = rechargeRecord;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中后的反显颜色即刻消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) reLoadRechargeRecordTableView:(id)sender
{
    self.downUp = 0;
    self.value = 1;
    [self callRechargeRecordListWebService];
}

- (void)callRechargeRecordListWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/account/recharge_record"];
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
    [param setValue:[NSString stringWithFormat:@"%d",self.scope] forKey:@"scope"];
    [param setValue:[NSString stringWithFormat:@"%d",self.value] forKey:@"value"];
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
        
        //官方的Json速度最快
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        
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

            if (![self resolveRechargeRecordList:result])
            {
                request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
                request.hud.mode = MBProgressHUDModeCustomView;
                request.hud.removeFromSuperViewOnHide = YES;
                request.hud.labelText = @"解析失败";
            }
            else
            {
                [self.rechargeRecordTableView reloadData];
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

- (BOOL)resolveRechargeRecordList:(NSArray *)result
{
    if (self.downUp == 0)
    {
        [self.rechargeRecordList removeAllObjects];
    }
    
    for(NSDictionary *rechargeRecordDictionary in result)
    {
        RechargeRecord *rechargeRecord = [[RechargeRecord alloc]init];
        
        if([rechargeRecordDictionary objectForKey:@"rid"])
        {
            rechargeRecord.rid = [[rechargeRecordDictionary objectForKey:@"rid"]longLongValue];
        }
        
        if([rechargeRecordDictionary objectForKey:@"uid"])
        {
            rechargeRecord.uid = [[rechargeRecordDictionary objectForKey:@"uid"]longLongValue];
        }
        
        rechargeRecord.uname = [rechargeRecordDictionary objectForKey:@"uname"];
        
        rechargeRecord.sn = [rechargeRecordDictionary objectForKey:@"sn"];
        
        rechargeRecord.amount = [[rechargeRecordDictionary objectForKey:@"amount"]doubleValue];
        
        rechargeRecord.currency = [rechargeRecordDictionary objectForKey:@"currency"];
        
        rechargeRecord.accountmoney = [[rechargeRecordDictionary objectForKey:@"accountmoney"] doubleValue];
        
        rechargeRecord.money = [[rechargeRecordDictionary objectForKey:@"money"]doubleValue];
        
        rechargeRecord.paytype = [[rechargeRecordDictionary objectForKey:@"paytype"]intValue];
        
        rechargeRecord.payname = [rechargeRecordDictionary objectForKey:@"payname"];
        
        if([rechargeRecordDictionary objectForKey:@"addtime"])
        {
            rechargeRecord.addtime = [[rechargeRecordDictionary objectForKey:@"addtime"]longLongValue];
        }
        
        if([rechargeRecordDictionary objectForKey:@"successtime"]&&![[rechargeRecordDictionary objectForKey:@"successtime"] isEqual:[NSNull null]])
        {
            rechargeRecord.successtime = [[rechargeRecordDictionary objectForKey:@"successtime"]longLongValue];
        }
        
        if ([rechargeRecordDictionary objectForKey:@"remark"]&&![[rechargeRecordDictionary objectForKey:@"remark"] isEqual:[NSNull null]])
        {
            rechargeRecord.remark = [rechargeRecordDictionary objectForKey:@"remark"];
        }
        else
        {
            rechargeRecord.remark = @"";
        }
        
        rechargeRecord.state = [[rechargeRecordDictionary objectForKey:@"state"]intValue];
        
        [self.rechargeRecordList addObject:rechargeRecord];
    }
    
    return YES;
}


@end

