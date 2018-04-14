//
//  GoodsIntroduceViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-21.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "GoodsIntroduceViewController.h"

@interface GoodsIntroduceViewController ()

@end

@implementation GoodsIntroduceViewController

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
    
    //解决iOS7适配问题，导航栏遮挡了view，通常前两句就能解决问题，不行加后两句
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cancel"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleLabel setText:@"图文详情"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setTextColor:[UIColor whiteColor]];
    titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    self.navigationItem.titleView = titleLabel;
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight)];
    self.webView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    
    NSString *htmlStr = @"<html> <meta name='viewport' content='minimum-scale = 0.6; maximum-scale=10;  initial-scale=1; user-scalable=yes;' width = 320> <body>";
    if (self.propImageArray.count > 0)
    {
        for(NSString *urlStr in self.propImageArray)
        {
            NSLog(@"urlStr = %@",urlStr);
            htmlStr = [htmlStr stringByAppendingString:[NSString stringWithFormat:@"<p> <img src='%@' width='305px'/> </p>", urlStr]];
        }
    }
    htmlStr = [htmlStr stringByAppendingString:@"</body><html>"];
    
    if (htmlStr.length > 0)
    {
        [self.webView loadHTMLString:htmlStr baseURL:nil];
    }
    
    self.webView.scalesPageToFit = YES;
    self.webView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    [self.webView addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:^{
        //这里打个断点，点击按钮模态视图移除后会回到这里
        //ios 5.0以上可以用该方法
    }];
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    int count = (int)self.propImageArray.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++)
    {
        // 替换为中等尺码图片
        NSString *url = [self.propImageArray[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        photo.url = [NSURL URLWithString:url]; // 图片路径
        
        photo.srcImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight)]; // 来源于哪个UIImageView
        
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    
    browser.photos = photos; // 设置所有的图片
    
    [browser show];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

@end
