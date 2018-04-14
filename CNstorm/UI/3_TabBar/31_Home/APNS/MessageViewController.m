//
//  MessageViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-18.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "MessageViewController.h"

NSString *const SysTableViewCellIdentifier = @"sysTableViewCellIdentifier";
NSString *const DealTableViewCellIdentifier = @"dealTableViewCellIdentifier";
NSString *const AskTableViewCellIdentifier = @"askTableViewCellIdentifier";

//あ　い　う　え　お　　ア　イ　ウ　エ　オ
@interface MessageViewController ()
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.sysMessageList = [[NSMutableArray alloc]initWithCapacity:0];
        self.dealMessageList = [[NSMutableArray alloc]initWithCapacity:0];
        self.askMessageList = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self initView];
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
    badgeKeyValue.messageBadge = 0;
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

//初始化
- (void)initView
{
    UIView *segmentedControlView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,MainScreenWidth,TransparentBarHeight)];
    segmentedControlView.backgroundColor =[UIColor colorWithRed:(255.0f)/255.0f green:(255.0f)/255.0f blue:(255.0f)/255.0f alpha:1];
    [self.view addSubview:segmentedControlView];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"系统消息",@"交易消息",@"咨询回复",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(10.0f, 10.0f, 300.0f, 30.0f);
    segmentedControl.selectedSegmentIndex = self.index;//设置默认选择项索引
    segmentedControl.tintColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1];
    [segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    [segmentedControl addTarget:self action:@selector(selectedSegmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    segmentedControl.layer.cornerRadius = 6.0f;
    segmentedControl.layer.borderWidth = 0.5f;
    segmentedControl.layer.borderColor = [UIColor colorWithRed:(195.0f)/255.0f green:(60.0f)/255.0f blue:(33.0f)/255.0f alpha:1].CGColor;
    [segmentedControlView addSubview:segmentedControl];
    
    [self initAskView];
    
    [self initDealView];
    
    [self initSysView];
}

- (void)selectedSegmentAction:(UISegmentedControl *)segmentedControl
{
    NSInteger index = segmentedControl.selectedSegmentIndex;
    
    switch (index)
    {
        case 0:
            [self.view bringSubviewToFront:self.sysView];
            break;
        case 1:
            [self.view bringSubviewToFront:self.dealView];
            break;
        case 2:
            [self.view bringSubviewToFront:self.askView];
            break;
        default:
            break;
    }
}

- (void)initSysView
{
    self.sysView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,TransparentBarHeight, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    self.sysView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.view addSubview:self.sysView];
    
    [self initSysTableView];
    [self initSysNullView];
}

- (void)initDealView
{
    self.dealView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,TransparentBarHeight,MainScreenWidth,MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    self.dealView.backgroundColor = [UIColor colorWithRed:(20.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f];
    [self.view addSubview:self.dealView];
    
    [self initDealTableView];
    [self initDealNullView];
}

- (void)initAskView
{
    self.askView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,TransparentBarHeight,MainScreenWidth,MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    self.askView.backgroundColor = [UIColor colorWithRed:(20.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f];
    [self.view addSubview:self.askView];
    
    [self initAskTableView];
    [self initAskNullView];
}

- (void)initSysNullView
{
    self.sysNullView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,MainScreenWidth,MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    self.sysNullView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1];
    [self.sysView addSubview:self.sysNullView];
    
    UILabel *tishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f,150, 300.0f, 30.0f)];
    tishiLabel.text = [NSString stringWithFormat:@"系统消息为空"];
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    tishiLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1];
    tishiLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.sysNullView addSubview:tishiLabel];
}

- (void)initSysTableView
{
    //商品列表TableView的加载
    self.sysTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TransparentBarHeight) style:UITableViewStylePlain];
    self.sysTableView.backgroundColor =[UIColor colorWithRed:(255.0f)/255.0f green:(255.0f)/255.0f blue:(255.0f)/255.0f alpha:1];
    self.sysTableView.delegate = self;
    self.sysTableView.dataSource = self;
    [self.sysView addSubview:self.sysTableView];
    
    [self.sysTableView registerClass:[SysTableViewCell class] forCellReuseIdentifier:SysTableViewCellIdentifier];
    
    [self addSysHeader];
    [self addSysFooter];
}

- (void)initDealNullView
{
    self.dealNullView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,MainScreenWidth,MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    self.dealNullView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1];
    [self.dealView addSubview:self.dealNullView];
    
    UILabel *tishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f,150, 300.0f, 30.0f)];
    tishiLabel.text = [NSString stringWithFormat:@"交易消息为空"];
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    tishiLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1];
    tishiLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.dealNullView addSubview:tishiLabel];
}

- (void)initDealTableView
{
    //商品列表TableView的加载
    self.dealTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TransparentBarHeight) style:UITableViewStylePlain];
    self.dealTableView.backgroundColor =[UIColor colorWithRed:(255.0f)/255.0f green:(255.0f)/255.0f blue:(255.0f)/255.0f alpha:1];
    self.dealTableView.delegate = self;
    self.dealTableView.dataSource = self;
    [self.dealView addSubview:self.dealTableView];
    
    [self.dealTableView registerClass:[DealTableViewCell class] forCellReuseIdentifier:DealTableViewCellIdentifier];
    
    [self addDealHeader];
    [self addDealFooter];
}

- (void)initAskNullView
{
    self.askNullView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,MainScreenWidth,MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    self.askNullView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1];
    [self.askView addSubview:self.askNullView];
    
    UILabel *tishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f,150, 300.0f, 30.0f)];
    tishiLabel.text = [NSString stringWithFormat:@"咨询回复为空"];
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    tishiLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1];
    tishiLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.askNullView addSubview:tishiLabel];
}

- (void)initAskTableView
{
    //商品列表TableView的加载
    self.askTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TransparentBarHeight) style:UITableViewStylePlain];
    self.askTableView.backgroundColor =[UIColor colorWithRed:(255.0f)/255.0f green:(255.0f)/255.0f blue:(255.0f)/255.0f alpha:1];
    self.askTableView.delegate = self;
    self.askTableView.dataSource = self;
    [self.askView addSubview:self.askTableView];
    
    [self.askTableView registerClass:[AskTableViewCell class] forCellReuseIdentifier:AskTableViewCellIdentifier];
    
    [self addAskHeader];
    [self addAskFooter];
}

- (void)addSysHeader
{
    __unsafe_unretained MessageViewController *messageViewController = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.scrollView = self.sysTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        self.downUp = 0;
        self.value = 1;
        [self callSysMessageListWebService];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [messageViewController performSelector:@selector(doneWithSysView:) withObject:refreshView afterDelay:2.0];
        
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

- (void)addSysFooter
{
    __unsafe_unretained MessageViewController *messageViewController = self;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    
    footer.scrollView = self.sysTableView;
    
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        self.downUp = 1;
        if(self.sysMessageList.count%10 == 0)
        {
            self.value = (int)(self.sysMessageList.count/10)+1;
            [self callSysMessageListWebService];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [messageViewController performSelector:@selector(doneWithSysView:) withObject:refreshView afterDelay:2.0];
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    
    _footer = footer;
}

- (void)doneWithSysView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.sysTableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

- (void)addDealHeader
{
    __unsafe_unretained MessageViewController *messageViewController = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.scrollView = self.dealTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        self.downUp2 = 0;
        self.value2 = 1;
        [self callDealMessageListWebService];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [messageViewController performSelector:@selector(doneWithDealView:) withObject:refreshView afterDelay:2.0];
        
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

- (void)addDealFooter
{
    __unsafe_unretained MessageViewController *messageViewController = self;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    
    footer.scrollView = self.dealTableView;
    
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        self.downUp2 = 1;
        if(self.dealMessageList.count%10 == 0)
        {
            self.value2 = (int)(self.dealMessageList.count/10)+1;
            [self callDealMessageListWebService];
        }

        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [messageViewController performSelector:@selector(doneWithDealView:) withObject:refreshView afterDelay:2.0];
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    
    _footer = footer;
}

- (void)doneWithDealView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.dealTableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

- (void)addAskHeader
{
    __unsafe_unretained MessageViewController *messageViewController = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.scrollView = self.askTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        self.downUp3 = 0;
        self.value3 = 1;
        [self callAskMessageListWebService];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [messageViewController performSelector:@selector(doneWithAskView:) withObject:refreshView afterDelay:2.0];
        
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

- (void)addAskFooter
{
    __unsafe_unretained MessageViewController *messageViewController = self;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    
    footer.scrollView = self.askTableView;
    
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block
        self.downUp3 = 1;
        if(self.askMessageList.count%10 == 0)
        {
            self.value3 = (int)(self.askMessageList.count/10)+1;
            [self callAskMessageListWebService];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [messageViewController performSelector:@selector(doneWithAskView:) withObject:refreshView afterDelay:2.0];
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    
    _footer = footer;
}

- (void)doneWithAskView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.askTableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

//-------------------------------UITableView------------------------//
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //遮挡无数据部分tableView的分割线
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    tableView.separatorInset = UIEdgeInsetsMake(0.0f,10.0f,0.0f,10.0f);
    tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.sysTableView)
    {
        if (self.sysMessageList.count == 0)
        {
            self.sysTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        else
        {
            self.sysTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        return self.sysMessageList.count;
    }
    else if(tableView == self.dealTableView)
    {
        if (self.dealMessageList.count == 0)
        {
            self.dealTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        else
        {
            self.dealTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        
        return self.dealMessageList.count;
    }
    else
    {
        if (self.askMessageList.count == 0)
        {
            self.askTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        else
        {
            self.askTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        
        return self.askMessageList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.sysTableView)
    {
        SysTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SysTableViewCellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[SysTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SysTableViewCellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        SysMessage *sysMessage =  self.sysMessageList[indexPath.row];
        cell.sysMessage = sysMessage;
        
        return cell;
    }
    else if (tableView == self.dealTableView)
    {
        DealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DealTableViewCellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[DealTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DealTableViewCellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        DealMessage *dealMessage =  self.dealMessageList[indexPath.row];
        cell.dealMessage = dealMessage;
        
        return cell;
    }
    else
    {
        AskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AskTableViewCellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[AskTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AskTableViewCellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        AskMessage *askMessage =  self.askMessageList[indexPath.row];
        cell.askMessage = askMessage;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.sysTableView)
    {
        SysMessage *sysMessage = [self.sysMessageList objectAtIndex:indexPath.row];
        
        CGSize sysMessageContentSize = [sysMessage.content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]}];
        
        if(sysMessageContentSize.width > 2*300.0f)
        {
            NSInteger addNumberOfLines;
            float yushu = fmodf(sysMessageContentSize.width-2*300.0f,300.0f);
            
            if (yushu == 0.0f)
            {
                addNumberOfLines = (NSInteger)((sysMessageContentSize.width-2*300.0f)/300.0f);
            }
            else
            {
                addNumberOfLines = (NSInteger)((sysMessageContentSize.width-2*300.0f)/300.0f+1);
            }
            
            return 70.0f+addNumberOfLines*15.51f;
        }
        
        return 70.0f;
    }
    else if(tableView == self.dealTableView)
    {
        DealMessage *dealMessage = [self.dealMessageList objectAtIndex:indexPath.row];
        
        CGSize dealMessageContentSize = [dealMessage.content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]}];
        
        if(dealMessageContentSize.width > 2*300.0f)
        {
            NSInteger addNumberOfLines = 0;
            
            float yushu = fmodf(dealMessageContentSize.width-2*300.0f,300.0f);
            
            if (yushu == 0.0f)
            {
                addNumberOfLines = (NSInteger)((dealMessageContentSize.width-2*300.0f)/300.0f);
            }
            else
            {
                addNumberOfLines = (NSInteger)((dealMessageContentSize.width-2*300.0f)/300.0f+1);
            }
            return 70.0f+addNumberOfLines*15.51f;
        }

        return 70.0f;
    }
    else
    {
        AskMessage *askMessage = [self.askMessageList objectAtIndex:indexPath.row];
        
        CGSize askContentSize = [askMessage.askContent sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]}];
        
        double contentHeight = 0.00f;
        
        if(askContentSize.width > 2*300.0f)
        {
            NSInteger addNumberOfLines = 0;
            
            double yushu = fmod(askContentSize.width-2*300.0f,300.0f);
            
            if (yushu == 0.0f)
            {
                addNumberOfLines = (NSInteger)((askContentSize.width-2*300.0f)/300.0f);
            }
            else
            {
                addNumberOfLines = (NSInteger)((askContentSize.width-2*300.0f)/300.0f+1);
            }
            
            contentHeight = (2+addNumberOfLines)*askContentSize.height;
        }
        else
        {
            contentHeight = 2*askContentSize.height;
        }
        
        CGSize answerContentSize = [askMessage.answerContent sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]}];
        
        if(answerContentSize.width > 300.0f)
        {
            NSInteger addNumberOfLines = 0;
            
            double yushu = fmod(answerContentSize.width-300.0f,300.0f);
            
            if (yushu == 0.0f)
            {
                addNumberOfLines = (NSInteger)((answerContentSize.width-300.0f)/300.0f);
            }
            else
            {
                addNumberOfLines = (NSInteger)((answerContentSize.width-300.0f)/300.0f+1);
            }
            
            contentHeight = contentHeight +(addNumberOfLines+2)*answerContentSize.height;
        }
        else
        {
            contentHeight = contentHeight + 2*answerContentSize.height;
        }
        
        return contentHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.sysTableView)
    {
        SysMessage *sysMessage = [self.sysMessageList objectAtIndex:indexPath.row];
        
        SysMessageDetailViewController *sysMessageDetailViewController = [[SysMessageDetailViewController alloc]initWithNibName:@"SysMessageDetailViewController" bundle:nil];
        sysMessageDetailViewController.mid = sysMessage.mid;
        [self.navigationController pushViewController:sysMessageDetailViewController animated:YES];
    }
}

/**************************获取系统消息列表接口*******************************/
- (IBAction)reLoadSysView:(id)sender
{
    self.downUp = 0;
    self.value = 1;
    [self callSysMessageListWebService];
}

- (void)callSysMessageListWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/account/message_list"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSLog(@"urlString = %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestSysMessageFailed:)];
    [request setDidFinishSelector:@selector(requestSysMessageFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    [param setValue:[NSString stringWithFormat:@"%d",self.value] forKey:@"value"];
    [param setValue:[NSString stringWithFormat:@"1"] forKey:@"type"];
    NSString *paramJson = [param JSONRepresentation];
    NSLog(@"paramJson = %@",paramJson);
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在加载";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestSysMessageFinished:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSString *responseString =[request responseString];
        
        NSLog(@"responseString = %@",responseString);
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dataDictionary = %@",dataDictionary);
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        NSLog(@"data = %@",data);
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 0)
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            
            [self.sysView insertSubview:self.sysNullView aboveSubview:self.sysTableView];
            
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"查询失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            NSArray *sysMessageList = [data objectForKey:@"result"];
            
            if (sysMessageList.count == 0)
            {
                [self.sysView insertSubview:self.sysNullView aboveSubview:self.sysTableView];
            }
            else
            {
                if (![self resolveSysMessage:sysMessageList])
                {
                    //解析失败
                    [self.sysView insertSubview:self.sysNullView aboveSubview:self.sysTableView];
                }
                else
                {
                    [self.sysTableView reloadData];
                    [self.sysView insertSubview:self.sysTableView aboveSubview:self.sysNullView];
                }
            }
            
        }
    }
}

- (void)requestSysMessageFailed:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    [self.sysView insertSubview:self.sysNullView aboveSubview:self.sysTableView];
    
    request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
    request.hud.mode = MBProgressHUDModeCustomView;
    request.hud.removeFromSuperViewOnHide = YES;
    request.hud.labelText = @"网络异常";
    request.hud.detailsLabelText = @"请检查网络重试";
}

- (BOOL)resolveSysMessage:(NSArray *)sysMessageList
{
    if (self.downUp == 0)
    {
        [self.sysMessageList removeAllObjects];
    }
    
    for(NSDictionary *sysMessageDictionary in sysMessageList)
    {
        SysMessage *sysMessage = [[SysMessage alloc]init];
        sysMessage.mid = [[sysMessageDictionary objectForKey:@"mid"]intValue];
        sysMessage.title = [sysMessageDictionary objectForKey:@"subject"];
        sysMessage.content = [sysMessageDictionary objectForKey:@"message"];
        [self.sysMessageList addObject:sysMessage];
    }
    return YES;
}

/*****************************获取交易消息列表接口**********************************/
- (IBAction)reLoadDealView:(id)sender
{
    self.downUp2 = 0;
    self.value2 = 1;
    [self callDealMessageListWebService];
}

- (void)callDealMessageListWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/account/message_list"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSLog(@"urlString = %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestDealMessageFailed:)];
    [request setDidFinishSelector:@selector(requestDealMessageFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    [param setValue:[NSString stringWithFormat:@"%d",self.value2] forKey:@"value"];
    [param setValue:[NSString stringWithFormat:@"2"] forKey:@"type"];
    NSString *paramJson = [param JSONRepresentation];
    NSLog(@"paramJson = %@",paramJson);
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在加载";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestDealMessageFinished:(ASIHTTPRequest *)request
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
        
        NSLog(@"dataDictionary = %@",dataDictionary);
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        NSLog(@"data = %@",data);
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 0)
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            [self.dealView insertSubview:self.dealNullView aboveSubview:self.dealTableView];
            
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"查询失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            NSArray *dealMessageListArray = [data objectForKey:@"result"];
            
            if (dealMessageListArray.count == 0)
            {
                [self.dealView insertSubview:self.dealNullView aboveSubview:self.dealTableView];
            }
            else
            {
                if (![self resolveDealMessage:dealMessageListArray])
                {
                    [self.dealView insertSubview:self.dealNullView aboveSubview:self.dealTableView];
                }
                else
                {
                    [self.dealTableView reloadData];
                    [self.dealView insertSubview:self.dealTableView aboveSubview:self.dealNullView];
                }
            }
            
        }
    }
}

- (void)requestDealMessageFailed:(ASIHTTPRequest *)request
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

- (BOOL)resolveDealMessage:(NSArray *)dealMessageListArray
{
    if (self.downUp2 == 0)
    {
        [self.dealMessageList removeAllObjects];
    }
    
    for(NSDictionary *dealMessageDictionary in dealMessageListArray)
    {
        DealMessage *dealMessage = [[DealMessage alloc]init];
        dealMessage.mid = [[dealMessageDictionary objectForKey:@"mid"]intValue];
        dealMessage.title = [dealMessageDictionary objectForKey:@"subject"];
        dealMessage.content = [dealMessageDictionary objectForKey:@"message"];
        [self.dealMessageList addObject:dealMessage];
    }
    return YES;
}

/*****************************获取咨询回复列表接口**********************************/
- (IBAction)reLoadAskView:(id)sender
{
    self.downUp3 = 0;
    self.value3 = 1;
    [self callAskMessageListWebService];
}

- (void)callAskMessageListWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/app/advisory_list"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSLog(@"urlString = %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestAskMessageFailed:)];
    [request setDidFinishSelector:@selector(requestAskMessageFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    [param setValue:[NSString stringWithFormat:@"%d",self.value2] forKey:@"value"];
    NSString *paramJson = [param JSONRepresentation];
    NSLog(@"paramJson = %@",paramJson);
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在加载";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestAskMessageFinished:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSString *responseString =[request responseString];
        
        NSLog(@"3333333333 responseString = %@",responseString);
        
        //官方的Json速度最快
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dataDictionary = %@",dataDictionary);
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        NSLog(@"data = %@",data);
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 0)
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            [self.askView insertSubview:self.askNullView aboveSubview:self.askTableView];
            
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"查询失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            NSArray *askMessageListArray = [data objectForKey:@"result"];
            
            if (askMessageListArray.count == 0)
            {
                [self.askView insertSubview:self.askNullView aboveSubview:self.askTableView];
            }
            else
            {
                if (![self resolveAskMessage:askMessageListArray])
                {
                    [self.askView insertSubview:self.askNullView aboveSubview:self.askTableView];
                    
                    request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
                    request.hud.mode = MBProgressHUDModeCustomView;
                    request.hud.removeFromSuperViewOnHide = YES;
                    request.hud.labelText = @"解析失败";
                }
                else
                {
                    [self.askTableView reloadData];
                    [self.askView insertSubview:self.askTableView aboveSubview:self.askNullView];
                }
            }
        }
    }
}

- (void)requestAskMessageFailed:(ASIHTTPRequest *)request
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

- (BOOL)resolveAskMessage:(NSArray *)askMessageListArray
{
    if (self.downUp3 == 0)
    {
        [self.askMessageList removeAllObjects];
    }

    for(NSDictionary *askMessageDictionary in askMessageListArray)
    {
        AskMessage *askMessage = [[AskMessage alloc]init];
        askMessage.gid = [[askMessageDictionary objectForKey:@"gid"]intValue];
       
        if ([[askMessageDictionary objectForKey:@"msg"] isEqualToString:@"0"]
            ||[[askMessageDictionary objectForKey:@"msg"] isEqualToString:@"(null)"]
            ||[[askMessageDictionary objectForKey:@"msg"] isEqualToString:@""])
        {
            askMessage.askContent = @"求回复";
        }
        else
        {
            askMessage.askContent = [askMessageDictionary objectForKey:@"msg"];
        }
        
        if ([[askMessageDictionary objectForKey:@"reply"] isEqualToString:@"0"]
            ||[[askMessageDictionary objectForKey:@"reply"] isEqualToString:@"(null)"]
            ||[[askMessageDictionary objectForKey:@"reply"] isEqualToString:@""])
        {
            askMessage.answerContent = @"暂无回复";
        }
        else
        {
            askMessage.answerContent = [askMessageDictionary objectForKey:@"reply"];
        }
        
        [self.askMessageList addObject:askMessage];
    }
    return YES;
}

@end
