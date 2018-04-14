//
//  SelfBuyViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-22.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "SelfBuyViewController.h"

NSString *const CartListTableViewCellIdentifier = @"CartListTableViewCell";

@interface SelfBuyViewController ()

@end

@implementation SelfBuyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.cart = [[Cart alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我要自助购";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self initView];
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


//初始化
- (void)initView
{
    self.segmentedControlView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,MainScreenWidth,TransparentBarHeight)];
    self.segmentedControlView.backgroundColor =[UIColor colorWithRed:(240.0f)/255.0f green:(240.0f)/255.0f blue:(240.0f)/255.0f alpha:1];
    [self.view addSubview:self.segmentedControlView];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"商品抓取",@"商品清单",nil];
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.segmentedControl.frame = CGRectMake(10.0f, 10.0f, 300.0f, 30.0f);
    self.segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    self.segmentedControl.tintColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1];
    [self.segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    [self.segmentedControl addTarget:self action:@selector(selectedSegmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    self.segmentedControl.layer.cornerRadius = 6.0f;
    self.segmentedControl.layer.borderWidth = 0.5f;
    self.segmentedControl.layer.borderColor = [UIColor colorWithRed:(195.0f)/255.0f green:(60.0f)/255.0f blue:(33.0f)/255.0f alpha:1].CGColor;
    [self.segmentedControlView addSubview:self.segmentedControl];
    
    [self initMyView];
    
    [self initScrollView];
}

- (void)selectedSegmentAction:(UISegmentedControl *)segmentedControl
{
    NSInteger index = segmentedControl.selectedSegmentIndex;
    
    switch (index)
    {
        case 0:
            self.segmentedControlView.backgroundColor =[UIColor colorWithRed:(240.0f)/255.0f green:(240.0f)/255.0f blue:(240.0f)/255.0f alpha:1];
            [self.view insertSubview:self.scrollView aboveSubview:self.myView];
            break;
            
        case 1:
        {
            [self.urlTextView resignFirstResponder];
            self.segmentedControlView.backgroundColor =[UIColor colorWithRed:(255.0f)/255.0f green:(255.0f)/255.0f blue:(255.0f)/255.0f alpha:1];
            [self.view insertSubview:self.myView aboveSubview:self.scrollView];
            
            //判断是否登录
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            if (![userDefaults boolForKey:@"isLogin"])
            {
                [self popLoginView];
            }
            else
            {
                [self callCartDetailWebService];
            }
            
            break;
        }
            
        default:
            break;
    }
}

- (void)initScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f,TransparentBarHeight, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f];
    [self.scrollView setScrollEnabled:YES];
    [self.view addSubview:self.scrollView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f,0.0f,290.0f, 15.0f)];
    titleLabel.text = [NSString stringWithFormat:@"请输入或粘贴您要自助购的商品网址:"];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.scrollView addSubview:titleLabel];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 20.0f, 300.0f, 80.0f)];
    view1.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view1.layer.cornerRadius = 6.0f;
    view1.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view1.layer.borderWidth = 0.5f;
    view1.userInteractionEnabled = YES;
    [self.scrollView addSubview:view1];
    
    self.urlTextView = [[UITextView alloc]initWithFrame:CGRectMake(5.0f,0.0f, 290.0f, 80.0f)];
    self.urlTextView.delegate = self;
    self.urlTextView.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.urlTextView.textAlignment = NSTextAlignmentLeft;
    [self.urlTextView setFont:[UIFont systemFontOfSize:14.0f]];
    self.urlTextView.returnKeyType = UIReturnKeyDone;//return键的类型
    self.urlTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.urlTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    [view1 addSubview:self.urlTextView];
    
    self.commitButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 110.0f, 300.0f,40.0f)];
    [self.commitButton setTitle:@"获取商品信息" forState:UIControlStateNormal];
    self.commitButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commitButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [self.commitButton.layer setCornerRadius:3.0f];
    self.commitButton.layer.borderWidth = 0.5f;
    self.commitButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [self.commitButton addTarget:self action:@selector(commitUrl:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.commitButton];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,MainScreenHeight-NavigationBarHeight-TransparentBarHeight+1.0f);
}

- (void)commitUrl:(id)sender
{
    [self.urlTextView resignFirstResponder];
    
    float yoffset = -(self.view.center.y-self.commitButton.center.y)+NavigationBarHeight+TransparentBarHeight;
    
    if([self.urlTextView.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请粘贴商品url地址" toYOffset:yoffset toView:self.view];
        return;
    }
    
    UrlGoodsDetailViewController *urlGoodsDetailViewController = [[UrlGoodsDetailViewController alloc] initWithNibName:@"UrlGoodsDetailViewController" bundle:nil];
    urlGoodsDetailViewController.url = self.urlTextView.text;
    urlGoodsDetailViewController.buyType = 2;
    [self.navigationController pushViewController:urlGoodsDetailViewController animated:YES];
}

- (void)initMyView
{
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,TransparentBarHeight,MainScreenWidth,MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    [self.view addSubview:self.myView];
    
    [self initTableView];
    [self initNullView];
}

- (void)initNullView
{
    //初始化nullView
    self.nullView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,MainScreenWidth,MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    self.nullView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1];
    [self.myView addSubview:self.nullView];
    
    UILabel *tishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f,150, 300.0f, 30.0f)];
    tishiLabel.text = [NSString stringWithFormat:@"您的自助购商品清单空空如也"];
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    tishiLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1];
    tishiLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.nullView addSubview:tishiLabel];
}

- (void)initTableView
{
    self.tView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TransparentBarHeight)];
    [self.myView addSubview:self.tView];
    
    //商品列表TableView的加载
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TransparentBarHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor =[UIColor colorWithRed:(255.0f)/255.0f green:(255.0f)/255.0f blue:(255.0f)/255.0f alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tView addSubview:self.tableView];
    
    [self.tableView registerClass:[SelfBuyCartTableViewCell class] forCellReuseIdentifier:CartListTableViewCellIdentifier];
    
    UIView *transparentBarView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,MainScreenHeight-NavigationBarHeight-2*TransparentBarHeight,MainScreenWidth,TransparentBarHeight)];
    transparentBarView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.9f];
    transparentBarView.layer.borderWidth = 0.5f;
    transparentBarView.layer.borderColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:1].CGColor;
    [self.tView addSubview:transparentBarView];
    
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(85.0f, 10.0f, 150.0f,30.0f)];
    [commitButton setTitle:@"生成自助购订单" forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [commitButton.layer setCornerRadius:3.0f];
    commitButton.layer.borderWidth = 0.5f;
    commitButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [commitButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [transparentBarView addSubview:commitButton];
}

//设置SectionHeader高度:
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CartTableViewHeaderViewHeight;
}

//自定义section的头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    StoreGoods *storeGoods = self.cart.storeGoodsArray[section];
    BOOL isStoreGoodsSelected = YES;
    for (Goods *goods in storeGoods.goodsArray)
    {
        isStoreGoodsSelected = isStoreGoodsSelected && goods.isSelected;
    }
    storeGoods.isSelected = isStoreGoodsSelected;
    
    SelfBuyTableViewHeaderView *headerView = [[SelfBuyTableViewHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, CartTableViewHeaderViewHeight)];//创建一个视图
    
    headerView.headerLabel.text = [NSString stringWithFormat:@"%@",storeGoods.storeName];
    if (storeGoods.storeYunFei != 0)
    {
        headerView.yunfeiLabel.text = [NSString stringWithFormat:@"运费:￥%.2f",storeGoods.storeYunFei];
    }
    return headerView;
}

//设置SectionHeader高度:
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return TableViewFooterViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footerView = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, TableViewFooterViewHeight)];//创建一个视图
    footerView.contentView.backgroundColor = [UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:(1.0f)];
    return footerView;
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //遮挡无数据部分tableView的分割线
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    
    return self.cart.storeGoodsArray.count;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    StoreGoods *storeGoods =  self.cart.storeGoodsArray[section];
    
    return storeGoods.goodsArray.count;
}

//设置每行调用的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置tableView.contentSize
    int goodsCount = 0;
    for(StoreGoods *storeGoods in self.cart.storeGoodsArray)
    {
        goodsCount = goodsCount + (int)storeGoods.goodsArray.count;
    }
    float tableViewContentHeight = self.cart.storeGoodsArray.count*(CartTableViewHeaderViewHeight+TableViewFooterViewHeight)+goodsCount*100;
    tableView.contentSize = CGSizeMake(MainScreenWidth,tableViewContentHeight+TransparentBarHeight);
    
    static NSString *CellWithIdentifier = @"Cell";
    SelfBuyCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                      CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[SelfBuyCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:CellWithIdentifier];
    }
    
    StoreGoods *storeGoods = self.cart.storeGoodsArray[indexPath.section];
    Goods *goods = storeGoods.goodsArray[indexPath.row];
    cell.goods = goods;
    return cell;
}

//设置cell每行间隔的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

//设置选中Cell的响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    //选中后的反显颜色即刻消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//设置选中的行所执行的动作
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

//设置删除时编辑状态
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        StoreGoods *storeGoods =  self.cart.storeGoodsArray[indexPath.section];
        Goods *deleteGoods = storeGoods.goodsArray[indexPath.row];
        
        [self callDeleteCartWebServiceWithProductId:deleteGoods.goodsId];
    }
}

/***********************************页面操作**************************************/
//提交
- (void)commit:(id)sender
{
    [self commitCartWebService];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(MainScreenHeight == 480.0f)
    {
        self.scrollView.contentSize = CGSizeMake(MainScreenWidth,MainScreenHeight-NavigationBarHeight-TransparentBarHeight+20.0f);
        
        [self.scrollView scrollRectToVisible:CGRectMake(0.0f,20.0f,MainScreenWidth,MainScreenHeight-NavigationBarHeight-TransparentBarHeight) animated:YES];
    }
    else if(MainScreenHeight == 568.0f)
    {
        self.scrollView.contentSize = CGSizeMake(320.0f,MainScreenHeight-NavigationBarHeight-TransparentBarHeight+1.0f);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    self.scrollView.contentSize = CGSizeMake(320.0f,MainScreenHeight-NavigationBarHeight-TransparentBarHeight+1.0f);
}

//控制输入文字的长度和内容，可通调用以下代理方法实现
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        //禁止输入换行
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

/*********************************登录***********************************/
//弹出登录视图
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
    [self callCartDetailWebService];
}

- (void)didFinishedCancel:(LoginViewController *) loginViewController
{
    //取消登录后或登录失败
    self.segmentedControlView.backgroundColor =[UIColor colorWithRed:(240.0f)/255.0f green:(240.0f)/255.0f blue:(240.0f)/255.0f alpha:1];
    [self.view insertSubview:self.scrollView aboveSubview:self.myView];
    self.segmentedControl.selectedSegmentIndex = 0;
    
    float yoffset = -(self.view.center.y-self.commitButton.center.y)+NavigationBarHeight+TransparentBarHeight;
    [MBProgressHUD showError:@"查看商品清单,请先登录" toYOffset:yoffset toView:self.view];
}


/**************************查询购物车详情接口*******************************/
//重载商品详情view:myView
- (IBAction)reLoadMyView:(id)sender
{
    [self callCartDetailWebService];
}

//获取用户名，调用查询购物车详情接口
- (void)callCartDetailWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/snatch/snatch_list"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSLog(@"urlString = %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestGetCartFailed:)];
    [request setDidFinishSelector:@selector(requestGetCartFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    NSLog(@"param = %@",param);
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在加载";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestGetCartFailed:(ASIHTTPRequest *)request
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
    
    [self.myView insertSubview:self.nullView aboveSubview:self.tView];
}


- (void)requestGetCartFinished:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSString *responseString =[request responseString];
        
        NSLog(@"responseString = %@",responseString);
        
        NSData *responseData = request.responseData;
        
        //官方的Json速度最快
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dataDictionary = %@",dataDictionary);
        
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
            
            [self.myView insertSubview:self.nullView aboveSubview:self.tView];
        }
        else
        {
            NSArray *result = [data objectForKey:@"result"];
            
            if (result.count == 0)
            {
                [self.myView insertSubview:self.nullView aboveSubview:self.tView];
            }
            else
            {
                //解析商品详情数据
                if ([self resolveCartDetail:result])
                {
                    [self.myView insertSubview:self.tView aboveSubview:self.nullView];
                    [self.tableView reloadData];
                }
            }
        }
    }
}

- (BOOL)resolveCartDetail:(NSArray *)result
{
    //清空上一次刷新数据
    self.cart = [[Cart alloc]init];
    //过滤并合并店铺名
    NSMutableArray *storeNameArray = [[NSMutableArray alloc]init];
    
    //获取店铺名称
    for(NSDictionary *goodsDictionary in result)
    {
        NSString *storeName = [goodsDictionary objectForKey:@"storename"];
        if (storeName)
        {
            if (![storeNameArray containsObject:storeName])
            {
                [storeNameArray addObject:storeName];
            }
        }
    }
    
    //创建storeName
    for (NSString *storeName in storeNameArray)
    {
        StoreGoods *storeGoods = [[StoreGoods alloc]init];
        
        storeGoods.storeName = storeName;
        
        [self.cart.storeGoodsArray addObject:storeGoods];
    }
    
    for(NSDictionary *goodsDictionary in result)
    {
        Goods *goods = [[Goods alloc]init];
        
        if ([goodsDictionary objectForKey:@"productId"])
        {
            goods.goodsId = [[goodsDictionary objectForKey:@"productId"]longLongValue];
        }
        
        if ([goodsDictionary objectForKey:@"name"])
        {
            goods.name = [goodsDictionary objectForKey:@"name"];
        }
        
        if ([goodsDictionary objectForKey:@"color"])
        {
            goods.color = [goodsDictionary objectForKey:@"color"];
        }
        
        if ([goodsDictionary objectForKey:@"quantity"])
        {
            goods.buyQuantity = [[goodsDictionary objectForKey:@"quantity"]intValue];
        }
        
        if ([goodsDictionary objectForKey:@"size"])
        {
            goods.buySize = [goodsDictionary objectForKey:@"size"];
        }
        
        if ([goodsDictionary objectForKey:@"thumb"])
        {
            goods.goodsImage = [goodsDictionary objectForKey:@"thumb"];
        }
        
        if ([goodsDictionary objectForKey:@"price"])
        {
            goods.realPrice = [[goodsDictionary objectForKey:@"price"]floatValue];
        }
        
        if ([goodsDictionary objectForKey:@"note"]&&![[goodsDictionary objectForKey:@"note"] isEqual:[NSNull null]])
        {
            goods.remark = [goodsDictionary objectForKey:@"note"];
        }
        else
        {
            goods.remark = @"";
        }
        
        if ([goodsDictionary objectForKey:@"storename"])
        {
            goods.storeName = [goodsDictionary objectForKey:@"storename"];
        }
        
        if ([goodsDictionary objectForKey:@"yunfei"])
        {
            goods.yunfei = [[goodsDictionary objectForKey:@"yunfei"]floatValue];
        }
        
        //按店铺分类
        for (StoreGoods *storeGoods in self.cart.storeGoodsArray)
        {
            if ([storeGoods.storeName isEqualToString:goods.storeName])
            {
                [storeGoods.goodsArray addObject:goods];
            }
        }
    }
    
    return YES;
}

/**************************删除购物车接口*******************************/
- (void)callDeleteCartWebServiceWithProductId:(long long)productId
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/snatch/snatch_delete"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSLog(@"urlString = %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    
    [request setRequestMethod:@"POST"];
    
    [request setTimeOutSeconds:kTimeInterval];
    
    [request setDelegate:self];
    
    [request setDidFailSelector:@selector(requestCartDeleteFailed:)];
    
    [request setDidFinishSelector:@selector(requestCartDeleteFinished:)];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%lld",productId] forKey:@"productId"];
    
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    
    NSString *paramJson = [param JSONRepresentation];
    
    NSLog(@"paramJson = %@",paramJson);
    
    [request setPostValue:paramJson forKey:@"param"];
    
    [request startAsynchronous];//异步传输
    
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在删除";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestCartDeleteFailed:(ASIHTTPRequest *)request
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

- (void)requestCartDeleteFinished:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSString *responseString =[request responseString];
        
        NSLog(@"responseString = %@",responseString);
        
        NSData *responseData = request.responseData;
        
        //官方的Json速度最快
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dataDictionary = %@",dataDictionary);
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        NSLog(@"data = %@",data);
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 0)
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"删除失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            [self callCartDetailWebService];
            //[self performSelector:@selector(callCartDetailWebService) withObject:nil afterDelay:2.0];
        }
    }
}


/**************************提交购物车接口*******************************/
- (void)commitCartWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/snatch/snatch_commit"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestCommitCartFailed:)];
    [request setDidFinishSelector:@selector(requestCommitCartFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在提交";
    request.hud.square = YES;
    request.hud.yOffset = -(self.view.center.y-self.commitButton.center.y)+NavigationBarHeight;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestCommitCartFailed:(ASIHTTPRequest *)request
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

- (void)requestCommitCartFinished:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSString *responseString =[request responseString];
        
        NSLog(@"responseString = %@",responseString);
        
        NSData *responseData = request.responseData;
        
        //官方的Json速度最快
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dataDictionary = %@",dataDictionary);
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 0)
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"提交失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            SelfBuyComViewController *selfBuyComViewController = [[SelfBuyComViewController alloc]initWithNibName:@"SelfBuyComViewController" bundle:nil];
            [self.navigationController pushViewController:selfBuyComViewController animated:YES];
        }
    }
}

@end
