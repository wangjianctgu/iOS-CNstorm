//
//  GuideViewController.m
//  LoginTest
//
//  Created by EBS1 on 14-3-19.
//  Copyright (c) 2014年 Foxconn. All rights reserved.
//

#import "GuideViewController.h"

#define kNumberOfPages 4
#define kCurrentPage 0

@interface GuideViewController ()

@end

@implementation GuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initScrollView];
}

-(void)initScrollView
{
    if (MainScreenHeight == 568.0f)
    {
        self.imageArray = [@[@"first5",@"second5",@"third5",@"fourth5"]mutableCopy];
    }
    else
    {
        self.imageArray = [@[@"first",@"second",@"third",@"fourth"]mutableCopy];
    }
    
    // 初始化 scrollImageView
    self.pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight)];
    self.pageScroll.bounces = YES;
    self.pageScroll.pagingEnabled = YES;
    self.pageScroll.delegate = self;
    self.pageScroll.userInteractionEnabled = YES;
    self.pageScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.pageScroll];
    
    // 初始化 pagecontrol
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(110.0f, MainScreenHeight-20.0f,100.0f,7.5f)]; // 初始化mypagecontrol
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f]];
    [self.pageControl setPageIndicatorTintColor:[UIColor colorWithRed:(200.0f/255.0f) green:(200.0f/255.0f) blue:(200.0f/255.0f) alpha:0.8f]];
    self.pageControl.numberOfPages = [self.imageArray count];
    self.pageControl.currentPage = kCurrentPage;
    [self.pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    [self.view addSubview:self.pageControl];

    
    for (int i = 0; i < self.imageArray.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((MainScreenWidth * i),0.0f, MainScreenWidth, MainScreenHeight);
        // 下载图片
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imageArray[i]]]];
        //事件监听
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        // 内容模式
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.pageScroll addSubview:imageView];
        
        if (i == self.imageArray.count-1)
        {
            self.gotoBtn = [[UIButton alloc]initWithFrame:CGRectMake(110.0f,MainScreenHeight-70.0f,100.0f,30.0f)];
            [self.gotoBtn setTitle:@"立即体验" forState:UIControlStateNormal];
            self.gotoBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [self.gotoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.gotoBtn.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
            [self.gotoBtn.layer setCornerRadius:3.0f];
            self.gotoBtn.layer.borderWidth = 0.5f;
            self.gotoBtn.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
            [self.gotoBtn addTarget:self action:@selector(gotoMainView:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:self.gotoBtn];
        }
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.pageScroll.contentSize = CGSizeMake(MainScreenWidth*self.imageArray.count,MainScreenHeight);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = MainScreenWidth;
    int page = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+ 1;
    self.pageControl.currentPage = page;
}

// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = (int)self.pageControl.currentPage; // 获取当前的page
    
    [self.pageScroll scrollRectToVisible:CGRectMake(MainScreenWidth*(page+1),0.0f,MainScreenWidth,MainScreenHeight) animated:NO]; // 触摸pagecontroller那个点 往后翻一页 +1
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"split"] && finished)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedLoadGuideView:)])
        {
            [self.delegate didFinishedLoadGuideView:self];
        }
    }
}

- (IBAction)gotoMainView:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    
    UIImageView *lastImageView = (UIImageView*)[self.pageScroll viewWithTag:(self.imageArray.count-1)];
    
    [UIView beginAnimations:@"split" context:nil];
    //[UIView setAnimationDelegate:self];
    [UIView animateWithDuration:1.35 animations:^{

        lastImageView.transform = CGAffineTransformMakeScale(1.8, 1.8);
        lastImageView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        if (finished)
        {
            lastImageView.alpha = 0.1;
            [self gotoOpenView];
        }
    }];
    [UIView commitAnimations];
}

- (void)gotoOpenView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedLoadGuideView:)])
    {
        [self.delegate didFinishedLoadGuideView:self];
    }
}

@end
