//
//  SearchGoodsViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-12.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "SearchGoodsViewController.h"

@interface SearchGoodsViewController ()

@end

@implementation SearchGoodsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"搜索", @"SearchGoods");
        [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(251.0f,110.0f,83.0f,1.0f), NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:12.0f], NSFontAttributeName,nil] forState:UIControlStateSelected];
        
        self.tabBarItem.image = [UIImage imageNamed:@"searchGoods"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"searchGoods_selected"];
        
        self.goodsCategoryList = [NSMutableArray arrayWithCapacity:0];
        self.goodsSecondCategoryList = [NSMutableArray arrayWithCapacity:0];
        self.categoryImageList = [NSMutableArray arrayWithCapacity:0];
        self.categoryImageDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
        self.secondCategoryImageList = [NSMutableArray arrayWithCapacity:0];
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
    
    [self initTitleViewWithTitle:@"搜寻商品" andIsShowSearchBar:YES];
    
    self.categoryImageList = [@[@"clfs",@"jpxx",@"xbps",@"sjsm",@"shjj"]mutableCopy];
    
    [self.categoryImageDictionary setObject:[@[@"sz",@"nypj",@"jjf",@"ps",@"yz",@"nz",@"tz",@"qz",@"kz"]mutableCopy] forKey:@"clfs"];
    [self.categoryImageDictionary setObject:[@[@"xxx",@"lx",@"dx",@"pgx",@"fbx",@"tx",@"ddx",@"ydx",@"ggx"]mutableCopy] forKey:@"jpxx"];
    [self.categoryImageDictionary setObject:[@[@"bb",@"fs",@"pzsb",@"jz",@"lxx",@"zbss",@"yanj",@"ehed",@"xl"]mutableCopy] forKey:@"xbps"];
    [self.categoryImageDictionary setObject:[@[@"cdb",@"sj",@"dwyx",@"dn",@"xj",@"yjian",@"ydcc",@"ej",@"pj"]mutableCopy] forKey:@"sjsm"];
    [self.categoryImageDictionary setObject:[@[@"cfyp",@"jtqj",@"jfby",@"jzpz",@"jjry",@"zlsn",@"wjyp",@"xyyp",@"shjd"]mutableCopy] forKey:@"shjj"];
    
    [self initNullView];
    
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight-TabBarHeight)];
    [view setTag:100];
    [view setBackgroundColor:[UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:0.9f]];
    [self.view addSubview:view];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [self.activityIndicator setCenter:view.center];
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [view addSubview:self.activityIndicator];
    
    //调用分类接口
    [self callGoodsCategoryWebService];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

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

- (void)initNullView
{
    self.nullView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,MainScreenWidth,MainScreenHeight-NavigationBarHeight-TabBarHeight)];
    self.nullView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1];
    
    UILabel *loadFailedLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f,125,300.0f, 20.0f)];
    loadFailedLabel.text = [NSString stringWithFormat:@"数据加载失败"];
    loadFailedLabel.textAlignment = NSTextAlignmentCenter;
    loadFailedLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1];
    loadFailedLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.nullView addSubview:loadFailedLabel];
    
    UILabel *reloadLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f,150.0f, 300.0f, 20.0f)];
    reloadLabel.text = [NSString stringWithFormat:@"请检查一下网络，重新加载"];
    reloadLabel.textAlignment = NSTextAlignmentCenter;
    reloadLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1];
    reloadLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.nullView addSubview:reloadLabel];
    
    self.reloadButton = [[UIButton alloc]initWithFrame:CGRectMake(110.0f, 175.0f, 100.0f,30.0f)];
    [self.reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
    self.reloadButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.reloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.reloadButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [self.reloadButton.layer setCornerRadius:3.0f];
    self.reloadButton.layer.borderWidth = 0.5f;
    self.reloadButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [self.reloadButton addTarget:self action:@selector(reLoadMyView:) forControlEvents:UIControlEventTouchUpInside];
    [self.nullView addSubview:self.reloadButton];
}

//初始化分类列表页面
- (void)initGoodsCategoryListView
{
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight)];
    //分类列表TreeCell
    self.pushTreeView = [InfiniteTreeView loadFromXib];
    self.pushTreeView.frame = self.containerView.bounds;
    self.pushTreeView.dataSource = self;
    self.pushTreeView.delegate = self;
    [self.containerView addSubview:self.pushTreeView];
    self.view = self.containerView;
}

- (void)initTitleViewWithTitle:(NSString *)title andIsShowSearchBar:(BOOL)isShow
{
    if (isShow)
    {
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 304.0f, 29.0f)];
        titleView.backgroundColor = [UIColor colorWithRed:(227.0f/255.0f) green:(91.0f/255.0f) blue:(63.0f/255.0f) alpha:1.0f];
        titleView.layer.cornerRadius = 6.0f;
        
        UIImageView *searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(106.5f, 8.25f, 12.5f, 12.5f)];
        [searchImageView setImage:[UIImage imageNamed:@"searchIcon"]];
        searchImageView.userInteractionEnabled = YES;
        [titleView addSubview:searchImageView];
        
        UILabel *searchLabel = [[UILabel alloc]initWithFrame:CGRectMake(119.0f, 0.0f, 70.0f, 29.0f)];
        searchLabel.text = [NSString stringWithFormat:@"%@",title];
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
    }
    else
    {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 190.0f, 29.0f)];
        titleLabel.text = [NSString stringWithFormat:@"%@",title];
        titleLabel.textColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        titleLabel.numberOfLines = 1;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        self.navigationItem.titleView = titleLabel;
    }
}

/***********************************分类部分***********************************/
#pragma mark - PushTreeViewDataSource
//设置分类列表的层级level
- (NSInteger)numberOfSectionsInLevel:(NSInteger)level
{
    //一级、二级分类的section的数目都是1
    if (level == 0 || level == 1)
    {
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfRowsInLevel:(NSInteger)level section:(NSInteger)section
{
    if (level == 0)
    {
        if (section == 0)
        {
            return self.goodsCategoryList.count;
        }
    }
    else if (level == 1)
    {
        if (section == 0)
        {
            return self.goodsSecondCategoryList.count;
        }
    }
    //level=2情况暂时不存在，故暂返回为0
    return 0;
}

- (InfiniteTreeBaseCell *)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    if (level == 0)
    {
        static NSString *identifier = @"GoodsCategoryCell";
        GoodsCategoryCell *cell = (GoodsCategoryCell*)[pushTreeView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[GoodsCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        if (indexPath.row == 0)
        {
            cell.sitePoint = -1;//位置：顶端
        }
        else if (indexPath.row == self.goodsCategoryList.count-1)
        {
            cell.sitePoint = 1;//位置：中间部分
        }
        else
        {
            cell.sitePoint = 0;//位置：底部
        }
        
        GoodsCategory *goodsCategory = [self goodsCategoryFromSectionAndLevel:indexPath level:level];
        if (!goodsCategory.image||[goodsCategory.image isEqual:@""]||[goodsCategory.image isEqual:@"(null)"])
        {
            NSString *imageName = self.categoryImageList[indexPath.row];
            goodsCategory.image = imageName;
        }
        cell.goodsCategory = goodsCategory;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1];
        // handleSwipeFrom 是偵測到手势，所要呼叫的方法
        UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onBackBtnTouched:)];
        // 不同的 Recognizer 有不同的实体变数，例如 SwipeGesture 可以指定方向 而 TapGesture 則可以指定次數
        recognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [cell.contentView addGestureRecognizer:recognizer];
        
        return cell;
    }
    else
    {
        static NSString *GoodsSendCategoryCellIdentifier = @"GoodsSendCategoryCell";
        GoodsSendCategoryCell *cell = (GoodsSendCategoryCell *)[pushTreeView dequeueReusableCellWithIdentifier:GoodsSendCategoryCellIdentifier];
        if (cell == nil)
        {
            cell = [[GoodsSendCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GoodsSendCategoryCellIdentifier];
        }
        
        GoodsCategory *goodsCategory2 = [self goodsCategoryFromSectionAndLevel:indexPath level:level];
        if (!goodsCategory2.image||[goodsCategory2.image isEqual:@""]||[goodsCategory2.image isEqual:@"(null)"])
        {
            NSString *imageName = self.secondCategoryImageList[indexPath.row];
            NSLog(@"imageName = %@",imageName);
            goodsCategory2.image = imageName;
        }
        cell.goodsCategory = goodsCategory2;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
        
        // handleSwipeFrom 是偵測到手势，所要呼叫的方法
        UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onBackBtnTouched:)];
        // 不同的 Recognizer 有不同的实体变数，例如 SwipeGesture 可以指定方向 而 TapGesture 則可以指定次數
        recognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [cell.contentView addGestureRecognizer:recognizer];
        
        return cell;
    }
}

#pragma mark - PushTreeViewDelegate
//点击pushTreeView的cell，则
- (void)pushTreeView:(InfiniteTreeView *)pushTreeView didSelectedLevel:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    NSLog(@"didSelectedLevel  level %ld section %ld row %ld", (long)level,(long)indexPath.section,(long)indexPath.row);
    
    [pushTreeView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (level == 0)
    {
        //显示返回按钮
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(onBackBtnTouched:)];
        
        //获取二级分类数据
        self.goodsSecondCategoryList = ((GoodsCategory *)[self.goodsCategoryList objectAtIndex:indexPath.row]).goodsCategoryArray;
        self.levelindexPathRow = indexPath.row;
        
        self.secondCategoryImageList = [self.categoryImageDictionary objectForKey:self.categoryImageList[indexPath.row]];
        
        //改变UITableViewCell
        int i = 0;
        for(GoodsCategory *goodsCategoryItem in self.goodsCategoryList)
        {
            goodsCategoryItem.isHiddenNextCategoryName = YES;
            goodsCategoryItem.imagefram = CGRectMake(-100.0f, 0.0f, 90.0f, 90.0f);
            goodsCategoryItem.namefram = CGRectMake(10.0f, 35.0f, 80.0f, 20.0f);
            goodsCategoryItem.nameColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
            goodsCategoryItem.isHiddenIndicator = YES;
            goodsCategoryItem.isHiddenLineView = YES;
            if (i == indexPath.row)
            {
                [self initTitleViewWithTitle:goodsCategoryItem.name andIsShowSearchBar:NO];
                goodsCategoryItem.nameColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f];
                goodsCategoryItem.isHiddenIndicator = NO;
            }
            i++;
        }
        [pushTreeView reloadData];
    }
    else
    {
        GoodsCategory *goodsCategory = (GoodsCategory *)((GoodsCategory *)self.goodsCategoryList[self.levelindexPathRow]).goodsCategoryArray[indexPath.row];
        
        GoodsListViewController *goodsListViewController = [[GoodsListViewController alloc] initWithNibName:@"GoodsListViewController" bundle:nil];
        goodsListViewController.hidesBottomBarWhenPushed = YES;
        goodsListViewController.categoryId = goodsCategory.category_id;
        goodsListViewController.categoryName = [NSString stringWithFormat:@"%@",goodsCategory.name ];
        [self.navigationController pushViewController:goodsListViewController animated:YES];
    }
}

//重新载入当前level的tableView
- (void)pushTreeViewWillReloadAtLevel:(InfiniteTreeView*)pushTreeView currentLevel:(NSInteger)currentLevel level:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    NSLog(@"current level %ld level %ld", (long)currentLevel, (long)level);
}

//返回Section的HeadView
- (UIView *)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level viewForHeaderInSection:(NSInteger)section
{
//    if (level == 0)
//    {
//        UIView *headerview = headerview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 90.0f)];
//        headerview.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
//        
//        
//        return headerview;
//    }
    
    return nil;

}

//设置商品分类列表Section高度
- (CGFloat)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level heightForHeaderInSection:(NSInteger)section
{   //不需要section 则设置为0
    
//    if (level == 0)
//    {
//        return 100.0f;
//    }
    return 0.0f;
}

//设置商品分类列表Section的row的高度
- (CGFloat)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (level == 0)
    {
        return 90.0f;
    }
    else
    {
        return 60.0f;
    }
}

- (BOOL)pushTreeViewHasNextLevel:(InfiniteTreeView *)pushTreeView currentLevel:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    BOOL next = TRUE;
    
    //是否有下一个层级
    if (level >= 1)
    {
        next = FALSE;
    }
    return next;
}

#pragma mark - private methods
- (GoodsCategory *)goodsCategoryFromSectionAndLevel:(NSIndexPath*)indexPath level:(NSInteger)level
{
    GoodsCategory *goodsCategory = [[GoodsCategory alloc]init];
    
    if (level == 0)
    {
        if (indexPath.section == 0) {
            return (GoodsCategory *)([self.goodsCategoryList objectAtIndex:indexPath.row]);
        }
    }
    else if (level == 1)
    {
        if (indexPath.section == 0)
        {
            return (GoodsCategory *)([self.goodsSecondCategoryList objectAtIndex:indexPath.row]);
        }
    }
    else
    {
        
        goodsCategory.name = [NSString stringWithFormat:@"L%ldS%ldR%ld%d", (long)level, (long)indexPath.section, (long)indexPath.row, rand() % 10];
        
    }
    return goodsCategory;
}

#pragma mark - IBAction methods
- (void)onBackBtnTouched:(id)sender
{
    //当处于level ＝ 1（二级分类）时，点击返回后返回一级分类且返回按钮消失
    if (self.pushTreeView.level == 1)
    {
        self.navigationItem.leftBarButtonItem = nil;
        [self initTitleViewWithTitle:@"搜寻商品" andIsShowSearchBar:YES];
        [self.pushTreeView back];
        
        //改变UITableViewCell
        for(GoodsCategory *goodsCategoryItem in self.goodsCategoryList)
        {
            goodsCategoryItem.isHiddenNextCategoryName = NO;
            goodsCategoryItem.isHiddenIndicator = YES;
            goodsCategoryItem.isHiddenLineView = NO;
            goodsCategoryItem.imagefram = CGRectMake(5.0f, 0.0f, 90.0f, 90.0f);
            goodsCategoryItem.namefram = CGRectMake(105.0f, 20.0f, 200.0f, 20.0f);
            goodsCategoryItem.nameColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        }
    }
    else if (self.pushTreeView.level > 1)
    {
        [self.pushTreeView back];
    }
}

/*****************************分类接口**********************************/
//重新加载分类列表:myView
- (void)reLoadMyView:(id)sender
{
    [self callGoodsCategoryWebService];
}

//获取分类详情，调用分类接口
- (void)callGoodsCategoryWebService
{
    [self.activityIndicator startAnimating];
    
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/product/product_categories"];
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
    [request startAsynchronous];//异步传输
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (![request error])
    {
        NSString *responseString =[request responseString];
        NSLog(@"responseString = %@",responseString);
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        NSLog(@"data = %@",data);
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        NSArray *result = [data objectForKey:@"result"];
        NSLog(@"result = %@",result);
        
        [self.activityIndicator stopAnimating];
        UIView *view = (UIView *)[self.view viewWithTag:100];
        [view removeFromSuperview];
        
        if(resultCode == 0)
        {
            self.view = self.nullView;
            self.loadFailedLabel.hidden = NO;
            self.reloadLabel.hidden = NO;
            self.reloadButton.hidden = NO;
        }
        else
        {
            //解析分类列表数据
            if ([self resolve:result])
            {
                //初始化分类列表页面
                [self initGoodsCategoryListView];
            }
            else
            {
                self.view = self.nullView;
                self.loadFailedLabel.hidden = NO;
                self.reloadLabel.hidden = NO;
                self.reloadButton.hidden = NO;
            }
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    if ([request error])
    {
        self.view = self.nullView;
        self.loadFailedLabel.hidden = NO;
        self.reloadLabel.hidden = NO;
        self.reloadButton.hidden = NO;
    }
}

- (BOOL)resolve:(NSArray *)result
{
    for(NSDictionary *goodsCategoryDictionary in result)
    {
        GoodsCategory *goodsCategory = [[GoodsCategory alloc]init];
        goodsCategory.category_id = [[goodsCategoryDictionary objectForKey:@"category_id"]longLongValue];
        goodsCategory.image = [goodsCategoryDictionary objectForKey:@"image"];
        goodsCategory.name = [goodsCategoryDictionary objectForKey:@"name"];
        
        NSMutableArray *goodsCategoryList = [goodsCategoryDictionary objectForKey:@"category"];
        for(NSDictionary *goodsCategoryDictionary2 in goodsCategoryList)
        {
            GoodsCategory *goodsCategory2 = [[GoodsCategory alloc]init];
            goodsCategory2.category_id = [[goodsCategoryDictionary2 objectForKey:@"category_id"]longLongValue];
            goodsCategory2.image = [goodsCategoryDictionary2 objectForKey:@"image"];
            goodsCategory2.name = [goodsCategoryDictionary2 objectForKey:@"name"];
            [goodsCategory.goodsCategoryArray addObject:goodsCategory2];
        }
        [self.goodsCategoryList addObject:goodsCategory];
    }
    return YES;
}

@end
