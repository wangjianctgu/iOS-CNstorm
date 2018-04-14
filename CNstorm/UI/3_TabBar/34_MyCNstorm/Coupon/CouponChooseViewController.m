//
//  CouponChooseViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-27.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "CouponChooseViewController.h"

NSString *const CouponChooseTableViewCellIdentifier = @"CouponChooseTableViewCellIdentifier";

@interface CouponChooseViewController ()
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}
@end

@implementation CouponChooseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.couponList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"选择优惠券";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self initCouponTableView];
    
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

//-------------------------------代购订单TableView初始化------------------------//
- (void)initCouponTableView
{
    self.couponTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,MainScreenWidth, MainScreenHeight-NavigationBarHeight) style:UITableViewStylePlain];
    self.couponTableView.delegate = self;
    self.couponTableView.dataSource = self;
    [self.view addSubview:self.couponTableView];
    
    // 1.注册
    [self.couponTableView registerClass:[CouponChooseTableViewCell class] forCellReuseIdentifier:CouponChooseTableViewCellIdentifier];
    
    //集成刷新控件
    //下拉刷新
    [self addHeader];
}

- (void)addHeader
{
    __unsafe_unretained CouponChooseViewController *couponChooseViewController = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.scrollView = self.couponTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        [self callCouponListWebService];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [couponChooseViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        
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

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.couponTableView reloadData];
    
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
    self.couponTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return self.couponList.count;
}

#pragma mark - 方法:cell的加载和复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CouponChooseTableViewCellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[CouponChooseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CouponChooseTableViewCellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//点击选中时的颜色类型
    
    Coupon *coupon =  self.couponList[indexPath.row];
    
    cell.coupon = coupon;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中后的反显颜色即刻消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Coupon *selectedCoupon =  self.couponList[indexPath.row];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didFinishedReturnCoupon:)])
    {
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate didFinishedReturnCoupon:selectedCoupon];
    }
}

- (void) reLoadCouponTableView:(id)sender
{
    [self callCouponListWebService];
}

- (void)callCouponListWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/account/coupons_list"];
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
    [param setValue:[NSString stringWithFormat:@"1"] forKey:@"state"];
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
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        NSArray *result = [data objectForKey:@"result"];
        
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
            if (![self resolveCouponList:result])
            {
                request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
                request.hud.mode = MBProgressHUDModeCustomView;
                request.hud.removeFromSuperViewOnHide = YES;
                request.hud.labelText = @"解析失败";
            }
            else
            {
                [self.couponTableView reloadData];
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
        request.hud.detailsLabelText = @"请检查网络";
    }
}

- (BOOL)resolveCouponList:(NSArray *)result
{
    [self.couponList removeAllObjects];
    
    for(NSDictionary *couponDictionary in result)
    {
        Coupon *coupon = [[Coupon alloc]init];
        
        if([couponDictionary objectForKey:@"cid"])
        {
            coupon.cid = [[couponDictionary objectForKey:@"cid"]intValue];
        }
        
        if([couponDictionary objectForKey:@"uid"])
        {
            coupon.uid = [[couponDictionary objectForKey:@"uid"]longLongValue];
        }
        
        coupon.uname = [couponDictionary objectForKey:@"uname"];
        
        coupon.sn = [couponDictionary objectForKey:@"sn"];
        
        coupon.getway = [[couponDictionary objectForKey:@"getway"]intValue];
        
        if([couponDictionary objectForKey:@"endtime"])
        {
            coupon.endtime = [[couponDictionary objectForKey:@"endtime"]longLongValue];
        }
        
        if([couponDictionary objectForKey:@"addtime"])
        {
            coupon.addtime = [[couponDictionary objectForKey:@"addtime"]longLongValue];
        }
        
        //        if([couponDictionary objectForKey:@"money"]&&![[couponDictionary objectForKey:@"money"] isEqual:[NSNull null]])
        //        {
        //            coupon.money = [[couponDictionary objectForKey:@"money"]intValue];
        //        }
        
        
        //        if([couponDictionary objectForKey:@"sellmoney"]&&![[couponDictionary objectForKey:@"sellmoney"] isEqual:[NSNull null]])
        //        {
        //            coupon.sellmoney = [[couponDictionary objectForKey:@"sellmoney"]intValue];
        //        }
        
        //        if([couponDictionary objectForKey:@"state"]&&![[couponDictionary objectForKey:@"state"] isEqual:[NSNull null]])
        //        {
        //            coupon.state = [[couponDictionary objectForKey:@"state"]intValue];
        //        }
        
        coupon.money = [[self resolve:couponDictionary with:@"money"]intValue];
        
        //        coupon.sellmoney = [[self resolve:couponDictionary with:@"sellmoney"]intValue];
        
        coupon.state = [[self resolve:couponDictionary with:@"state"]intValue];
        
        [self.couponList addObject:coupon];
    }
    
    return YES;
}

- (id)resolve:(NSDictionary *)dictionary with:(NSString *)key
{
    if([dictionary objectForKey:key]&&![[dictionary objectForKey:key] isEqual:[NSNull null]])
    {
        return [dictionary objectForKey:key];
    }
    return @"";
}

@end

