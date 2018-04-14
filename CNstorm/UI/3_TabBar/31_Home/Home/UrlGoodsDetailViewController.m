//
//  UrlGoodsDetailViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-1.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "UrlGoodsDetailViewController.h"

@interface UrlGoodsDetailViewController ()

@end

@implementation UrlGoodsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.sizeButtonArray = [[NSMutableArray alloc]init];
        self.colorButtonArray = [[NSMutableArray alloc]init];
        self.goods = [[Goods alloc] init];
        
        //初始化被选择的颜色和尺码
        self.selectedColorId = @"";
        self.selectedSizeId = @"";
        self.selectedColor = @"";
        self.selectedSize = @"";
        
        self.buyType = 1;
    }
    return self;
}

//view加载
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //解决iOS7适配问题，导航栏遮挡了view，通常前两句就能解决问题，不行加后两句
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    //UISearchBar
    self.navigationItem.title = @"抓取商品详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self callGoodsDetaiWebService];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
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


/*****************************初始化商品详情页面**********************************/
//初始化商品详情页面
- (void)initMyView
{
    self.view = self.myView;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight)];
    [self.myView addSubview:self.scrollView];
    
    //初始化商品信息
    [self initGoodInfoView];
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth,ScrollViewHeight+DarkDemonDarkViewHeight+self.sizeTitleViewHeight+self.sizeViewHeight+self.colorTitleViewHeight+self.colorViewHeight+QuantityViewHeight+RemarkViewHeight+SaleViewHeight+AddCartTransparentBarHeight);
    
    UIView *transparentBarView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,MainScreenHeight-NavigationBarHeight-AddCartTransparentBarHeight,MainScreenWidth,AddCartTransparentBarHeight)];
    transparentBarView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.9f];
    transparentBarView.layer.borderWidth = 0.5f;
    transparentBarView.layer.borderColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:1].CGColor;
    [self.myView addSubview:transparentBarView];
    
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(97.5f, 12.5f, 125.0f,35.0f)];
    if(self.buyType == 1)
    {
        [commitButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    }
    else if(self.buyType == 2)
    {
        [commitButton setTitle:@"加入商品清单" forState:UIControlStateNormal];
    }
    commitButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [commitButton.layer setCornerRadius:3.0f];
    commitButton.layer.borderWidth = 0.5f;
    commitButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [commitButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [transparentBarView addSubview:commitButton];
}

//初始化商品图片轮播
-(void)initScrollImageView
{
    self.urlArray = self.goods.goodsImageArray;
    
    // 定时器 循环
    [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    
    // 初始化 scrollImageView
    self.scrollImageView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, ScrollImageViewHeight)];
    self.scrollImageView.bounces = YES;
    self.scrollImageView.pagingEnabled = YES;
    self.scrollImageView.delegate = self;
    self.scrollImageView.userInteractionEnabled = YES;
    self.scrollImageView.showsHorizontalScrollIndicator = NO;
    [self.scrollView addSubview:self.scrollImageView];
    
    // 初始化 pagecontrol
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(110.0f, ScrollImageViewHeight-15.0f,100.0f,7.5f)]; // 初始化mypagecontrol
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f]];
    [self.pageControl setPageIndicatorTintColor:[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.5f]];
    
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
    UIImage *placeholder = [UIImage imageNamed:@"default250.png"];
    for (int i = 0; i < self.urlArray.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((MainScreenWidth * i)+MainScreenWidth,0, MainScreenWidth, ScrollImageViewHeight);
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
    zoroImageView.frame = CGRectMake(0.0f, 0.0f, MainScreenWidth, ScrollImageViewHeight);// 添加最后1页在首页循环
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
    lastImageView.frame = CGRectMake((MainScreenWidth * ([self.urlArray count] + 1)) , 0.0f,MainScreenWidth, ScrollImageViewHeight); // 添加第1页在最后 循环
    
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
    
    
    [self.scrollImageView setContentSize:CGSizeMake(MainScreenWidth * ([self.urlArray count] + 2), ScrollImageViewHeight)]; //+上第1页和第4页  原理:4-[1-2-3-4]-1
    
    [self.scrollImageView setContentOffset:CGPointMake(0.0f, 0.0f)];
    
    [self.scrollImageView scrollRectToVisible:CGRectMake(MainScreenWidth, 0.0f, MainScreenWidth,ScrollImageViewHeight) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    int count = (int)self.urlArray.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++)
    {
        // 替换为中等尺码图片
        NSString *url = [self.urlArray[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        photo.url = [NSURL URLWithString:url]; // 图片路径
        
        photo.srcImageView = self.scrollImageView.subviews[i]; // 来源于哪个UIImageView
        
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    
    browser.photos = photos; // 设置所有的图片
    
    [browser show];
}

// scrollView 委托函数
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
        [self.scrollImageView scrollRectToVisible:CGRectMake(MainScreenWidth * [self.urlArray count],0,MainScreenWidth,ScrollImageViewHeight) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage == ([self.urlArray count] + 1))
    {
        [self.scrollImageView scrollRectToVisible:CGRectMake(MainScreenWidth, 0, MainScreenWidth, ScrollImageViewHeight) animated:NO]; // 最后+1,循环第1页
    }
}

// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = (int)self.pageControl.currentPage; // 获取当前的page
    
    [self.scrollImageView scrollRectToVisible:CGRectMake(MainScreenWidth*(page+1),0,MainScreenWidth,ScrollImageViewHeight) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
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

//初始化商品信息
-(void)initGoodInfoView
{
    //商品图片轮播初始化
    [self initScrollImageView];
    
    //1.商品名称
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, ScrollImageViewHeight, MainScreenWidth, NameViewHeight)];
    nameView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:nameView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 260.0f, NameViewHeight)];
    nameLabel.text = self.goods.name;
    nameLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    nameLabel.font = [UIFont systemFontOfSize:15.0f];
    nameLabel.numberOfLines = 2;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    nameLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [nameView addSubview:nameLabel];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, NameViewHeight-1.0f, 300.0f, 1.0f)];
    lineView1.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [nameView addSubview:lineView1];
    
    //2.商品价格 单价 促销价  国内邮费
    UIView *priceView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, ScrollImageViewHeight+NameViewHeight, MainScreenWidth, PriceViewHeight)];
    priceView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:priceView];
    
    self.realPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 120.0f, 30.0f)];
    self.realPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.goods.realPrice];
    self.realPriceLabel.textColor = [UIColor colorWithRed:(253.0f/255.0f) green:(78.0f/255.0f) blue:(46.0f/255.0f) alpha:1.0f];
    self.realPriceLabel.font = [UIFont systemFontOfSize:17.0f];
    self.realPriceLabel.numberOfLines = 1;
    self.realPriceLabel.textAlignment = NSTextAlignmentLeft;
    self.realPriceLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.realPriceLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [priceView addSubview:self.realPriceLabel];
    
    UILabel *yunfeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 30.0f, 120.0f, 20.0f)];
    yunfeiLabel.text = [NSString stringWithFormat:@"运费:￥%.2f",self.goods.yunfei];
    yunfeiLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    yunfeiLabel.font = [UIFont systemFontOfSize:14.0f];
    yunfeiLabel.lineBreakMode = NSLineBreakByWordWrapping;
    yunfeiLabel.numberOfLines = 2;
    yunfeiLabel.textAlignment = NSTextAlignmentLeft;
    yunfeiLabel.adjustsFontSizeToFitWidth = YES;
    yunfeiLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [priceView addSubview:yunfeiLabel];
    
    //3.图文详情 2个灰色阴影
    UIView *darkView1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, ScrollViewHeight, MainScreenWidth, DarkViewHeight)];
    darkView1.backgroundColor = [UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:darkView1];
    
    UIView *demonstrationView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,ScrollViewHeight+DarkViewHeight, MainScreenWidth, DemonstrationViewHeight)];
    demonstrationView.backgroundColor = [UIColor whiteColor];
    [demonstrationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGoodIntroduceView:)]];
    demonstrationView.userInteractionEnabled = YES;
    [self.scrollView addSubview:demonstrationView];
    
    UILabel *demonstrationLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 140.0f, DemonstrationViewHeight)];
    demonstrationLabel.text = [NSString stringWithFormat:@"查看商品图文详情"];
    demonstrationLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    demonstrationLabel.font = [UIFont systemFontOfSize:16.0f];
    demonstrationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    demonstrationLabel.textAlignment = NSTextAlignmentLeft;
    demonstrationLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [demonstrationView addSubview:demonstrationLabel];
    
    UILabel *wifiLabel = [[UILabel alloc]initWithFrame:CGRectMake(160.0f, 0.0f, 120.0f, DemonstrationViewHeight)];
    wifiLabel.text = [NSString stringWithFormat:@"建议在WIFI模式下查看"];
    wifiLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    wifiLabel.font = [UIFont systemFontOfSize:12.0f];
    wifiLabel.lineBreakMode = NSLineBreakByWordWrapping;
    wifiLabel.textAlignment = NSTextAlignmentLeft;
    wifiLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [demonstrationView addSubview:wifiLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(295.0f,17.25f, 6.0f, 10.5f)];
    [arrowImageView setImage:[UIImage imageNamed:@"accessoryView"]];
    [demonstrationView addSubview:arrowImageView];
    
    UIView *darkView2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, ScrollViewHeight+DarkViewHeight+DemonstrationViewHeight, MainScreenWidth, DarkViewHeight)];
    darkView2.backgroundColor = [UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:darkView2];
    
    //尺码
    self.sizeViewHeight = 0.0f;
    self.sizeTitleViewHeight = 0.0f;
    if (self.goods.sizeArray.count != 0)
    {
        //4.尺码标题 sizeTitle
        self.sizeTitleViewHeight = SizeTitleViewHeight;
        UIView *sizeTitleView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,ScrollViewHeight+DarkDemonDarkViewHeight, MainScreenWidth, self.sizeTitleViewHeight)];
        sizeTitleView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:sizeTitleView];
        
        UILabel *sizeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, self.sizeTitleViewHeight)];
        sizeTitleLabel.text = [NSString stringWithFormat:@"尺码"];
        sizeTitleLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        sizeTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        sizeTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        sizeTitleLabel.textAlignment = NSTextAlignmentLeft;
        sizeTitleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [sizeTitleView addSubview:sizeTitleLabel];
        
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, self.sizeTitleViewHeight-1.0f, 300.0f, 1.0f)];
        lineView2.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
        [sizeTitleView addSubview:lineView2];
        
        //5.尺码大小 设置sizeView的高度
        UIView *sizeView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,ScrollViewHeight+DarkDemonDarkViewHeight+self.sizeTitleViewHeight, MainScreenWidth, self.sizeViewHeight)];
        sizeView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:sizeView];
        
        //设置原长度
        float startWidth = 15.0f;
        float startHeight = 15.0f;
        float interval = 10.0f;
        
        float width = 0.0f;
        float sizeButtonHeight = 35.0f;
        int m = 0;
        int n = 1;
        for (int i = 0; i < self.goods.sizeArray.count; i++)
        {
            NSString *sizeStr = [NSString stringWithFormat:@"%@",self.goods.sizeArray[i]];
            CGSize sizeStrSize = [sizeStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
            
            float sizeButtonWidth =  sizeStrSize.width + 20.0f;
            
            if((width + sizeButtonWidth) <= (MainScreenWidth - 2*startWidth - interval*(m-1)))
            {
                width = width + sizeButtonWidth;
                m = m+1;
            }
            else
            {
                width = 0;
                width = width + sizeButtonWidth;
                m = 1;
                n = n+1;
            }
            
            UIButton *sizeButton = [[UIButton alloc]initWithFrame:CGRectMake(startWidth+(width-sizeButtonWidth)+interval*(m-1),startHeight+sizeButtonHeight*(n-1)+(n-1)*interval, sizeButtonWidth, sizeButtonHeight)];
            sizeButton.backgroundColor = [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1.0f];
            [sizeButton setTitle:sizeStr forState:UIControlStateNormal];
            sizeButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            
            [sizeButton setTitleColor:[UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
            [sizeButton setTitleColor:[UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f] forState:UIControlStateSelected];
            sizeButton.layer.cornerRadius= 3.0f;
            sizeButton.layer.borderWidth = 0.5f;
            sizeButton.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
            
            sizeButton.selected = NO;
            sizeButton.tag = i;
            [sizeButton addTarget:self action:@selector(selectSizeButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.sizeButtonArray addObject:sizeButton];
            [sizeView addSubview:sizeButton];
        }
        
        self.sizeViewHeight = 2*startHeight + n*sizeButtonHeight + (n-1)*interval;
        [sizeView setFrame:CGRectMake(0.0f,ScrollViewHeight+DarkDemonDarkViewHeight+self.sizeTitleViewHeight, MainScreenWidth,self.sizeViewHeight)];
    }
    
    //颜色
    self.colorViewHeight = 0.0f;
    self.colorTitleViewHeight = 0.0f;
    if (self.goods.colorArray.count != 0)
    {
        //6.颜色标题 colorTitle
        self.colorTitleViewHeight = ColorTitleViewHeight;
        UIView *colorTitleView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,ScrollViewHeight+DarkDemonDarkViewHeight+self.sizeTitleViewHeight+self.sizeViewHeight, MainScreenWidth, self.colorTitleViewHeight)];
        colorTitleView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:colorTitleView];
        
        UILabel *colorTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, self.colorTitleViewHeight)];
        colorTitleLabel.text = [NSString stringWithFormat:@"颜色分类"];
        colorTitleLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        colorTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        colorTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        colorTitleLabel.textAlignment = NSTextAlignmentLeft;
        colorTitleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [colorTitleView addSubview:colorTitleLabel];
        
        UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, self.colorTitleViewHeight-1.0f, 300.0f, 1.0f)];
        lineView3.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
        [colorTitleView addSubview:lineView3];
        
        //7.颜色分类
        UIView *colorView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, ScrollViewHeight+DarkDemonDarkViewHeight+self.sizeTitleViewHeight+self.sizeViewHeight+self.colorTitleViewHeight, MainScreenWidth, self.colorViewHeight)];
        colorView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:colorView];
        
        //设置原长度
        float cstartWidth = 15.0f;
        float cstartHeight = 15.0f;
        float cinterval = 10.0f;
        
        float cwidth = 0.0f;
        float colorButtonHeight = 35.0f;
        int cm = 0;
        int cn = 1;
        
        for (int i = 0; i < self.goods.colorArray.count; i++)
        {
            NSString *colorStr = [NSString stringWithFormat:@"%@",self.goods.colorArray[i]];
            CGSize colorStrSize = [colorStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
            float colorButtonWidth =  colorStrSize.width + 20.0f;
            
            if((cwidth + colorButtonWidth) <= (MainScreenWidth - 2*cstartWidth - cinterval*(cm-1)))
            {
                cwidth = cwidth + colorButtonWidth;
                cm = cm+1;
            }
            else
            {
                cwidth = 0;
                cwidth = cwidth + colorButtonWidth;
                cm = 1;
                cn = cn+1;
            }
            
            UIButton *colorButton = [[UIButton alloc]initWithFrame:CGRectMake(cstartWidth+(cwidth-colorButtonWidth)+cinterval*(cm-1), cstartHeight+colorButtonHeight*(cn-1)+(cn-1)*cinterval, colorButtonWidth, colorButtonHeight)];
            
            colorButton.backgroundColor = [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1.0f];
            [colorButton setTitle:colorStr forState:UIControlStateNormal];
            colorButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [colorButton setTitleColor:[UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
            [colorButton setTitleColor:[UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f] forState:UIControlStateSelected];
            colorButton.layer.cornerRadius= 3.0f;
            colorButton.layer.borderWidth = 0.5f;
            colorButton.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
            
            colorButton.selected = NO;
            colorButton.tag = i;
            [colorButton addTarget:self action:@selector(selectColorButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.colorButtonArray addObject:colorButton];
            [colorView addSubview:colorButton];
        }
        
        self.colorViewHeight = 2*cstartHeight + cn*colorButtonHeight + (cn-1)*cinterval;
        [colorView setFrame:CGRectMake(0.0f,ScrollViewHeight+DarkDemonDarkViewHeight+self.sizeTitleViewHeight+self.sizeViewHeight+self.colorTitleViewHeight, MainScreenWidth,self.colorViewHeight)];
    }
    
    
    //8.数量
    UIView *quantityView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,ScrollViewHeight+DarkDemonDarkViewHeight+self.sizeTitleViewHeight+self.sizeViewHeight+self.colorTitleViewHeight+self.colorViewHeight, MainScreenWidth, QuantityViewHeight)];
    quantityView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:quantityView];
    
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(10.0f,0.0f, 300.0f, 1.0f)];
    lineView4.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [quantityView addSubview:lineView4];
    
    UIView *lineView5 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, QuantityViewHeight-1.0f, 300.0f, 1.0f)];
    lineView5.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [quantityView addSubview:lineView5];
    
    UILabel *quantityLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 0.0f,70.0f, QuantityViewHeight)];
    quantityLabel.text = [NSString stringWithFormat:@"购买数量"];
    quantityLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    quantityLabel.font = [UIFont systemFontOfSize:16.0f];
    quantityLabel.lineBreakMode = NSLineBreakByWordWrapping;
    quantityLabel.textAlignment = NSTextAlignmentLeft;
    quantityLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [quantityView addSubview:quantityLabel];
    
    self.kucunLabel = [[UILabel alloc]initWithFrame:CGRectMake(85.0f, 0.0f,100.0f, QuantityViewHeight)];
    self.kucunLabel.text = [NSString stringWithFormat:@"库存(%d)",self.goods.kucun];
    self.kucunLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.kucunLabel.font = [UIFont systemFontOfSize:12.0f];
    self.kucunLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.kucunLabel.numberOfLines = 1;
    self.kucunLabel.textAlignment = NSTextAlignmentCenter;
    self.kucunLabel.adjustsFontSizeToFitWidth = YES;
    self.kucunLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [quantityView addSubview:self.kucunLabel];
    
    UIView *mqaView = [[UIView alloc]initWithFrame:CGRectMake(190.0f,12.5,100.0f,30.0f)];
    mqaView.backgroundColor = [UIColor whiteColor];
    mqaView.layer.cornerRadius= 3.0f;
    mqaView.layer.borderWidth = 0.5f;
    mqaView.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
    [quantityView addSubview:mqaView];
    
    UIButton *minusButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 25.0f, 30.0f)];
    minusButton.backgroundColor = [UIColor whiteColor];
    [minusButton setTitle:@"－" forState:UIControlStateNormal];
    minusButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [minusButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
    minusButton.tag = 0;
    [minusButton addTarget:self action:@selector(minusAddBuyQuantity:) forControlEvents:UIControlEventTouchUpInside];
    [mqaView addSubview:minusButton];
    
    self.quantityTextField = [[UITextField alloc]initWithFrame:CGRectMake(25.0f, 0.0f, 50.0f, 30.0f)];
    self.quantityTextField.delegate = self;
    self.quantityTextField.backgroundColor = [UIColor whiteColor];
    [self.quantityTextField setText:[NSString stringWithFormat: @"%d",self.goods.buyQuantity]];
    self.quantityTextField.font = [UIFont systemFontOfSize:13.0f];
    self.quantityTextField.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    self.quantityTextField.layer.borderWidth = 0.5f;
    self.quantityTextField.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
    self.quantityTextField.textAlignment = NSTextAlignmentCenter;
    self.quantityTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.quantityTextField.returnKeyType = UIReturnKeyDone;
    self.quantityTextField.autocorrectionType = UITextAutocorrectionTypeNo;//拼写检查
    [mqaView addSubview:self.quantityTextField];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(75.0f, 0.0f, 25.0f, 30.0f)];
    addButton.backgroundColor = [UIColor whiteColor];
    addButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [addButton setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
    [addButton setTitle:@"＋" forState:UIControlStateNormal];
    addButton.tag = 1;
    [addButton addTarget:self action:@selector(minusAddBuyQuantity:) forControlEvents:UIControlEventTouchUpInside];
    [mqaView addSubview:addButton];
    
    //9.备注Remark
    UIView *remarkView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, ScrollViewHeight+DarkDemonDarkViewHeight+self.sizeTitleViewHeight+self.sizeViewHeight+self.colorTitleViewHeight+self.colorViewHeight+QuantityViewHeight, MainScreenWidth,RemarkViewHeight)];
    remarkView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:remarkView];
    
    self.remarkTextView = [[CPTextViewPlaceholder alloc]initWithFrame:CGRectMake(10.0f, 10.0f, 300.0f, 60.0f)];
    self.remarkTextView.placeholder = @"若有其他特殊需求,在此填写";
    self.remarkTextView.backgroundColor = [UIColor whiteColor];
    self.remarkTextView.font = [UIFont systemFontOfSize:14.0f];
    self.remarkTextView.returnKeyType = UIReturnKeyDone;
    self.remarkTextView.keyboardType = UIKeyboardTypeDefault;
    self.remarkTextView.textAlignment = NSTextAlignmentLeft;
    self.remarkTextView.delegate = self;
    self.remarkTextView.layer.cornerRadius = 3.0f;
    self.remarkTextView.layer.borderWidth = 0.5f;
    self.remarkTextView.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
    [remarkView addSubview:self.remarkTextView];
    
    //10.卖家信息 去店铺逛逛
    UIView *saleView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, ScrollViewHeight+DarkDemonDarkViewHeight+self.sizeTitleViewHeight+self.sizeViewHeight+self.colorTitleViewHeight+self.colorViewHeight+QuantityViewHeight+RemarkViewHeight , MainScreenWidth, SaleViewHeight)];
    saleView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:saleView];
    
    UILabel *saleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 5.0f, 45.0f, 30.0f)];
    saleLabel.text = [NSString stringWithFormat:@"店铺:"];
    saleLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    saleLabel.font = [UIFont systemFontOfSize:15.0f];
    saleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    saleLabel.numberOfLines = 1;
    saleLabel.textAlignment = NSTextAlignmentLeft;
    saleLabel.adjustsFontSizeToFitWidth = YES;
    saleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [saleView addSubview:saleLabel];
    
    UILabel *saleInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0f, 5.0f, 170.0f, 30.0f)];
    saleInfoLabel.text = [NSString stringWithFormat:@"%@",self.goods.storeName];
    saleInfoLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    saleInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    saleInfoLabel.numberOfLines = 1;
    saleInfoLabel.textAlignment = NSTextAlignmentLeft;
    saleInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    saleInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [saleView addSubview:saleInfoLabel];
    
    UIButton *saleButton = [[UIButton alloc]initWithFrame:CGRectMake(230.0f, 5.0f, 70.0f,35.0f)];
    [saleButton setTitle:@"去逛逛" forState:UIControlStateNormal];
    saleButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    saleButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    saleButton.layer.cornerRadius = 3.0f;
    saleButton.layer.borderWidth = 0.5f;
    saleButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [saleButton addTarget:self action:@selector(goodSellerView:) forControlEvents:UIControlEventTouchUpInside];
    [saleView addSubview:saleButton];
}

/*****************************页面操作**********************************/
- (void)selectSizeButton:(id)sender
{
    //恢复全不选
    for (UIButton *btn in self.sizeButtonArray)
    {
        btn.selected = NO;
        btn.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
    }
    
    UIButton *button = (UIButton *)sender;
    button.selected = YES;
    button.layer.borderColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(82.0f)/255.0f alpha:1].CGColor;
    NSString *selectedSizeStr = self.goods.sizeArray[button.tag];
    self.selectedSize = [NSString stringWithFormat:@"%@",selectedSizeStr];
    //快速枚举遍历所有KEY的值
    for (NSString *value in [self.goods.sizeNumberDictionary allValues])
    {
        if ([value isEqualToString:selectedSizeStr])
        {
            self.selectedSizeId = [self.goods.sizeNumberDictionary allKeysForObject:value][0];//根据值获取key
        }
    }
    
    //判断颜色是否可选
    for (UIButton *btn in self.colorButtonArray)
    {
        NSString *colorStr = self.goods.colorArray[btn.tag];
        NSString *sizeColor = [NSString stringWithFormat:@"%@_%@",selectedSizeStr,colorStr];
        if (![self isCanGetPriceAndKuncunWithSizeColor:sizeColor])
        {
            [btn setEnabled:NO];
            btn.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
            [btn setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        }
        else
        {
            [btn setEnabled:YES];
            btn.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
            [btn setTitleColor:[UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
            
            if (btn.isSelected)
            {
                btn.layer.borderColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(82.0f)/255.0f alpha:1].CGColor;
            }
        }
    }
    
    //选择匹配价格
    NSString *selectedColorStr = nil;
    for (UIButton *btn in self.colorButtonArray)
    {
        if (btn.selected)
        {
            selectedColorStr = self.goods.colorArray[btn.tag];
        }
    }
    
    if (selectedSizeStr.length>0 && selectedColorStr.length>0)
    {
        NSString *sizeColor = [NSString stringWithFormat:@"%@_%@",selectedSizeStr,selectedColorStr];
        
        [self getPriceWithSizeColor:sizeColor];
    }
}

- (void)selectColorButton:(id)sender
{
    //恢复全不选
    for (UIButton *btn in self.colorButtonArray)
    {
        btn.selected = NO;
        btn.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
    }
    
    //选择颜色
    UIButton *button = (UIButton *)sender;
    button.selected = YES;
    button.layer.borderColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(82.0f)/255.0f alpha:1].CGColor;
    NSString *selectedColorStr = self.goods.colorArray[button.tag];
    self.selectedColor = [NSString stringWithFormat:@"%@",selectedColorStr];
    //快速枚举遍历所有KEY的值
    for (NSString *value in [self.goods.colorNumberDictionary allValues])
    {
        if ([value isEqualToString:selectedColorStr])
        {
            NSLog(@"value = %@",value);
            self.selectedColorId = [self.goods.colorNumberDictionary allKeysForObject:value][0];//根据值获取key
        }
    }
    
    //判断尺码是否可选
    for (UIButton *btn in self.sizeButtonArray)
    {
        NSString *sizeStr = self.goods.sizeArray[btn.tag];
        NSString *sizeColor = [NSString stringWithFormat:@"%@_%@",sizeStr,selectedColorStr];
        if (![self isCanGetPriceAndKuncunWithSizeColor:sizeColor])
        {
            
            [btn setEnabled:NO];
            btn.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
            [btn setTitleColor:[UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
        }
        else
        {
            [btn setEnabled:YES];
            btn.layer.borderColor = [UIColor colorWithRed:(230.0f)/255.0f green:(230.0f)/255.0f blue:(230.0f)/255.0f alpha:1].CGColor;
            [btn setTitleColor:[UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
            
            if (btn.isSelected)
            {
                btn.layer.borderColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(82.0f)/255.0f alpha:1].CGColor;
            }
        }
    }
    
    
    NSString *selectedSizeStr = nil;
    for (UIButton *btn in self.sizeButtonArray)
    {
        if (btn.selected)
        {
            selectedSizeStr = self.goods.sizeArray[btn.tag];
        }
    }
    //根据颜色、尺码匹配价格
    if (selectedColorStr > 0 && selectedColorStr > 0)
    {
        NSString *sizeColor = [NSString stringWithFormat:@"%@_%@",selectedSizeStr,selectedColorStr];
        [self getPriceWithSizeColor:sizeColor];
    }
    
    //根据颜色匹配图片
    if (selectedColorStr.length > 0)
    {
        //根据颜色获取颜色NO.
        if (self.goods.colorNumberDictionary.count > 0 && self.goods.goodsImageColorDictionary.count > 0)
        {
            //得到词典中所有VALUE值
            NSArray *allValues = [self.goods.colorNumberDictionary allValues];
            NSString *colorNo = nil;
            //快速枚举遍历所有KEY的值
            for (NSString *value in allValues)
            {
                if ([value isEqualToString:selectedColorStr])
                {
                    colorNo = [self.goods.colorNumberDictionary allKeysForObject:value][0];//根据值获取key
                }
            }
            
            //根据颜色NO获取图片数组
            //得到词典中所有KEY值
            NSArray *allKeys = [self.goods.goodsImageColorDictionary allKeys];
            //快速枚举遍历所有KEY的值
            for (NSString *key in allKeys)
            {
                if ([key isEqualToString:colorNo])
                {
                    NSString *colorUrl = [self.goods.goodsImageColorDictionary objectForKey:key];
                    
                    if (colorUrl.length > 0)
                    {
                        [self.urlArray insertObject:colorUrl atIndex:0];
                        
                        self.pageControl.numberOfPages = self.urlArray.count;
                        
                        for (UIView *view in self.scrollImageView.subviews)
                        {
                            [view removeFromSuperview];
                        }
                        [self loadScollImageView];
                    }
                }
            }
        }
    }
}

//是否能获取价格或者库存
- (BOOL)isCanGetPriceAndKuncunWithSizeColor:(NSString *)sizeColor
{
    BOOL ret = NO;
    if (self.goods.realPriceDictionary && self.goods.kucunDictionary)
    {
        BOOL ret1 = NO;
        //得到词典中所有KEY值
        NSArray *allKeys1 = [self.goods.realPriceDictionary allKeys];
        //快速枚举遍历所有KEY的值
        for (NSString *key1 in allKeys1)
        {
            ret1 = ret1||[key1 isEqualToString:sizeColor];
        }
        
        BOOL ret2 = NO;
        //得到词典中所有KEY值
        NSArray *allKeys2 = [self.goods.kucunDictionary allKeys];
        //快速枚举遍历所有KEY的值
        for (NSString *key2 in allKeys2)
        {
            ret2 = ret2||[key2 isEqualToString:sizeColor];
        }
        return ret1&&ret2;
    }
    else
    {
        return ret;
    }
}


- (void)getPriceWithSizeColor:(NSString *)sizeColor
{
    if (self.goods.realPriceDictionary)
    {
        //得到词典中所有KEY值
        NSArray *allKeys = [self.goods.realPriceDictionary allKeys];
        
        //快速枚举遍历所有KEY的值
        for (NSString *key in allKeys)
        {
            if ([key isEqualToString:sizeColor])
            {
                self.goods.realPrice = [[self.goods.realPriceDictionary objectForKey:key] floatValue];
                self.realPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.goods.realPrice];
            }
        }
    }
    
    if (self.goods.kucunDictionary)
    {
        //得到词典中所有KEY值
        NSArray *allKeys = [self.goods.kucunDictionary allKeys];
        
        //快速枚举遍历所有KEY的值
        for (NSString *key in allKeys)
        {
            if ([key isEqualToString:sizeColor])
            {
                self.goods.kucun = [[self.goods.kucunDictionary objectForKey:key] intValue];
                self.kucunLabel.text = [NSString stringWithFormat:@"库存(%d)",self.goods.kucun];
            }
        }
    }
}

- (void)tapGoodIntroduceView:(UITapGestureRecognizer *)tap
{
    GoodsIntroduceViewController *goodsIntroduceViewController = [[GoodsIntroduceViewController alloc]initWithNibName:@"GoodsIntroduceViewController" bundle:nil];
    if(self.goods.propImageArray.count > 0)
    {
        goodsIntroduceViewController.propImageArray = self.goods.propImageArray;
    }
    else
    {
        goodsIntroduceViewController.propImageArray = self.goods.goodsImageArray;
    }
    
    MJNavigationController *goodsIntroduceNC = [[MJNavigationController alloc]initWithRootViewController:goodsIntroduceViewController];
    [self presentViewController:goodsIntroduceNC animated:YES completion:NULL];
}

- (void)minusAddBuyQuantity:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == 0)
    {
        int buyQuantity = [self.quantityTextField.text intValue]-1;
        
        if ( buyQuantity > 0)
        {
            self.quantityTextField.text = [NSString stringWithFormat:@"%d",buyQuantity];
        }
    }
    else
    {
        int buyQuantity = [self.quantityTextField.text intValue]+1;
        
        if ( buyQuantity <= self.goods.kucun)
        {
            self.quantityTextField.text = [NSString stringWithFormat:@"%d",buyQuantity];
        }
    }
}

//UITextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.quantityTextField resignFirstResponder];
    
    if (!self.quantityTextField.text.length > 0)
    {
        [self.quantityTextField setText:@"1"];
    }
    
    return YES;
}

//备注名 textView
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    float offset = 216.0-SaleViewHeight;//键盘高度216-备注框底部离view底部的高度
    
    NSLog(@"offset = %f",offset);
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    float width = self.scrollView.frame.size.width;
    
    float height = self.scrollView.frame.size.height;
    
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f,-offset,width,height);
        self.scrollView.frame = rect;
    }
    
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView;
{
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight);
    
    self.scrollView.frame = rect;
    
    [UIView commitAnimations];
    
    [textView resignFirstResponder];
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
    
    if (range.location > 50)//可以输入50个字符包括汉字
    {
        //控制输入文本的长度
        return  NO;
    }
    
    return YES;
}

//焦点发生改变
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    
}

//备注名 键盘key
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float keyHeight = keyboardRect.size.height;
    
    float offset = keyHeight-SaleViewHeight;//键盘高度-备注框底部离底部的高度
    
    NSLog(@"offset = %f",offset);
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    float width = MainScreenWidth;
    
    float height = MainScreenHeight-NavigationBarHeight;
    
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f,-offset,width,height);
        self.scrollView.frame = rect;
    }
    
    [UIView commitAnimations];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight);
    
    self.scrollView.frame = rect;
    
    [UIView commitAnimations];
}

//进入店铺
- (void)goodSellerView:(id)sender
{
    if(self.goods.mstoreUrl.length > 0)
    {
        GoodSellerViewController *goodSellerViewController = [[GoodSellerViewController alloc]initWithNibName:@"GoodSellerViewController" bundle:nil];
        MJNavigationController *goodsSellerNC = [[MJNavigationController alloc]initWithRootViewController:goodSellerViewController];
        goodSellerViewController.sellerUrl = self.goods.mstoreUrl;
        [self presentViewController:goodsSellerNC animated:YES completion:NULL];
    }
    else
    {
        [MBProgressHUD showError:@"店铺加载失败" toView:self.view];
    }
}

-(void)commit:(id)sender
{
    if (self.goods.sizeArray.count != 0 && self.goods.colorArray.count != 0)
    {
        if ([self.selectedSizeId isEqualToString:@""]&&[self.selectedColorId isEqualToString:@""])
        {
            [MBProgressHUD showError:@"请选择尺码和颜色" toView:self.view];
            return;
        }
        
        if ([self.selectedSizeId isEqualToString:@""])
        {
            [MBProgressHUD showError:@"请选择尺码" toView:self.view];
            return;
        }
        
        if ([self.selectedColorId isEqualToString:@""])
        {
            [MBProgressHUD showError:@"请选择颜色" toView:self.view];
            return;
        }
    }
    
    if (self.goods.sizeArray.count != 0)
    {
        if ([self.selectedSizeId isEqualToString:@""])
        {
            [MBProgressHUD showError:@"请选择尺码" toView:self.view];
            return;
        }
    }
    
    if (self.goods.colorArray.count != 0)
    {
        if ([self.selectedColorId isEqualToString:@""])
        {
            [MBProgressHUD showError:@"请选择颜色" toView:self.view];
            return;
        }
    }
    
    NSString *remark = @"";
    if (![self.remarkTextView.text isEqualToString:@"若有其他特殊需求,在此填写"])
    {
        remark = self.remarkTextView.text;
    }
    
    int quantity = 1;
    if (![self.quantityTextField.text isEqualToString:@""])
    {
        quantity = [self.quantityTextField.text intValue];
    }
    
    //判断是否登录
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:@"isLogin"])
    {
        [self popLoginView];
    }
    else
    {
        NSString *color = self.selectedColor;
        NSString *size = self.selectedSize;
        
        if (self.buyType == 1)
        {
            [self callAddCartWebServiceWithQuantity:quantity andRemark:remark andColor:color andSize:size];
        }
        else if(self.buyType == 2)
        {
            [self callAddListWebServiceWithQuantity:quantity andRemark:remark andColor:color andSize:size];
        }
    }
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

- (void)didFinishedLogin:(LoginViewController *)loginViewController andHud:(MBProgressHUD *)hud
{
    //[self.view addSubview:hud];
}

/***************************获取商品详情接口********************************/
- (IBAction)reLoadMyView:(id)sender
{
    self.loadFailedLabel.hidden = YES;
    [self callGoodsDetaiWebService];
}

//获取商品详情url，调用商品详情接口
- (void)callGoodsDetaiWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/product/product_details"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSLog(@"urlString = %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"self.url = %@",self.url);
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    
    [request setRequestMethod:@"POST"];
    
    [request setTimeOutSeconds:kTimeInterval];
    
    [request setDelegate:self];
    
    [request setDidFailSelector:@selector(requestFailed:)];
    
    [request setDidFinishSelector:@selector(requestFinished:)];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    
    [param setValue:self.url forKey:@"url"];
    
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
        
        NSData *responseData = request.responseData;
        
        //官方的Json速度最快
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dataDictionary = %@",dataDictionary);
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        NSLog(@"data = %@",data);
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        NSDictionary *result = [data objectForKey:@"result"];
        
        if(resultCode == 0)
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"加载失败";
            request.hud.detailsLabelText = errorMessage;
            
            self.loadFailedLabel.hidden = NO;
        }
        else
        {
            //解析商品详情数据
            if ([self resolveGoodsDetail:result])
            {
                [self initMyView];
            }
            else
            {
                request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
                request.hud.mode = MBProgressHUDModeCustomView;
                request.hud.removeFromSuperViewOnHide = YES;
                request.hud.labelText = @"解析失败";
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
        
        self.loadFailedLabel.hidden = NO;
    }
}

- (BOOL)resolveGoodsDetail:(NSDictionary *)result
{
    //id
    if ([result objectForKey:@"num_iid"])
    {
        self.goods.num_iid = [result objectForKey:@"num_iid"];
    }
    else
    {
        return NO;
    }
    
    //图片、图片列表、图片－颜色
    //图片
    if ([result objectForKey:@"goodsimg"])
    {
        self.goods.goodsImage = [result objectForKey:@"goodsimg"];
    }
    else
    {
        return NO;
    }
    
    //图片列表
    if ([result objectForKey:@"item_imgs"])
    {
        self.goods.goodsImageArray = [NSJSONSerialization JSONObjectWithData:[[result objectForKey:@"item_imgs"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }
    else
    {
        return NO;
    }
    
    //图片—颜色
    if ([result objectForKey:@"img_color"])
    {
        self.goods.goodsImageColorDictionary = [NSJSONSerialization JSONObjectWithData:[[result objectForKey:@"img_color"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }
    else
    {
        return NO;
    }
    
    //图文详情
    if ([result objectForKey:@"prop_imgs"])
    {
        self.goods.propImageArray = [NSJSONSerialization JSONObjectWithData:[[result objectForKey:@"prop_imgs"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }
    else
    {
        return NO;
    }
    
    //商品名称
    if ([result objectForKey:@"goodsname"])
    {
        self.goods.name = [result objectForKey:@"goodsname"];
    }
    else
    {
        return NO;
    }
    
    //市场价格
    if ([result objectForKey:@"oldprice"])
    {
        self.goods.marketPrice = [[result objectForKey:@"oldprice"] floatValue];
    }
    else
    {
        return NO;
    }
    
    //实价
    if ([result objectForKey:@"goodsprice"])
    {
        self.goods.realPrice = [[result objectForKey:@"goodsprice"] floatValue];
    }
    else
    {
        return NO;
    }
    
    //实价数组
    if ([result objectForKey:@"price"])
    {
        self.goods.realPriceDictionary = [NSJSONSerialization JSONObjectWithData:[[result objectForKey:@"price"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }
    else
    {
        return NO;
    }
    
    //运费
    if ([result objectForKey:@"yunfei"])
    {
        self.goods.yunfei = [[result objectForKey:@"yunfei"] floatValue];
    }
    else
    {
        return NO;
    }
    
    self.goods.buyQuantity = 1;//默认1件
    
    //数量数组
    if ([result objectForKey:@"quantity"])
    {
        self.goods.kucunDictionary = [NSJSONSerialization JSONObjectWithData:[[result objectForKey:@"quantity"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }
    else
    {
        return NO;
    }
    
    //库存
    if ([result objectForKey:@"kucun"])
    {
        self.goods.kucun = [[result objectForKey:@"kucun"] intValue];
    }
    else
    {
        return NO;
    }
    
    //尺码描述
    if ([result objectForKey:@"size"])
    {
        NSString *sizeArrayStr = [NSString stringWithFormat:@"%@",[result objectForKey:@"size"] ];
        if (sizeArrayStr&&![sizeArrayStr isEqualToString:@""])
        {
            self.goods.sizeArray = [[[result objectForKey:@"size"] componentsSeparatedByString:@","]mutableCopy];
        }
    }
    else
    {
        return NO;
    }
    
    //商品尺码key－value:num－商品尺码描述
    if ([result objectForKey:@"size_number"])
    {
        self.goods.sizeNumberDictionary = [NSJSONSerialization JSONObjectWithData:[[result objectForKey:@"size_number"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }
    else
    {
        return NO;
    }
    
    //商品颜色描述
    if ([result objectForKey:@"color"])
    {
        NSString *colorArrayStr = [NSString stringWithFormat:@"%@",[result objectForKey:@"color"]];
        if (colorArrayStr&&![colorArrayStr isEqualToString:@""])
        {
            self.goods.colorArray = [[[result objectForKey:@"color"] componentsSeparatedByString:@","] mutableCopy];
        }
    }
    else
    {
        return NO;
    }
    
    //商品颜色key－value:num－商品颜色描述
    if ([result objectForKey:@"color_number"])
    {
        self.goods.colorNumberDictionary = [NSJSONSerialization JSONObjectWithData:[[result objectForKey:@"color_number"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }
    else
    {
        return NO;
    }
    
    //店铺Name
    if ([result objectForKey:@"storename"])
    {
        self.goods.storeName = [result objectForKey:@"storename"];
    }
    else
    {
        return NO;
    }
    
    //店铺网页版url
    if ([result objectForKey:@"storeurl"])
    {
        self.goods.storeUrl = [result objectForKey:@"storeurl"];
    }
    
    //店铺旺旺
    if ([result objectForKey:@"sellerurl"])
    {
        NSString *sellerUrlWangWangBase64 = [result objectForKey:@"sellerurl"];
        
        self.goods.sellerUrlWangWang = [CommonFunc textFromBase64String:sellerUrlWangWangBase64];
    }
    
    //掌柜信息
    if ([result objectForKey:@"goodsseller"])
    {
        self.goods.goodsSeller = [result objectForKey:@"goodsseller"];
    }
    else
    {
        return NO;
    }
    
    //店铺url
    if ([result objectForKey:@"mstoreurl"])
    {
        self.goods.mstoreUrl = [result objectForKey:@"mstoreurl"];
    }
    else
    {
        return NO;
    }
    
    if ([result objectForKey:@"model"])
    {
        NSString *modelBase64 = [result objectForKey:@"model"];
        
        self.goods.model = [CommonFunc textFromBase64String:modelBase64];
    }
    else
    {
        return NO;
    }
    
    return YES;
}

/*****************************自助购加入商品清单接口**********************************/
- (void)callAddListWebServiceWithQuantity:(int)quantity andRemark:(NSString *)remark andColor:(NSString *)color andSize:(NSString *)size
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/snatch/snatch_add"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSLog(@"urlString = %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestAddListFailed:)];
    [request setDidFinishSelector:@selector(requestAddListFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    [param setValue:[NSString stringWithFormat:@"%@",self.goods.num_iid] forKey:@"num_iid"];
    [param setValue:[NSString stringWithFormat:@"%@",self.url] forKey:@"href"];
    [param setValue:[NSString stringWithFormat:@"%.2f",self.goods.realPrice] forKey:@"price"];
    [param setValue:[NSString stringWithFormat:@"%@",self.goods.name] forKey:@"name"];
    [param setValue:[NSString stringWithFormat:@"%.2f",self.goods.yunfei] forKey:@"yunfei"];
    [param setValue:[NSString stringWithFormat:@"%@",self.goods.storeName] forKey:@"storename"];
    [param setValue:[NSString stringWithFormat:@"%@",self.goods.storeUrl] forKey:@"storeurl"];
    [param setValue:[NSString stringWithFormat:@"%@",self.goods.goodsImage] forKey:@"thumb"];
    [param setValue:[NSString stringWithFormat:@"%@",color] forKey:@"color"];
    [param setValue:[NSString stringWithFormat:@"%@",size] forKey:@"size"];
    [param setValue:[NSString stringWithFormat:@"%d",quantity] forKey:@"quantity"];
    [param setValue:[NSString stringWithFormat:@"%@",remark] forKey:@"note"];
    
    NSLog(@"param = %@",param);
    NSString *paramJson = [param JSONRepresentation];
    NSLog(@"paramJson = %@",paramJson);
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在加入";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestAddListFinished:(ASIHTTPRequest *)request
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
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"加入失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"success"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"加入商品清单成功";
        }
    }
}

- (void)requestAddListFailed:(ASIHTTPRequest *)request
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

/*****************************代购加入商品清单接口**********************************/
- (void)callAddCartWebServiceWithQuantity:(int)quantity andRemark:(NSString *)remark andColor:(NSString *)color andSize:(NSString *)size
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/cart/cart_addsearch"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestAddCartFailed:)];
    [request setDidFinishSelector:@selector(requestAddCartFinished:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%@",self.goods.num_iid] forKey:@"num_iid"];
    [param setValue:[NSString stringWithFormat:@"%lld",customer.customerid] forKey:@"customerId"];
    [param setValue:[NSString stringWithFormat:@"%@",self.goods.name] forKey:@"name"];
    [param setValue:[NSString stringWithFormat:@"%@",self.url] forKey:@"url"];
    [param setValue:[NSString stringWithFormat:@"%@",self.goods.storeName] forKey:@"storename"];
    [param setValue:[NSString stringWithFormat:@"%@",self.goods.storeUrl] forKey:@"storeurl"];
    [param setValue:[NSString stringWithFormat:@"%@",color] forKey:@"color"];
    [param setValue:[NSString stringWithFormat:@"%@",size] forKey:@"size"];
    [param setValue:[NSString stringWithFormat:@"%d",quantity] forKey:@"quantity"];
    [param setValue:[NSString stringWithFormat:@"%@",remark] forKey:@"remark"];
    [param setValue:[NSString stringWithFormat:@"%@",self.goods.goodsImage] forKey:@"img"];
    [param setValue:[NSString stringWithFormat:@"%.2f",self.goods.realPrice] forKey:@"price"];
    [param setValue:[NSString stringWithFormat:@"%.2f",self.goods.yunfei] forKey:@"yunfei"];
    NSString *paramJson = [param JSONRepresentation];
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在加入";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestAddCartFinished:(ASIHTTPRequest *)request
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
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"加入失败";
            request.hud.detailsLabelText = errorMessage;
        }
        else
        {
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"success"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"加入购物车成功";
        }
    }
}

- (void)requestAddCartFailed:(ASIHTTPRequest *)request
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

@end
