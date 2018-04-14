//
//  ExpressShowViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "ExpressShowViewController.h"

@interface ExpressShowViewController ()

@end

@implementation ExpressShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"物流查询";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cancel"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0.0f,4.0f, MainScreenWidth, MainScreenHeight+66.0f)];
    [self.webView setUserInteractionEnabled:YES];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setDelegate:self];
    [self.webView setOpaque:NO];//使网页透明
    self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    
    if (self.url.length > 0)
    {
        NSURL *url = [NSURL URLWithString:self.url];//创建URL
        NSURLRequest *request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        [self.webView loadRequest:request];//加载
    }
    self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [self.view addSubview:self.webView];
    
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    [view setTag:100];
    [view setBackgroundColor:[UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:0.9f]];
    [self.view addSubview:view];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [self.activityIndicator setCenter:view.center];
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [view addSubview:self.activityIndicator];
    [self.view addSubview:self.webView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"back");//这里打个断点，点击按钮模态视图移除后会回到这里
        //ios 5.0以上可以用该方法
    }];
}

//几个代理方法
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
    UIView *view = (UIView *)[self.view viewWithTag:100];
    [view removeFromSuperview];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD showError:@"加载失败" toView:self.view];
}

@end

