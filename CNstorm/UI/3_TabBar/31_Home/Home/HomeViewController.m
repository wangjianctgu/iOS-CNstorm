//
//  HomeViewController.m
//  CNstorm
//
//  Created by EBS1 on 14-3-31.
//  Copyright (c) 2014年 CNstorm. All rights reserved.
//

#import "HomeViewController.h"

NSString *const HomeTableViewCellIdentifier = @"HomeTableViewCellIdentifier";

@interface HomeViewController (SipCallbackEvents)

- (void)onAddBadgeValueEvent:(NSNotification*)notification;

@end

@implementation HomeViewController (SipCallbackEvents)

- (void)initBadgeValue
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    BadgeKeyValue *badgeKeyValue = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:[NSString stringWithFormat:@"%lld",customer.customerid]]];
    
    if (badgeKeyValue.messageBadge == 0)
    {
        self.navigationItem.leftBarButtonItem.badgeValue = [NSString stringWithFormat:@""];
    }
    else
    {
        self.navigationItem.leftBarButtonItem.badgeValue = [NSString stringWithFormat:@"%d",badgeKeyValue.messageBadge];
    }
}

//通知中心接受到消息后，响应该方法
- (void)onAddBadgeValueEvent:(NSNotification*)notification
{
    [self initBadgeValue];
}

@end


@interface HomeViewController ()
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@property (nonatomic) Reachability *hostReachability;//不用全局，检测网络不会起到效果

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        self.title = NSLocalizedString(@"首页", @"SearchGoods");
        [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(251.0f,110.0f,83.0f,1.0f), NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:12.0f], NSFontAttributeName,nil] forState:UIControlStateSelected];
        
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"home_selected"];
        
        //设置通知中心
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAddBadgeValueEvent:) name:@"addMessageBadgeValue" object:nil];
        
        self.goodsList = [NSMutableArray arrayWithCapacity:0];
        self.urlArray = [NSMutableArray arrayWithCapacity:0];
        self.placeholderArray = [NSMutableArray arrayWithCapacity:0];
        self.categoryId = 0;//表示所有分类的商品
        self.loginType = 0;
    }
    return self;
}

- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:
        {
            [MBProgressHUD showError:@"网络不可用,请检查网络重试" toView:self.view];
            break;
        }
            
        case ReachableViaWWAN:
        {
            self.downUp = 0;
            self.value = 1;
            [self callGoodsListWebService];
            break;
        }
            
        case ReachableViaWiFi:
        {
            self.downUp = 0;
            self.value = 1;
            [self callGoodsListWebService];
            break;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    NSString *remoteHostName = @"www.apple.com";
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    
    //解决iOS7适配问题，导航栏遮挡了view，通常前两句就能解决问题，不行加后两句
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    UIImage *image = [UIImage imageNamed:@"bell"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    [button addTarget:self action:@selector(messageView:) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = navLeftButton;
    [self initBadgeValue];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tools"] style:UIBarButtonItemStylePlain target:self action:@selector(toolboxView:)];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 220.0f, 29.0f)];
    titleView.backgroundColor = [UIColor colorWithRed:(227.0f/255.0f) green:(91.0f/255.0f) blue:(63.0f/255.0f) alpha:1.0f];
    titleView.layer.cornerRadius = 6.0f;
    
    UIImageView *searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(62.5f,8.25f, 12.5f, 12.5f)];
    [searchImageView setImage:[UIImage imageNamed:@"searchIcon"]];
    searchImageView.userInteractionEnabled = YES;
    [titleView addSubview:searchImageView];
    
    UILabel *searchLabel = [[UILabel alloc]initWithFrame:CGRectMake(75.0f, 0.0f, 70.0f, 29.0f)];
    searchLabel.text = [NSString stringWithFormat:@"搜寻商品"];
    searchLabel.textColor = [UIColor colorWithRed:(169.0f/255.0f) green:(49.0f/255.0f) blue:(25.0f/255.0f) alpha:1.0f];
    searchLabel.textAlignment = NSTextAlignmentCenter;
    searchLabel.font = [UIFont systemFontOfSize:13.0f];
    searchLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    searchLabel.numberOfLines = 1;
    searchLabel.adjustsFontSizeToFitWidth = YES;
    searchLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [titleView addSubview:searchLabel];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchView:)];
    tap1.numberOfTapsRequired = 1;
    [titleView addGestureRecognizer:tap1];
    
    self.navigationItem.titleView = titleView;
    
    [self initMyView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self initBadgeValue];
}

- (void)initMyView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TabBarHeight)];
    [self.view addSubview:self.scrollView];
    
    [self initScrollImageView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0.0f, HomeScrollImageViewHeight,MainScreenWidth, 180.0f)];
    view.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:view];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 4.0f, MainScreenWidth, 1.0f)];
    lineView1.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [view addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 101.0f, MainScreenWidth, 1.0f)];
    lineView2.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [view addSubview:lineView2];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 105.0f, MainScreenWidth, 1.0f)];
    lineView3.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [view addSubview:lineView3];
    
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 180.0f, MainScreenWidth, 1.0f)];
    lineView4.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [view addSubview:lineView4];
    
    //    UIView *verticalLine1 = [[UIView alloc]initWithFrame:CGRectMake(106.0f, 15.0f, 1.0f, 80.0f)];
    //    verticalLine1.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    //    [view addSubview:verticalLine1];
    //
    //    UIView *verticalLine2 = [[UIView alloc]initWithFrame:CGRectMake(213.5f, 15.0f, 1.0f, 80.0f)];
    //    verticalLine2.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    //    [view addSubview:verticalLine2];
    
    UIView *verticalLine = [[UIView alloc]initWithFrame:CGRectMake(159.5f, 115.0f, 1.0f, 55.0f)];
    verticalLine.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [view addSubview:verticalLine];
    
    //代购
    UIView *replaceBuyView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,5.0f,106.0f, 95.0f)];
    replaceBuyView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [replaceBuyView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(replaceBuyView:)]];
    [view addSubview:replaceBuyView];
    
    UIButton *replaceBuyButton = [[UIButton alloc]initWithFrame:CGRectMake(33.0f, 20.0f, 40.0f, 40.0f)];
    [replaceBuyButton setBackgroundImage:[UIImage imageNamed:@"replaceBuy"] forState:UIControlStateNormal];
    replaceBuyButton.userInteractionEnabled = NO;
    [replaceBuyView addSubview:replaceBuyButton];
    
    UILabel *replaceBuyLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.5f, 65.0f, 75.0f, 20.0f)];
    replaceBuyLabel.text = @"代购服务";
    replaceBuyLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    replaceBuyLabel.font = [UIFont systemFontOfSize:14.0f];
    replaceBuyLabel.numberOfLines = 1;
    replaceBuyLabel.textAlignment = NSTextAlignmentCenter;
    replaceBuyLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [replaceBuyView addSubview:replaceBuyLabel];
    
    //自助购
    UIView *selfBuyView = [[UIView alloc]initWithFrame:CGRectMake(107.0f,5.0f,106.0f, 95.0f)];
    selfBuyView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [selfBuyView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfBuyView:)]];
    [view addSubview:selfBuyView];
    
    UIButton *selfBuyButton = [[UIButton alloc]initWithFrame:CGRectMake(33.0f, 20.0f, 40.0f, 40.0f)];
    [selfBuyButton setBackgroundImage:[UIImage imageNamed:@"selfBuy"] forState:UIControlStateNormal];
    selfBuyButton.userInteractionEnabled = NO;
    [selfBuyView addSubview:selfBuyButton];
    
    UILabel *selfBuyLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.5f, 65.0f, 75.0f, 20.0f)];
    selfBuyLabel.text = @"自助购";
    selfBuyLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    selfBuyLabel.font = [UIFont systemFontOfSize:14.0f];
    selfBuyLabel.numberOfLines = 1;
    selfBuyLabel.textAlignment = NSTextAlignmentCenter;
    selfBuyLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [selfBuyView addSubview:selfBuyLabel];
    
    //代寄
    UIView *transportView = [[UIView alloc]initWithFrame:CGRectMake(214.0f,5.0f,106.0f, 95.0f)];
    transportView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [transportView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(transportView:)]];
    [view addSubview:transportView];
    
    UIButton *transportButton = [[UIButton alloc]initWithFrame:CGRectMake(33.0f, 20.0f, 40.0f, 40.0f)];
    [transportButton setBackgroundImage:[UIImage imageNamed:@"transport"] forState:UIControlStateNormal];
    transportButton.userInteractionEnabled = NO;
    [transportView addSubview:transportButton];
    
    UILabel *transportLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.5f, 65.0f, 75.0f, 20.0f)];
    transportLabel.text = @"我要代寄";
    transportLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    transportLabel.font = [UIFont systemFontOfSize:14.0f];
    transportLabel.numberOfLines = 1;
    transportLabel.textAlignment = NSTextAlignmentCenter;
    transportLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [transportView addSubview:transportLabel];
    
    //国际转运
    UIView *wayView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,106.0f,159.5f,75.0f)];
    wayView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [wayView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wayTransportView:)]];
    [view addSubview:wayView];
    
    UILabel *wayTransportLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 15.0f, 60.0f, 20.0f)];
    wayTransportLabel.text = @"国际转运";
    wayTransportLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    wayTransportLabel.font = [UIFont systemFontOfSize:14.0f];
    wayTransportLabel.numberOfLines = 1;
    wayTransportLabel.textAlignment = NSTextAlignmentLeft;
    wayTransportLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayView addSubview:wayTransportLabel];
    
    UIButton *wayTransportButton = [[UIButton alloc]initWithFrame:CGRectMake(94.5f, 5.0f, 60.0f, 60.0f)];
    [wayTransportButton setBackgroundImage:[UIImage imageNamed:@"wayTransport"] forState:UIControlStateNormal];
    wayTransportButton.userInteractionEnabled = NO;
    [wayView addSubview:wayTransportButton];
    
    UILabel *wayTransportInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 45.0f, 100.0f, 20.0f)];
    wayTransportInfoLabel.text = @"便捷，高效，专业！";
    wayTransportInfoLabel.textColor = [UIColor colorWithRed:(128.0f/255.0f) green:(128.0f/255.0f) blue:(128.0f/255.0f) alpha:1.0f];
    wayTransportInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    wayTransportInfoLabel.numberOfLines = 1;
    wayTransportInfoLabel.textAlignment = NSTextAlignmentLeft;
    wayTransportInfoLabel.adjustsFontSizeToFitWidth = YES;
    wayTransportInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [wayView addSubview:wayTransportInfoLabel];
    
    //评价
    UIView *evaluationView = [[UIView alloc]initWithFrame:CGRectMake(160.5f, 106.0f,159.5f, 74.0f)];
    evaluationView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [evaluationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(evaluationView:)]];
    [view addSubview:evaluationView];
    
    UILabel *evaluationLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 15.0f, 60.0f, 20.0f)];
    evaluationLabel.text = @"最新评价";
    evaluationLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    evaluationLabel.font = [UIFont systemFontOfSize:14.0f];
    evaluationLabel.numberOfLines = 1;
    evaluationLabel.textAlignment = NSTextAlignmentLeft;
    evaluationLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [evaluationView addSubview:evaluationLabel];
    
    UIButton *evaluationButton = [[UIButton alloc]initWithFrame:CGRectMake(88.0f, 5.0f, 60.0f, 60.0f)];
    [evaluationButton setBackgroundImage:[UIImage imageNamed:@"evaluation"] forState:UIControlStateNormal];
    evaluationButton.userInteractionEnabled = NO;
    [evaluationView addSubview:evaluationButton];
    
    UILabel *evaluationInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 45.0f, 88.0f, 20.0f)];
    evaluationInfoLabel.text = @"看看大家怎么说？";
    evaluationInfoLabel.textColor = [UIColor colorWithRed:(128.0f/255.0f) green:(128.0f/255.0f) blue:(128.0f/255.0f) alpha:1.0f];
    evaluationInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    evaluationInfoLabel.numberOfLines = 1;
    evaluationInfoLabel.textAlignment = NSTextAlignmentLeft;
    evaluationInfoLabel.adjustsFontSizeToFitWidth = YES;
    evaluationInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [evaluationView addSubview:evaluationInfoLabel];
    
    //推荐购
    UIView *loveView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 320.0f,MainScreenWidth, 25.0f)];
    loveView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    loveView.layer.borderColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f].CGColor;
    loveView.layer.borderWidth = 0.5f;
    [self.scrollView addSubview:loveView];
    
    UILabel *loveLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 25.0f)];
    loveLabel.text = @"推荐购";
    loveLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    loveLabel.font = [UIFont systemFontOfSize:14.0f];
    loveLabel.numberOfLines = 1;
    loveLabel.textAlignment = NSTextAlignmentLeft;
    loveLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [loveView addSubview:loveLabel];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 345.0f, MainScreenWidth,1000.0f) style:UITableViewStylePlain];
    //self.tableView.scrollEnabled = NO;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.scrollView addSubview:self.tableView];
    
    [self.tableView registerClass:[GoodsListTableViewCell class] forCellReuseIdentifier:HomeTableViewCellIdentifier];
    
    [self addHomeHeader];
    
    [self addHeader];
    
    [self addFooter];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0.0f, 345.0f, MainScreenWidth,self.goodsList.count*100);
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, 345.0f+self.goodsList.count*100.0f);
}

- (void)addHomeHeader
{
    __unsafe_unretained HomeViewController *homeViewController = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    
    header.scrollView = self.scrollView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 进入刷新状态就会回调这个Block,调用接口，获取数据
        [self callLunBoWebService];
        // 模拟延迟加载数据，因此2秒后才调用）,这里的refreshView其实就是header
        [homeViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        
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
    
    //[header beginRefreshing];//首次刷新
    
    _header = header;
}


- (void)addHeader
{
    __unsafe_unretained HomeViewController *homeViewController = self;
    
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
        [homeViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        
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
    
    [header beginRefreshing];//首次刷新
    
    _header = header;
}

- (void)addFooter
{
    __unsafe_unretained HomeViewController *homeViewController = self;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    
    footer.scrollView = self.scrollView;
    
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
        [homeViewController performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    
    [_header free];
    [_footer free];
}

//---------------------------MyView----------------------------//
//初始化商品图片轮播
-(void)initScrollImageView
{
    
    self.urlArray = [@[@"http://www.cnstorm.com/catalog/view/theme/cnstorm/images/banner_login.jpg",@"http://www.cnstorm.com/catalog/view/theme/cnstorm/images/student_vefity.jpg",@"http://www.cnstorm.com/catalog/view/theme/cnstorm/images/banner_buy.jpg",@"http://www.cnstorm.com/catalog/view/theme/cnstorm/images/favorite_banner_4.jpg",@"http://www.cnstorm.com/catalog/view/theme/cnstorm/images/favorite_banner_3.jpg",@"http://www.cnstorm.com/catalog/view/theme/cnstorm/images/banner_class.jpg"]mutableCopy];
    
    // 定时器 循环
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    
    // 初始化 scrollImageView
    self.scrollImageView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, HomeScrollImageViewHeight)];
    self.scrollImageView.bounces = YES;
    self.scrollImageView.pagingEnabled = YES;
    self.scrollImageView.delegate = self;
    self.scrollImageView.userInteractionEnabled = YES;
    self.scrollImageView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:self.scrollImageView];
    
    // 初始化 pagecontrol
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(110.0f, HomeScrollImageViewHeight-15.0f,100.0f,7.5f)]; // 初始化mypagecontrol
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f]];
    [self.pageControl setPageIndicatorTintColor:[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.5f]];
    self.pageControl.userInteractionEnabled = YES;
    
    self.pageControl.numberOfPages = [self.urlArray count];
    self.pageControl.currentPage = 0;
    [self.pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    
    [self.scrollView addSubview:self.pageControl];
    
    [self loadScollImageView];
}

//加载ScollImageView图片数据
- (void)loadScollImageView
{
    // 1.创建UIImageView
    self.placeholderArray = [@[@"banner1.png",@"banner2.png",@"banner3.png",@"banner4.png",@"banner5.png",@"banner6.png"]mutableCopy];
    
    UIImage *placeholder = [UIImage imageNamed:@"default140"];
    
    for (int i = 0; i < self.urlArray.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((MainScreenWidth * i)+MainScreenWidth,0.0f, MainScreenWidth, HomeScrollImageViewHeight);
        // 下载图片
        [imageView setImageURLStr:self.urlArray[i] placeholder:placeholder];
        // 事件监听
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        // 内容模式
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollImageView addSubview:imageView];
    }
    
    // 取数组最后一张图片 放在第0页
    UIImageView *zoroImageView = [[UIImageView alloc] init];
    zoroImageView.frame = CGRectMake(0.0f, 0.0f, MainScreenWidth,HomeScrollImageViewHeight);// 添加最后1页在首页循环
    // 下载图片
    [zoroImageView setImageURLStr:self.urlArray[[self.urlArray count]-1] placeholder:placeholder];
    // 事件监听
    zoroImageView.tag = [self.urlArray count]-1;
    zoroImageView.userInteractionEnabled = YES;
    [zoroImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
    
    // 内容模式
    zoroImageView.clipsToBounds = YES;
    zoroImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.scrollImageView addSubview:zoroImageView];
    
    
    // 取数组第一张图片 放在最后1页
    UIImageView *lastImageView = [[UIImageView alloc] init];
    lastImageView.frame = CGRectMake((MainScreenWidth * ([self.urlArray count] + 1)) , 0.0f,MainScreenWidth, HomeScrollImageViewHeight); // 添加第1页在最后 循环
    
    // 下载图片
    [lastImageView setImageURLStr:self.urlArray[0] placeholder:placeholder];
    
    // 事件监听
    lastImageView.tag = 0;
    lastImageView.userInteractionEnabled = YES;
    [lastImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
    
    // 内容模式
    lastImageView.clipsToBounds = YES;
    lastImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.scrollImageView addSubview:lastImageView];
    
    
    [self.scrollImageView setContentSize:CGSizeMake(MainScreenWidth * ([self.urlArray count] + 2), HomeScrollImageViewHeight)]; //+上第1页和第4页  原理:4-[1-2-3-4]-1
    
    [self.scrollImageView setContentOffset:CGPointMake(0.0f, 0.0f)];
    
    [self.scrollImageView scrollRectToVisible:CGRectMake(MainScreenWidth, 0.0f, MainScreenWidth,HomeScrollImageViewHeight) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    //    SpecialViewController *specialViewController = [[SpecialViewController alloc] initWithNibName:@"SpecialViewController" bundle:nil];
    //    specialViewController.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:specialViewController animated:YES];
}

//scrollView 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.scrollImageView.frame.size.width;
    
    int page = floor((self.scrollImageView.contentOffset.x - pagewidth/([self.urlArray count]+2))/pagewidth)+1;
    
    page--;  // 默认从第二页开始
    
    self.pageControl.currentPage = page;
}

// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //CGFloat pagewidth = self.scrollImageView.frame.size.width;
    
    //int currentPage = floor((self.scrollImageView.contentOffset.x - pagewidth/ ([self.urlArray count]+2)) / pagewidth) + 1;
    
    int currentPage = (int)self.scrollImageView.contentOffset.x/MainScreenWidth; // 和上面两行效果一样
    
    if (currentPage == 0)
    {
        [self.scrollImageView scrollRectToVisible:CGRectMake(MainScreenWidth * [self.urlArray count],0.0f,MainScreenWidth,HomeScrollImageViewHeight) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage == ([self.urlArray count] + 1))
    {
        [self.scrollImageView scrollRectToVisible:CGRectMake(MainScreenWidth, 0.0f, MainScreenWidth, HomeScrollImageViewHeight) animated:NO]; // 最后+1,循环第1页
    }
}

// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = (int)self.pageControl.currentPage; // 获取当前的page
    
    [self.scrollImageView scrollRectToVisible:CGRectMake(MainScreenWidth*(page+1),0.0f,MainScreenWidth,HomeScrollImageViewHeight) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
}

// 定时器 绑定的方法
- (void)runTimePage
{
    int page = (int)self.pageControl.currentPage; // 获取当前的page
    
    page++;
    
    page = page > (self.urlArray.count-1) ? 0 : page ;
    
    self.pageControl.currentPage = page;
    
    [self turnPage];
}

//-----------------------------页面操作------------------------//
- (void)searchView:(id)sender
{
    SearchViewController *searchViewController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionFade;
    //kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom;
    //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:searchViewController animated:NO];
    //[self presentViewController:searchViewController animated:NO completion:nil];
}

- (void)toolboxView:(id)sender
{
    ToolboxViewController *toolboxViewController = [[ToolboxViewController alloc] initWithNibName:@"ToolboxViewController" bundle:nil];
    toolboxViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:toolboxViewController animated:YES];
}

- (void)messageView:(id)sender
{
    //判断是否登录
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:@"isLogin"])
    {
        self.loginType = 0;
        [self popLoginView];
    }
    else
    {
        MessageViewController *messageViewController = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
        messageViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:messageViewController animated:YES];
    }
}

- (void)popLoginView
{
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    loginViewController.delegate = self;
    
    MJNavigationController *navigationController = [[MJNavigationController alloc]initWithRootViewController:loginViewController];
    navigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.tabBarController presentViewController:navigationController animated:YES completion:nil];
}

- (void)didFinishedLogin:(LoginViewController *) loginViewController andHud:(MBProgressHUD *)hud
{
    //[self.view addSubview:hud];
    //登录成功后
    if (self.loginType == 0)
    {
        MessageViewController *messageViewController = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
        messageViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:messageViewController animated:YES];
    }
    else
    {
        MyStorageViewController *myStorageViewController = [[MyStorageViewController alloc]initWithNibName:@"MyStorageViewController" bundle:nil];
        myStorageViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myStorageViewController animated:YES];
    }
    
}

- (void)didFinishedCancel:(LoginViewController *) loginViewController
{
    //取消登录后或登录失败
    self.tabBarController.selectedIndex = 0;
}

- (void)replaceBuyView:(id)sender
{
    ReplaceBuyViewController *replaceBuyViewController = [[ReplaceBuyViewController alloc] initWithNibName:@"ReplaceBuyViewController" bundle:nil];
    replaceBuyViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:replaceBuyViewController animated:YES];
}

- (void)selfBuyView:(id)sender
{
    SelfBuyViewController *selfBuyViewController = [[SelfBuyViewController alloc] initWithNibName:@"SelfBuyViewController" bundle:nil];
    selfBuyViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:selfBuyViewController animated:YES];
}

- (void)transportView:(id)sender
{
    TransportViewController *transportViewController = [[TransportViewController alloc] initWithNibName:@"TransportViewController" bundle:nil];
    transportViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:transportViewController animated:YES];
}

- (void)wayTransportView:(id)sender
{
    //判断是否登录
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:@"isLogin"])
    {
        self.loginType = 1;
        [self popLoginView];
    }
    else
    {
        MyStorageViewController *myStorageViewController = [[MyStorageViewController alloc]initWithNibName:@"MyStorageViewController" bundle:nil];
        myStorageViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myStorageViewController animated:YES];
    }
}

- (void)evaluationView:(id)sender
{
    EvaluationViewController *evaluationViewController = [[EvaluationViewController alloc]initWithNibName:@"EvaluationViewController" bundle:nil];
    evaluationViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:evaluationViewController animated:YES];
}

//-----------------------------UITableView------------------------//
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
    
    self.tableView.frame = CGRectMake(0.0f, 345.0f, MainScreenWidth,self.goodsList.count*100);
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, 345.0f+self.goodsList.count*100);
    
    return self.goodsList.count;
}

#pragma mark - 方法:cell的加载和复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeTableViewCellIdentifier forIndexPath:indexPath];
    
    if (cell==nil)
    {
        cell=[[GoodsListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomeTableViewCellIdentifier];
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
    goodsDetailViewController.hidesBottomBarWhenPushed = YES;
    Product *product = (Product *)[self.goodsList objectAtIndex:indexPath.row];
    goodsDetailViewController.url = product.location;
    goodsDetailViewController.productId = product.product_id;
    [self.navigationController pushViewController:goodsDetailViewController animated:YES];
}

/*****************************获取商品列表接口**********************************/
- (void)callGoodsListWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/product/product_list"];
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
    
    [param setValue:[NSString stringWithFormat:@"%lld",self.categoryId] forKey:@"categoryId"];
    
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
        
        NSLog(@"responseString = %@",responseString);
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        NSLog(@"data = %@",data);
        
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
            NSArray *goodsList = [data objectForKey:@"result"];
            //解析商品列表数据
            if (![self resolve:goodsList])
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
                [self.tableView reloadData];
            }
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self.tableView reloadData];
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, MainScreenHeight-NavigationBarHeight+1);
    
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
        product.quantity = [[goodsDictionary objectForKey:@"quantity"]intValue];
        product.isbn = [[goodsDictionary objectForKey:@"isbn"]floatValue];
        [self.goodsList addObject:product];
    }
    
    return YES;
}

/*****************************图片轮播接口**********************************/
- (void)callLunBoWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/app/luobo_list"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestLunboFailed:)];
    [request setDidFinishSelector:@selector(requestLunboFinished:)];
    [request startAsynchronous];//异步传输
}

- (void)requestLunboFinished:(ASIHTTPRequest *)request
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
            request.hud.labelText = @"";
            request.hud.detailsLabelText = errorMessage;
            request.hud.square = YES;
            [request.hud show:YES];
            [self.view addSubview:request.hud];
        }
        else
        {
            NSDictionary *result = [data objectForKey:@"result"];
            NSLog(@"result = %@",result);
        }
    }
}

- (void)requestLunboFailed:(ASIHTTPRequest *)request
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

@end
