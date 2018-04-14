//
//  MyCNstormViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-4-11.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "MyCNstormViewController.h"

#import "UIdefine.h"

NSString *const CellWithIdentifier = @"MyCNstormTableViewCell";

@interface MyCNstormViewController (SipCallbackEvents)

- (void)onAddBadgeValueEvent:(NSNotification*)notification;

@end

@implementation MyCNstormViewController (SipCallbackEvents)

- (void)initBadgeValue
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    BadgeKeyValue *badgeKeyValue = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:[NSString stringWithFormat:@"%lld",customer.customerid]]];
    
    if (badgeKeyValue.myStorageBadge == 0)
    {
        self.myStorageButton.badgeView.badgeText = [NSString stringWithFormat:@""];
    }
    else
    {
        self.myStorageButton.badgeView.badgeText = [NSString stringWithFormat:@"%d",badgeKeyValue.myStorageBadge];
    }
    
    if (badgeKeyValue.awaitReceiveBadge == 0)
    {
        self.awaitReceiveButton.badgeView.badgeText = [NSString stringWithFormat:@""];
    }
    else
    {
        self.awaitReceiveButton.badgeView.badgeText = [NSString stringWithFormat:@"%d",badgeKeyValue.awaitReceiveBadge];
    }

    if (badgeKeyValue.tabBadge4 == 0)
    {
        self.tabBarItem.badgeValue = 0;
    }
    else
    {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",badgeKeyValue.tabBadge4];
    }
    
    [self.tableView reloadData];
}

//通知中心接受到消息后，响应该方法
- (void)onAddBadgeValueEvent:(NSNotification*)notification
{
    [self initBadgeValue];
}

@end

@interface MyCNstormViewController ()

@end

@implementation MyCNstormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"我的", @"MyCNstorm");//UITabBarItem title
        [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(251.0f,110.0f,83.0f,1.0f), NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:12.0f], NSFontAttributeName,nil] forState:UIControlStateSelected];

        self.tabBarItem.image = [UIImage imageNamed:@"myCNstorm"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"myCNstorm_selected"];
        
        self.sectionArray = [NSMutableArray arrayWithCapacity:0];
        
        self.customer = [[Customer alloc]init];
        
        //设置通知中心
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAddBadgeValueEvent:) name:@"addBadgeValue" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.title = @"我的";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"set"] style:UIBarButtonItemStylePlain target:self action:@selector(pushSetView:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults boolForKey:@"isLogin"])
    {
        self.customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    }

    //初始化数据
    [self initTableViewData];
    
    //初始化页面
    [self initMyView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// 和这个警告有关:attempt to present uinavigationcontroller while a presentation is in progress
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"])
    {
        [self popLoginView];
    }
    else
    {
        [self viewDidLoad];
        
        [self callGetUserInfoWebService];
    }
    
    [self initBadgeValue];
}

- (void)initMyView
{
    self.view.frame = CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight);
    
    //滑动页面
    LeafScrollView *leaf = [[LeafScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height+CellHeight)];
    [self.view addSubview:leaf];
    
    leaf.beginUpdatingBlock = ^(LeafScrollView *view)
    {
        [self performSelector:@selector(endUpdating:) withObject:view afterDelay:2];
    };
    
    CGFloat imageSize = 59.0f;
    self.avaterImageView = [[PPAImageView alloc]initWithFrame:CGRectMake(22.5f, 21.0f, imageSize, imageSize) backgroundProgressColor:[UIColor whiteColor] progressColor:[UIColor lightGrayColor]];
    [leaf.scrollView addSubview:self.avaterImageView];
    [self.avaterImageView setImageURL:[NSString stringWithFormat:@"%@",self.customer.image]];
    
    self.userNameLable = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 18.0f, 200.0f, 23.0f)];
    self.userNameLable.text = [NSString stringWithFormat:@"%@",self.customer.username];
    self.userNameLable.textColor = RGBCOLOR(255.0f, 255.0f, 255.0f);
    self.userNameLable.font = [UIFont boldSystemFontOfSize:16.0f];
    self.userNameLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.userNameLable.numberOfLines = 1;
    self.userNameLable.textAlignment = NSTextAlignmentLeft;
    self.userNameLable.baselineAdjustment = UIBaselineAdjustmentNone;
    [leaf.scrollView addSubview:self.userNameLable];

    self.userJiFenLable = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 41.0f, 200.0f, 20.0f)];
    self.userJiFenLable.text = [NSString stringWithFormat:@"会员积分:%lld",self.customer.scores];
    self.userJiFenLable.textColor = RGBCOLOR(255.0f, 255.0f, 255.0f);
    self.userJiFenLable.font = [UIFont systemFontOfSize:13.0f];
    self.userJiFenLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.userJiFenLable.numberOfLines = 1;
    self.userJiFenLable.textAlignment = NSTextAlignmentLeft;
    self.userJiFenLable.baselineAdjustment = UIBaselineAdjustmentNone;
    [leaf.scrollView addSubview:self.userJiFenLable];
    
    self.userYuerLable = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 61.0f, 200.0f, 20.0f)];
    self.userYuerLable.text = [NSString stringWithFormat:@"账户余额:%.2f",self.customer.money];
    self.userYuerLable.textColor = RGBCOLOR(255.0f, 255.0f, 255.0f);
    self.userYuerLable.font = [UIFont systemFontOfSize:13.0f];
    self.userYuerLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.userYuerLable.numberOfLines = 1;
    self.userYuerLable.textAlignment = NSTextAlignmentLeft;
    self.userYuerLable.baselineAdjustment = UIBaselineAdjustmentNone;
    [leaf.scrollView addSubview:self.userYuerLable];
    
    //进入个人信息中心
    UIView *tapView = [[UIView alloc]initWithFrame:CGRectMake(240.0f,0.0f,80.0f,100.0f)];
    tapView.backgroundColor = [UIColor clearColor];
    tapView.userInteractionEnabled = YES;
    [leaf.scrollView addSubview:tapView];
    
    UIImageView *personAccessoryImageView = [[UIImageView alloc] initWithFrame: CGRectMake(40.0f,39.5f,12.0f,21.0f)];
    [personAccessoryImageView setImage:[UIImage imageNamed:@"personAccessory"]];
    personAccessoryImageView.userInteractionEnabled = NO;
    [tapView addSubview: personAccessoryImageView];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushPersonInfoView:)];
    tap1.numberOfTapsRequired = 1;//不同的实体数目
    [tapView addGestureRecognizer:tap1];
    
    //TableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 155.0f, 320.0f, 276.0f) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorColor = RGBCOLOR(229.0f, 229.0f, 229.0f);
    [leaf.scrollView addSubview:self.tableView];
    
    //待付款、待发货、待收货、我的仓库
    UIView *orderWayView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 100.0f, 320.0f, 55.0f)];
    orderWayView.backgroundColor = RGBCOLOR(255.0f, 255.0f, 255.0f);
    [orderWayView setAlpha:0.7f];
    [leaf.scrollView  addSubview:orderWayView];
    
    //待付款
    UIButton *awaitPayButton = [[UIButton alloc]initWithFrame:CGRectMake(37.0f, 10.5f, 24.0f, 23.5f)];
    [awaitPayButton setImage:[UIImage imageNamed:@"awaitPay"] forState:UIControlStateNormal];
    [awaitPayButton addTarget:self action:@selector(pushAwaitPayView:) forControlEvents:UIControlEventTouchUpInside];
    [orderWayView addSubview: awaitPayButton];
    
    UILabel *awaitPayLabel = [[UILabel alloc]initWithFrame:CGRectMake(26.0f, 34.0f, 46.0f, 23.0f)];
    awaitPayLabel.text = @"待付款";
    awaitPayLabel.textColor = RGBCOLOR(102.0f, 102.0f, 102.0f);
    awaitPayLabel.font = [UIFont systemFontOfSize:12.0f];
    awaitPayLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    awaitPayLabel.numberOfLines = 1;
    awaitPayLabel.textAlignment = NSTextAlignmentCenter;
    awaitPayLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    awaitPayLabel.userInteractionEnabled = YES;
    [orderWayView addSubview:awaitPayLabel];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushAwaitPayView:)];
    tap2.numberOfTapsRequired = 1;//不同的实体数目
    [awaitPayLabel addGestureRecognizer:tap2];
    
    //待发货
    UIButton *awaitSendButton = [[UIButton alloc]initWithFrame:CGRectMake(111.0f, 10.5f, 24.0f, 23.5f)];
    [awaitSendButton setImage:[UIImage imageNamed:@"awaitSend"] forState:UIControlStateNormal];
    [awaitSendButton addTarget:self action:@selector(pushAwaitSendView:) forControlEvents:UIControlEventTouchUpInside];
    [orderWayView addSubview: awaitSendButton];
    
    UILabel *awaitSendLabel = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 34.0f, 46.0f, 23.0f)];
    awaitSendLabel.text = @"待发货";
    awaitSendLabel.textColor = RGBCOLOR(102.0f, 102.0f, 102.0f);
    awaitSendLabel.font = [UIFont systemFontOfSize:12.0f];
    awaitSendLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    awaitSendLabel.numberOfLines = 1;
    awaitSendLabel.textAlignment = NSTextAlignmentCenter;
    awaitSendLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    awaitSendLabel.userInteractionEnabled = YES;
    [orderWayView addSubview:awaitSendLabel];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushAwaitSendView:)];
    tap3.numberOfTapsRequired = 1;//不同的实体数目
    [awaitSendLabel addGestureRecognizer:tap3];
    
    //待收货
    self.awaitReceiveButton = [[JSBadgeButton alloc]initWithFrame:CGRectMake(185.0f, 10.5f, 24.0f, 23.5f)];
    [self.awaitReceiveButton setImage:[UIImage imageNamed:@"awaitReceive"] forState:UIControlStateNormal];
    [self.awaitReceiveButton addTarget:self action:@selector(pushAwaitReceiveView:) forControlEvents:UIControlEventTouchUpInside];
    [orderWayView addSubview: self.awaitReceiveButton];
    
    UILabel *awaitReceiveLabel = [[UILabel alloc]initWithFrame:CGRectMake(174.0f, 34.0f, 46.0f, 23.0f)];
    awaitReceiveLabel.text = @"待收货";
    awaitReceiveLabel.textColor = RGBCOLOR(102.0f, 102.0f, 102.0f);
    awaitReceiveLabel.font = [UIFont systemFontOfSize:12.0f];
    awaitReceiveLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    awaitReceiveLabel.numberOfLines = 1;
    awaitReceiveLabel.textAlignment = NSTextAlignmentCenter;
    awaitReceiveLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    awaitReceiveLabel.userInteractionEnabled = YES;
    [orderWayView addSubview:awaitReceiveLabel];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushAwaitReceiveView:)];
    tap4.numberOfTapsRequired = 1;//不同的实体数目
    [awaitReceiveLabel addGestureRecognizer:tap4];
    
    //我的仓库
    self.myStorageButton = [[JSBadgeButton alloc]initWithFrame:CGRectMake(259.0f, 10.5f, 24.0f, 23.5f)];
    [self.myStorageButton setImage:[UIImage imageNamed:@"myStorage"] forState:UIControlStateNormal];
    [self.myStorageButton addTarget:self action:@selector(pushMyStorageView:) forControlEvents:UIControlEventTouchUpInside];
    [orderWayView addSubview: self.myStorageButton];
    
    UILabel *myStorageLabel = [[UILabel alloc]initWithFrame:CGRectMake(247.5f, 34.0f, 54.0f, 23.0f)];
    myStorageLabel.text = @"我的仓库";
    myStorageLabel.textColor = RGBCOLOR(102.0f, 102.0f, 102.0f);
    myStorageLabel.font = [UIFont systemFontOfSize:12.0f];
    myStorageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    myStorageLabel.numberOfLines = 1;
    myStorageLabel.textAlignment = NSTextAlignmentLeft;
    myStorageLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    myStorageLabel.userInteractionEnabled = YES;
    [orderWayView addSubview:myStorageLabel];
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushMyStorageView:)];
    tap5.numberOfTapsRequired = 1;//不同的实体数目
    [myStorageLabel addGestureRecognizer:tap5];
    
    //线条
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame: CGRectMake(86.0f,7.5f, 1.0f, 30.0f)];
    [imageView1 setImage:[UIImage imageNamed:@"myCNstormline"]];
    [orderWayView addSubview: imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame: CGRectMake(160.0f,7.5f, 1.0f, 30.0f)];
    [imageView2 setImage:[UIImage imageNamed:@"myCNstormline"]];
    [orderWayView addSubview: imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame: CGRectMake(234.0f,7.5f, 1.0f, 30.0f)];
    [imageView3 setImage:[UIImage imageNamed:@"myCNstormline"]];
    [orderWayView addSubview: imageView3];
    
    [self initBadgeValue];
}

- (void)endUpdating:(LeafScrollView *)view
{
    [view endUpdating];
    [self callGetUserInfoWebService];
}

- (void)initTableViewData
{
    NSString *myCNstormJson = [[NSBundle mainBundle]pathForResource:@"myCNstorm" ofType:@"json"];
    
    NSMutableArray *sectionMutableArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:myCNstormJson] options:NSJSONReadingMutableContainers error:nil];
    
    for (NSMutableArray *mySetionMutableArray in sectionMutableArray)
    {
        MySection *mySection = [[MySection alloc]init];
        
        for (NSMutableDictionary *myRowMutableDictionary in mySetionMutableArray)
        {
            MyRow *myRow = [[MyRow alloc]init];
            myRow.rowImageName = [myRowMutableDictionary objectForKey:@"rowImageName"];
            myRow.rowSelectedImageName = [myRowMutableDictionary objectForKey:@"rowSelectedImageName"];
            myRow.rowName = [myRowMutableDictionary objectForKey:@"rowName"];
            myRow.rowDetail = [myRowMutableDictionary objectForKey:@"rowDetail"];
            [mySection.myRowMutableArray addObject:myRow];
        }
        [self.sectionArray addObject:mySection];
    }
}

- (void)pushSetView:(id)sender
{
    SetViewController *setViewController = [[SetViewController alloc]initWithNibName:@"SetViewController" bundle:nil];
    setViewController.hidesBottomBarWhenPushed = YES;
    setViewController.delegate = self;
    [self.navigationController pushViewController:setViewController animated:YES];
}

- (void)pushPersonInfoView:(UITapGestureRecognizer *)tap
{
    PersonInfoViewController *personInfoViewController = [[PersonInfoViewController alloc]initWithNibName:@"PersonInfoViewController" bundle:nil];
    personInfoViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personInfoViewController animated:YES];
}

- (void)pushAwaitPayView:(id)sender
{
    AwaitPayViewController *awaitPayViewController = [[AwaitPayViewController alloc]initWithNibName:@"AwaitPayViewController" bundle:nil];
    awaitPayViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:awaitPayViewController animated:YES];
}

- (void)pushAwaitSendView:(id)sender
{
    AwaitSendViewController *awaitSendViewController = [[AwaitSendViewController alloc]initWithNibName:@"AwaitSendViewController" bundle:nil];
    awaitSendViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:awaitSendViewController animated:YES];
}

- (void)pushAwaitReceiveView:(id)sender
{
    AwaitReceiveViewController *awaitReceiveViewController = [[AwaitReceiveViewController alloc]initWithNibName:@"AwaitReceiveViewController" bundle:nil];
    awaitReceiveViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:awaitReceiveViewController animated:YES];
}

- (void)pushMyStorageView:(id)sender
{
    MyStorageViewController *myStorageViewController = [[MyStorageViewController alloc]initWithNibName:@"MyStorageViewController" bundle:nil];
    myStorageViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myStorageViewController animated:YES];
}


//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //遮挡无数据部分tableView的分割线
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    
    return self.sectionArray.count;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MySection *mySection =  self.sectionArray[section];
    return mySection.myRowMutableArray.count;
}

//缩进15px
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 15.0f;
}

//设置每行调用的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCNstormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                    CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[MyCNstormTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:CellWithIdentifier];
    }
    
    MySection *mySection =  self.sectionArray[indexPath.section];
    cell.myRow = mySection.myRowMutableArray[indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        cell.rowImageViewFram = CGRectMake(20.0f, 14.0f, 14.0f, 16.0f);
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        cell.rowImageViewFram = CGRectMake(20.0f, 14.0f, 16.0f, 16.0f);
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
        BadgeKeyValue *badgeKeyValue = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:[NSString stringWithFormat:@"%lld",customer.customerid]]];
        
        if (badgeKeyValue.allWayBadge == 0)
        {
            cell.jsBadgeView.badgeText = [NSString stringWithFormat:@""];
        }
        else
        {
            cell.jsBadgeView.badgeText = [NSString stringWithFormat:@"%d",badgeKeyValue.allWayBadge];
        }
    }
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        //人民币账户
        cell.rowImageViewFram = CGRectMake(20.0f, 16.0f, 18.0f, 13.0f);
    }
    else
    {
        cell.rowImageViewFram = CGRectMake(20.0f, 14.0f, 16.0f, 16.0f);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0 && indexPath.row == 0)
    {
        AllOrderViewController *allOrderViewController = [[AllOrderViewController alloc]initWithNibName:@"AllOrderViewController" bundle:nil];
        allOrderViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:allOrderViewController animated:YES];
    }
    else if(indexPath.section == 0 && indexPath.row == 1)
    {
        AllWayViewController *allWayViewController = [[AllWayViewController alloc]initWithNibName:@"AllWayViewController" bundle:nil];
        allWayViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:allWayViewController animated:YES];
    }
    else if(indexPath.section == 1 && indexPath.row == 0)
    {
        FavoriteViewController *favoriteViewController = [[FavoriteViewController alloc]initWithNibName:@"FavoriteViewController" bundle:nil];
        favoriteViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:favoriteViewController animated:YES];
    }
    else if(indexPath.section == 1 && indexPath.row == 1)
    {
        CouponViewController *couponViewController = [[CouponViewController alloc]initWithNibName:@"CouponViewController" bundle:nil];
        couponViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:couponViewController animated:YES];
    }
    else
    {
        RechargeViewController *rechargeViewController = [[RechargeViewController alloc]initWithNibName:@"RechargeViewController" bundle:nil];
        rechargeViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rechargeViewController animated:YES];
    }
}

//设置cell每行间隔的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.1f;
    }
    else
    {
        return 20.0f;
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
//    return view;
//}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
//    return view;
//}

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
    [self.view addSubview:hud];
    
    [self callGetUserInfoWebService];
}

- (void)didFinishedCancel:(LoginViewController *) loginViewController
{
    self.tabBarController.selectedIndex = 0;
}

- (void)didFinishedReturn:(SetViewController *) setViewController
{

}

- (void)didFinishedReturnTabBar:(NSUInteger)selectedIndex
{
    self.tabBarController.selectedIndex = selectedIndex;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/***************************获取用户信息接口******************************/
- (void)callGetUserInfoWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/user/getUserInfo"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setDidFinishSelector:@selector(requestLogin:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
}

- (void)requestLogin:(ASIHTTPRequest *)request
{
    if (![request error])
    {
        NSString *responseString =[request responseString];
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data= [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if (resultCode == 1)
        {
            NSDictionary *result = [data objectForKey:@"result"];
            Customer *updatecCustomer = [[Customer alloc]init];
            updatecCustomer.customerid = [[result objectForKey:@"customer_id"] longLongValue];
            updatecCustomer.email = [result objectForKey:@"email"];
            updatecCustomer.username = [result objectForKey:@"firstname"];//用户名／昵称
            updatecCustomer.tname = [result objectForKey:@"lastname"];//真实姓名
            updatecCustomer.password = [result objectForKey:@"password"];
            updatecCustomer.scores = [[result objectForKey:@"scores"] longLongValue];
            updatecCustomer.money = [[result objectForKey:@"money"] doubleValue];
            updatecCustomer.image = [result objectForKey:@"face"];
            updatecCustomer.verification = [result objectForKey:@"verification"];
            
            [self.avaterImageView setImageURL:[NSString stringWithFormat:@"%@",updatecCustomer.image]];
            self.userNameLable.text = [NSString stringWithFormat:@"%@",updatecCustomer.username];
            self.userJiFenLable.text = [NSString stringWithFormat:@"会员积分:%lld",updatecCustomer.scores];
            self.userYuerLable.text = [NSString stringWithFormat:@"账户余额:%.2f",updatecCustomer.money];

            [self initDataBase:updatecCustomer];
            //登录成功后保存登录的用户名
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setBool:YES forKey:@"isLogin"];
            [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:updatecCustomer] forKey:@"customer"];
            [[NSUserDefaults standardUserDefaults] synchronize];
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

/***************************数据库******************************/
- (void)initDataBase:(Customer *)customer
{
    SqliteHelper *helper = [[SqliteHelper alloc]initWithDataPath:[DataBaseInfo defaultDataBaseInfo].dbpath];
    @try
    {
        [helper OpenSqlite];
        [helper BeginTransaction];
        //将测试数据保存到sqlite
        if(![helper checkXubModelExist:customer])//检查数据库中是否有同一主键的行
            [helper InsertXubModel:customer throwEx:false];
        
        [helper CommitTransaction];
    }
    @catch (NSException *exception)
    {
        [helper RollbackTransaction];
    }
    @finally
    {
        [helper CloseSqlite];
    }
}

@end
