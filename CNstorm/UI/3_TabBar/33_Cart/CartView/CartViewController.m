//
//  CartViewController.m
//  CNstormUI
//
//  Created by EBS1 on 14-3-31.
//  Copyright (c) 2014年 CNstorm. All rights reserved.
//

#import "CartViewController.h"

@interface CartViewController ()

@end

@implementation CartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"购物车", @"Cart");
        [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(251.0f,110.0f,83.0f,1.0f), NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:12.0f], NSFontAttributeName,nil] forState:UIControlStateSelected];
        
        self.tabBarItem.image = [UIImage imageNamed:@"cart"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"cart_selected"];
        
        self.cart = [[Cart alloc]init];
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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    [titleLabel setText:@"购物车"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setTextColor:[UIColor whiteColor]];
    titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    self.navigationItem.titleView = titleLabel;
    
    [self initNullView];
    
    [self initView];
}

- (void)initView
{
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,MainScreenWidth,MainScreenHeight-TabBarHeight)];
    
    UIView *statusBar = [[UIView alloc] init];
    statusBar.frame = CGRectMake(0.0f, 0.0f, MainScreenWidth, StatusbarHeight);
    statusBar.backgroundColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:1];
    [self.myView addSubview:statusBar];
}

//初始化nullView
- (void)initNullView
{
    self.nullView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,MainScreenWidth,MainScreenHeight-TabBarHeight)];
    
    UIView *statusBar = [[UIView alloc] init];
    statusBar.frame = CGRectMake(0.0f, 0.0f, MainScreenWidth, StatusbarHeight);
    statusBar.backgroundColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:1];
    [self.nullView addSubview:statusBar];
    
    UILabel *tishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 150.0f, 300.0f, 30.0f)];
    tishiLabel.text = [NSString stringWithFormat:@"您的购物车空空如也"];
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    tishiLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1];
    tishiLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.nullView addSubview:tishiLabel];
    
    UIButton *gotoButton = [[UIButton alloc]initWithFrame:CGRectMake(110.0f, 200.0f, 100.0f,30.0f)];
    [gotoButton setTitle:@"去首页逛逛" forState:UIControlStateNormal];
    gotoButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [gotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    gotoButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [gotoButton.layer setCornerRadius:3.0f];
    gotoButton.layer.borderWidth = 0.5f;
    gotoButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [gotoButton addTarget:self action:@selector(gotoHomeView:) forControlEvents:UIControlEventTouchUpInside];
    [self.nullView addSubview:gotoButton];
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //隐藏购物车导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //判断是否登录
    //1.如果没有登录则弹出登录页面，登录后回到购物车页面
    //2.如果购物车还是空的，则去首页看看
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:@"isLogin"])
    {
        [self popLoginView];
    }
    else
    {
        self.view = self.nullView;
        //根据用户名,调用购物车接口  参数:用户名
        [self callCartDetailWebService];
    }
}

//购物车
- (void)initMyView
{
    self.view = self.myView;
    
    UIView *statusBar = [[UIView alloc] init];
    statusBar.frame = CGRectMake(0.0f, 0.0f, MainScreenWidth, StatusbarHeight);
    statusBar.backgroundColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:1];
    [self.myView addSubview:statusBar];
    
    //如果该用户购物车有商品则显示商品列表 合并店铺（掌柜名称）、商品id合并商品
    //商品信息列表tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f,StatusbarHeight, MainScreenWidth,MainScreenHeight-TabBarHeight-StatusbarHeight) style:UITableViewStylePlain];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.myView addSubview:self.tableView];
    
    UIView *transparentBarView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,MainScreenHeight-TabBarHeight-TransparentBarHeight,MainScreenWidth,TransparentBarHeight)];
    transparentBarView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.9f];
    transparentBarView.layer.borderWidth = 0.5f;
    transparentBarView.layer.borderColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:1].CGColor;
    [self.myView addSubview:transparentBarView];
    
    //全选/全不选  共计费用 提交（全部提交/部分提交）
    self.selectedButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 15.0f, 20.0f, 20.0f)];
    [self.selectedButton setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    [self.selectedButton setImage:[UIImage imageNamed:@"uncheck_selected"] forState:UIControlStateSelected];
    self.selectedButton.selected = self.cart.isAllSelected;
    [self.selectedButton addTarget:self action:@selector(selectedAll:) forControlEvents:UIControlEventTouchUpInside];
    [transparentBarView addSubview:self.selectedButton];
    
    //全选
    UILabel *allSelectedLabel = [[UILabel alloc]initWithFrame:CGRectMake(30.0f, 0.0f, 40.0f, 50.0f)];
    allSelectedLabel.text = [NSString stringWithFormat:@"全选"];
    allSelectedLabel.textAlignment = NSTextAlignmentCenter;
    allSelectedLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1];
    allSelectedLabel.font = [UIFont systemFontOfSize:14.0f];
    allSelectedLabel.userInteractionEnabled = YES;
    [transparentBarView addSubview:allSelectedLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAll:)];
    tap.numberOfTapsRequired = 1;
    [allSelectedLabel addGestureRecognizer:tap];
    
    //合计
    UILabel *totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(75.0f, 0.0f, 40.0f, 50.0f)];
    totalLabel.text = [NSString stringWithFormat:@"合计:"];
    totalLabel.textAlignment = NSTextAlignmentCenter;
    totalLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1];
    totalLabel.font = [UIFont systemFontOfSize:14.0f];
    [transparentBarView addSubview:totalLabel];
    
    //总计费用
    self.totalCostLabel = [[UILabel alloc]initWithFrame:CGRectMake(115.0f, 10.0f, 110.0f, 30.0f)];
    self.totalCostLabel.text = [NSString stringWithFormat:@"￥%.2f",self.cart.totalCost];
    self.totalCostLabel.textAlignment = NSTextAlignmentLeft;
    self.totalCostLabel.textColor = [UIColor colorWithRed:(253.0f)/255.0f green:(78.0f)/255.0f blue:(46.0f)/255.0f alpha:1];
    self.totalCostLabel.font = [UIFont systemFontOfSize:14.0f];
    self.totalCostLabel.numberOfLines = 2;
    [transparentBarView addSubview:self.totalCostLabel];
    
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(230.0f, 10.0f, 75.0f,30.0f)];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [commitButton.layer setCornerRadius:3.0f];
    commitButton.layer.borderWidth = 0.5f;
    commitButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [commitButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [transparentBarView addSubview:commitButton];
}

//没用
- (void)layoutSubviews
{
    int goodsCount = 0;
    for(StoreGoods *storeGoods in self.cart.storeGoodsArray)
    {
        goodsCount = goodsCount + (int)storeGoods.goodsArray.count;
    }
    
    float tableViewContentHeight = self.cart.storeGoodsArray.count*(CartTableViewHeaderViewHeight+TableViewFooterViewHeight)+goodsCount*100;
    self.tableView.contentSize = CGSizeMake(MainScreenWidth,tableViewContentHeight+TransparentBarHeight+1000);
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
    
    TableViewHeaderView *headerView = [[TableViewHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, CartTableViewHeaderViewHeight)];//创建一个视图
    headerView.selectedButton.selected = storeGoods.isSelected;
    [headerView.selectedButton setBackgroundImage:[UIImage imageNamed:@"uncheck_selected"] forState:UIControlStateSelected];
    [headerView.selectedButton setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    
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
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                               CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[CartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellWithIdentifier];
    }
    
    StoreGoods *storeGoods = self.cart.storeGoodsArray[indexPath.section];
    Goods *goods = storeGoods.goodsArray[indexPath.row];
    cell.goods = goods;
    
    [cell.selectedButton addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.remarkInfoLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRemarkInfoLabel:)]];
    
    [cell.buyQuantityInfoLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBuyQuantityInfoLabel:)]];
    
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
    
    StoreGoods *storeGoods = self.cart.storeGoodsArray[indexPath.section];
    Goods *goods = storeGoods.goodsArray[indexPath.row];
    goods.isSelected = !goods.isSelected;
    
    //刷新数据
    [self refreshDataAndView];
}

//设置选中的行所执行的动作
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

//设置划动cell是否出现del按钮，可供删除数据里进行处理
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    return YES;
//}

//设置删除时编辑状态
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        StoreGoods *storeGoods =  self.cart.storeGoodsArray[indexPath.section];
        Goods *deleteGoods = storeGoods.goodsArray[indexPath.row];
        
        [self callDeleteCartWebServiceWithKey:deleteGoods.key];
    }
}

/***********************************页面操作**************************************/
- (void)refreshDataAndView
{
    [self refreshData];
    
    //刷新tableView
    [self.tableView reloadData];
    
    self.selectedButton.selected = self.cart.isAllSelected;
    
    self.totalCostLabel.text = [NSString stringWithFormat:@"￥%.2f",self.cart.totalCost];
}

- (void)refreshData
{
    //按店铺计算运费、storeCost
    for (StoreGoods *storeGoods in self.cart.storeGoodsArray)
    {
        float storeGoodsStoreCost = 0.0f;
        float storeGoodsStoreYunFei = 0.0f;
        for (Goods *goodsItem in storeGoods.goodsArray)
        {
            if (goodsItem.isSelected)
            {
                storeGoodsStoreCost = storeGoodsStoreCost+goodsItem.realPrice*goodsItem.buyQuantity;
                storeGoodsStoreYunFei = goodsItem.yunfei > storeGoodsStoreYunFei ? goodsItem.yunfei : storeGoodsStoreYunFei;
            }
        }
        storeGoods.storeCost = storeGoodsStoreCost;
        storeGoods.storeYunFei = storeGoodsStoreYunFei;
    }
    
    //刷新全选按钮
    BOOL isAllSelected = YES;
    for (StoreGoods *storeGoodsItem in self.cart.storeGoodsArray)
    {
        BOOL isStoreGoodsSelected = YES;
        for (Goods *goods in storeGoodsItem.goodsArray)
        {
            isStoreGoodsSelected = isStoreGoodsSelected && goods.isSelected;
        }
        storeGoodsItem.isSelected = isStoreGoodsSelected;
        
        isAllSelected = isAllSelected && storeGoodsItem.isSelected;
    }
    self.cart.isAllSelected = isAllSelected;
    
    //计算总价
    float cartTotalCost = 0.0f;
    for (StoreGoods *storeGoods in self.cart.storeGoodsArray)
    {
        cartTotalCost = cartTotalCost + storeGoods.storeCost + storeGoods.storeYunFei;
    }
    self.cart.totalCost = cartTotalCost;
}

//点击全选按钮
- (void)selectedAll:(id)sender
{
    //全选按钮
    self.cart.isAllSelected = !self.cart.isAllSelected;
    self.selectedButton.selected = self.cart.isAllSelected;
    
    for(StoreGoods *storeGoods in self.cart.storeGoodsArray)
    {
        storeGoods.isSelected = self.cart.isAllSelected;
        for (Goods *goods in storeGoods.goodsArray)
        {
            goods.isSelected = self.cart.isAllSelected;
        }
    }
    
    //刷新tableView、更新数据
    [self refreshDataAndView];
}

//提交
- (void)commit:(id)sender
{
    [self commitCartWebService];
}

//修改备注
- (void)tapRemarkInfoLabel:(id)sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UILabel *remarkLabel = (UILabel *)tap.view;
    
    ZSYPopoverListView *listView = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0, 0, 250, 140)];
    listView.titleName.text = @"修改备注";
    listView.remarkField.text = remarkLabel.text;
    [listView.remarkField becomeFirstResponder];
    listView.remarkField.delegate = self;
    
    __unsafe_unretained ZSYPopoverListView *popoverView = listView;
    
    [listView setCancelButtonTitle:@"取消" block:^{}];
    
    [listView setDoneButtonWithTitle:@"确定" block:^{
        
        remarkLabel.text = popoverView.remarkField.text;
        //获取cell CartTableViewCell-UITableViewCellScrollView-UITableViewCellContentView-UITextField
        CartTableViewCell *cell = nil;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            cell = (CartTableViewCell *)remarkLabel.superview.superview.superview;
        }
        else
        {
            cell = (CartTableViewCell *)remarkLabel.superview.superview.superview.superview;
        }
        
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        //更新数据
        StoreGoods *storeGoods =  self.cart.storeGoodsArray[indexPath.section];
        Goods *goods = storeGoods.goodsArray[indexPath.row];
        
        //如果数量输入值＝0或者不是数字则赋值为1，如果数量输入值>库存则赋值为库存值
        int buyQuantityTextInt = [cell.buyQuantityInfoLabel.text intValue];
        
        if (!cell.remarkInfoLabel.text||[cell.remarkInfoLabel.text isEqualToString:@"(null)"])
        {
            cell.remarkInfoLabel.text = [NSString stringWithFormat:@""];
        }
        
        //调用修改备注、数量接口
        [self callUpdateCartWebServiceWithKey:goods.key andRemark:cell.remarkInfoLabel.text andQuantity:buyQuantityTextInt];
    }];
    
    [listView show];
}

- (void)tapBuyQuantityInfoLabel:(id)sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UILabel *buyQuantityInfoLabel = (UILabel *)tap.view;
    
    ZSYPopoverView *listView = [[ZSYPopoverView alloc] initWithFrame:CGRectMake(0, 0, 250, 140)];
    listView.titleName.text = @"修改数量";
    listView.buyQuantityTextField.text = buyQuantityInfoLabel.text;
    
    __unsafe_unretained ZSYPopoverView *popoverView = listView;
    
    [listView setCancelButtonTitle:@"取消" block:^{}];
    
    [listView setDoneButtonWithTitle:@"确定" block:^{
        
        buyQuantityInfoLabel.text = popoverView.buyQuantityTextField.text;
        //获取cell CartTableViewCell-UITableViewCellScrollView-UITableViewCellContentView-UITextField
        CartTableViewCell *cell = nil;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            cell = (CartTableViewCell *)buyQuantityInfoLabel.superview.superview.superview;
        }
        else
        {
            cell = (CartTableViewCell *)buyQuantityInfoLabel.superview.superview.superview.superview;
        }
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        //更新数据
        StoreGoods *storeGoods =  self.cart.storeGoodsArray[indexPath.section];
        Goods *goods = storeGoods.goodsArray[indexPath.row];
        
        //如果数量输入值＝0或者不是数字则赋值为1，如果数量输入值>库存则赋值为库存值
        int buyQuantityTextInt = [cell.buyQuantityInfoLabel.text intValue];
        
        if (!cell.remarkInfoLabel.text||[cell.remarkInfoLabel.text isEqualToString:@"(null)"])
        {
            cell.remarkInfoLabel.text = [NSString stringWithFormat:@""];
        }
        
        //调用修改备注、数量接口
        [self callUpdateCartWebServiceWithKey:goods.key andRemark:cell.remarkInfoLabel.text andQuantity:buyQuantityTextInt];
    }];
    
    [listView show];
}

/***********************************备注名 键盘***********************************/
- (void)selectedButtonClick:(id)sender
{
    CGPoint pos = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:pos];
    
    StoreGoods *storeGoods =  self.cart.storeGoodsArray[indexPath.section];
    Goods *goods = storeGoods.goodsArray[indexPath.row];
    goods.isSelected = !goods.isSelected;
    
    //刷新数据
    [self refreshDataAndView];
}

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
}

- (void)didFinishedCancel:(LoginViewController *) loginViewController
{
    //取消登录后或登录失败
    self.tabBarController.selectedIndex = 0;
}

- (IBAction)gotoHomeView:(id)sender
{
    self.tabBarController.selectedIndex = 0;
}

/**************************查询购物车详情接口*******************************/
//重载商品详情view:myView
- (IBAction)reLoadMyView:(id)sender
{
    [self callCartDetailWebService];
}

//查询购物车列表接口
- (void)callCartDetailWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/cart/cart"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
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
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];
    
    NSLog(@"paramJson = %@",paramJson);
    
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
    
    self.view = self.nullView;
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
            
            self.view = self.nullView;
        }
        else
        {
            NSDictionary *result = [data objectForKey:@"result"];
            
            if (result.count == 0)
            {
                self.view = self.nullView;
            }
            else
            {
                //解析商品详情数据
                if ([self resolveCartDetail:result])
                {
                    //重新加载移除myView上面的view
                    for (UIView *view in self.myView.subviews)
                    {
                        [view removeFromSuperview];
                    }
                    
                    //初始化视图
                    [self initMyView];
                }
            }
        }
    }
}

- (BOOL)resolveCartDetail:(NSDictionary *)result
{
    //清空上一次刷新数据
    self.cart = [[Cart alloc]init];
    
    if ([result objectForKey:@"products"])
    {
        NSArray *goodsList = [result objectForKey:@"products"];
        
        //过滤并合并店铺名
        NSMutableArray *storeNameArray = [[NSMutableArray alloc]init];
        
        //获取店铺名称
        for(NSDictionary *goodsDictionary in goodsList)
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
        
        for(NSDictionary *goodsDictionary in goodsList)
        {
            Goods *goods = [[Goods alloc]init];
            
            if ([goodsDictionary objectForKey:@"key"])
            {
                goods.key = [goodsDictionary objectForKey:@"key"];
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
            
            //            if ([goodsDictionary objectForKey:@"kucun"])
            //            {
            //                goods.kucun = [[goodsDictionary objectForKey:@"kucun"]intValue];
            //            }
            
            //按店铺分类
            for (StoreGoods *storeGoods in self.cart.storeGoodsArray)
            {
                if ([storeGoods.storeName isEqualToString:goods.storeName])
                {
                    [storeGoods.goodsArray addObject:goods];
                }
            }
        }
        
        [self refreshData];
        
        return YES;
    }
    else
    {
        return NO;
    }
}

/**************************修改、删除购物车接口*******************************/
- (void)callUpdateCartWebServiceWithKey:(NSString *)key andRemark:(NSString *)remark andQuantity:(int)quantity
{
    //业务逻辑 1.修改购物车－修改备注、购买数量
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/cart/cart_update"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestCartUpdateFailed:)];
    [request setDidFinishSelector:@selector(requestCartUpdateFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%@",key] forKey:@"productId"];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    [param setValue:[NSString stringWithFormat:@"%@",remark] forKey:@"remark"];
    [param setValue:[NSString stringWithFormat:@"%d",quantity] forKey:@"quantity"];
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在修改";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestCartUpdateFailed:(ASIHTTPRequest *)request
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

- (void)requestCartUpdateFinished:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSData *responseData = request.responseData;
        
        //官方的Json速度最快
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 0)
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"修改失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            [self callCartDetailWebService];
        }
    }
}

- (void)callDeleteCartWebServiceWithKey:(NSString *)key
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/cart/cart_delete"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
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
    [param setValue:key forKey:@"productId"];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    
    NSString *paramJson = [param JSONRepresentation];
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
        NSData *responseData = request.responseData;
        
        //官方的Json速度最快
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
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
        }
    }
}

/**************************提交购物车接口*******************************/
- (void)commitCartWebService
{
    /*业务逻辑
     1.勾选商品－提交购物车时，全选、部分选、全不选;更新购物车;生成待付款订单
     1.1.提交勾选的部分商品
     1.2.生成待付款订单
     1.2.删除勾选的商品
     */
    
    //生成勾选的购物车
    Cart *selectedCart = [[Cart alloc]init];
    selectedCart.isAllSelected = YES;//此值没有作用
    selectedCart.totalCost = self.cart.totalCost;
    
    //没有深copy，每一项都需要深copy
    for (StoreGoods *storeGoodsItem in self.cart.storeGoodsArray)
    {
        StoreGoods *tempStoreGoods = [[StoreGoods alloc]init];
        tempStoreGoods.goodsArray = [storeGoodsItem.goodsArray mutableCopy];//深copy
        tempStoreGoods.storeName = storeGoodsItem.storeName;
        tempStoreGoods.storeYunFei = storeGoodsItem.storeYunFei;
        tempStoreGoods.isSelected = storeGoodsItem.isSelected;
        [selectedCart.storeGoodsArray addObject:tempStoreGoods];
    }
    
    for (int i=0; i<selectedCart.storeGoodsArray.count; i++)
    {
        StoreGoods *storeGoodsItem = [selectedCart.storeGoodsArray objectAtIndex:i];
        
        for(int j=0; j<storeGoodsItem.goodsArray.count; j++)
        {
            Goods *goodsItem = [storeGoodsItem.goodsArray objectAtIndex:j];
            if(!goodsItem.isSelected)
            {
                [storeGoodsItem.goodsArray removeObjectAtIndex:j];
                j--;
            }
        }
        
        if (storeGoodsItem.goodsArray.count == 0)
        {
            [selectedCart.storeGoodsArray removeObjectAtIndex:i];
            i--;
        }
    }
    
    if(selectedCart.storeGoodsArray.count > 0)
    {
        [self commitCartDetailWithSelectedCart:selectedCart];
    }
    else
    {
        [MBProgressHUD showError:@"请选择一项商品" toView:self.view];
    }
}

- (void)commitCartDetailWithSelectedCart:(Cart *)cart
{
    //没有深copy，每一项都需要深copy
    NSMutableDictionary *keyQuantityDictionary = [[NSMutableDictionary alloc]init];
    for (StoreGoods *storeGoodsItem in cart.storeGoodsArray)
    {
        for(Goods *goodsItem in storeGoodsItem.goodsArray)
        {
            [keyQuantityDictionary setValue:[NSString stringWithFormat:@"%d",goodsItem.buyQuantity] forKey:goodsItem.key];
        }
    }
    
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/cart/cart_submit"];
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
    [param setValue:keyQuantityDictionary forKey:@"products"];
    NSString *paramJson = [param JSONRepresentation];
    
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在提交";
    request.hud.square = YES;
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
        //NSString *responseString =[request responseString];
        
        NSData *responseData = request.responseData;
        
        //官方的Json速度最快
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        NSDictionary *result = [data objectForKey:@"result"];
        
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
            NSMutableArray *orderIds = [result objectForKey:@"order_ids"];
            NSString *orderIdsStr = [orderIds componentsJoinedByString:@","];
            
            OrderPayViewController *orderPayViewController = [[OrderPayViewController alloc]initWithNibName:@"OrderPayViewController" bundle:nil];
            orderPayViewController.hidesBottomBarWhenPushed = YES;
            orderPayViewController.delegate = self;
            orderPayViewController.orderIdsStr = orderIdsStr;
            orderPayViewController.orderTotalCost = self.cart.totalCost;
            [self.navigationController pushViewController:orderPayViewController animated:YES];
        }
    }
}

@end
