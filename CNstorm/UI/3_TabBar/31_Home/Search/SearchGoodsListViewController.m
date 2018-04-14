//
//  SearchGoodsListViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-11.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "SearchGoodsListViewController.h"

NSString *const SearchGoodsListTableViewCellIdentifier = @"SearchGoodsListTableViewCell";

@interface SearchGoodsListViewController ()
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@end

@implementation SearchGoodsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //初始化商品列表goodsList
        self.goodsList = [NSMutableArray arrayWithCapacity:0];
        self.keyWord = [NSString stringWithFormat:@"%@",self.keyWord];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //解决iOS7适配问题，导航栏遮挡了view，通常前两句就能解决问题，不行加后两句
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    //UISearchBar
    self.navigationItem.title = [NSString stringWithFormat:@"搜索%@",self.keyWord];
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


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initMyView
{
    //商品列表TableView的加载
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[GoodsListTableViewCell class] forCellReuseIdentifier:SearchGoodsListTableViewCellIdentifier];
    [self addHeader];
    [self addFooter];
}

- (void)addHeader
{
    __unsafe_unretained SearchGoodsListViewController *searchGoodsListViewController = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.scrollView = self.tableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        //调用获取商品列表接口，获取数据
        self.downUp = 0;
        self.value = 1;
        [self callGoodsListWebService];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [searchGoodsListViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        
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
    __unsafe_unretained SearchGoodsListViewController *searchGoodsListViewController = self;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    
    footer.scrollView = self.tableView;
    
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        //调用获取商品列表接口，获取数据
        self.downUp = 1;
        if(self.goodsList.count%10 == 0)
        {
            self.value = (int)(self.goodsList.count/10)+1;
            [self callGoodsListWebService];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [searchGoodsListViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    
    _footer = footer;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.tableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}


//为了保证内部不泄露，在dealloc中释放占用的内存
- (void)dealloc
{
    [_header free];
    [_footer free];
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
    tableView.separatorInset = UIEdgeInsetsZero;
    tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    
    return 1;
}

#pragma mark - UITableViewDelegate TableView委托
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断dataSouce的数据个数,如果为零可以隐藏分割线
    if (self.goodsList.count == 0)
    {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else
    {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return self.goodsList.count;
}

#pragma mark - 方法:cell的加载和复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchGoodsListTableViewCellIdentifier forIndexPath:indexPath];
    
    if (cell==nil)
    {
        cell=[[GoodsListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchGoodsListTableViewCellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.product = [self.goodsList objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailViewController *goodsDetailViewController = [[GoodsDetailViewController alloc] initWithNibName:@"GoodsDetailViewController" bundle:nil];
    Product *product = (Product *)[self.goodsList objectAtIndex:indexPath.row];
    goodsDetailViewController.url = product.location;
    goodsDetailViewController.productId = product.product_id;
    [self.navigationController pushViewController:goodsDetailViewController animated:YES];
}

/*****************************获取商品列表接口**********************************/
//重新加载分类列表:myView
- (IBAction)reLoadMyView:(id)sender
{
    self.downUp = 0;
    self.value = 1;
    [self callGoodsListWebService];
}

//获取分类详情，调用分类接口
- (void)callGoodsListWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/product/search"];
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
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",self.keyWord] forKey:@"keyWord"];
    
    [param setValue:[NSString stringWithFormat:@"%d",self.value] forKey:@"value"];
    
    NSString *paramJson = [param JSONRepresentation];
    
    NSLog(@"paramJson = %@",paramJson);
    
    [request setPostValue:paramJson forKey:@"param"];
    
    [request startAsynchronous];//异步传输
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (![request error])
    {
        NSString *responseString =[request responseString];
        
        NSLog(@"responseString = %@",responseString);
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        NSLog(@"data = %@",data);
        
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
            NSArray *goodsList = [data objectForKey:@"result"];
            //解析商品列表数据
            if (![self resolve:goodsList])
            {
                request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
                request.hud.mode = MBProgressHUDModeCustomView;
                request.hud.removeFromSuperViewOnHide = YES;
                request.hud.labelText = @"解析失败";
            }
            else
            {
                [self.tableView reloadData];
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
    
    request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
    request.hud.mode = MBProgressHUDModeCustomView;
    request.hud.removeFromSuperViewOnHide = YES;
    request.hud.labelText = @"网络异常";
    request.hud.detailsLabelText = @"请检查网络重试";
}

- (BOOL)resolve:(NSArray *)goodsList
{
    if (self.downUp == 0)
    {
        [self.goodsList removeAllObjects];
    }
    
    for(NSDictionary *goodsDictionary in goodsList)
    {
        Product *product = [[Product alloc]init];
        product.product_id = [[goodsDictionary objectForKey:@"product_id"]longLongValue];
        product.image = [NSString stringWithString:[[NSString stringWithFormat:@"%@",[goodsDictionary objectForKey:@"image"]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        product.location = [goodsDictionary objectForKey:@"location"];
        product.name = [goodsDictionary objectForKey:@"name"];
        product.price = [[goodsDictionary objectForKey:@"price"]floatValue];
        product.isbn = [[goodsDictionary objectForKey:@"isbn"]floatValue];
        [self.goodsList addObject:product];
    }
    return YES;
}

@end
