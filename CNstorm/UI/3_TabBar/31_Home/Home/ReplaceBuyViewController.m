//
//  ReplaceBuyViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-22.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "ReplaceBuyViewController.h"

@interface ReplaceBuyViewController ()

@end

@implementation ReplaceBuyViewController

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
    
    self.navigationItem.title = @"我要代购";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self initMyView];
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
- (void)initMyView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f,0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:(240.0f/255.0f) green:(240.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f];
    [self.scrollView setScrollEnabled:YES];
    [self.view addSubview:self.scrollView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f,15.0f,290.0f,15.0f)];
    titleLabel.text = [NSString stringWithFormat:@"请输入或粘贴您要代购的商品网址:"];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.scrollView addSubview:titleLabel];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 35.0f, 300.0f, 80.0f)];
    view1.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    view1.layer.cornerRadius = 6.0f;
    view1.layer.borderColor = [UIColor colorWithRed:(214.0f/255.0f) green:(214.0f/255.0f) blue:(214.0f/255.0f) alpha:1.0f].CGColor;
    view1.layer.borderWidth = 0.5f;
    view1.userInteractionEnabled = YES;
    [self.scrollView addSubview:view1];
    
    self.urlTextView = [[UITextView alloc]initWithFrame:CGRectMake(5.0f, 0.0f, 290.0f, 80.0f)];
    self.urlTextView.delegate = self;
    self.urlTextView.textColor = [UIColor colorWithRed:(153.0f/255.0f) green:(153.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0f];
    self.urlTextView.textAlignment = NSTextAlignmentLeft;
    [self.urlTextView setFont:[UIFont systemFontOfSize:14.0f]];
    self.urlTextView.returnKeyType = UIReturnKeyDone;//return键的类型
    self.urlTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.urlTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    [view1 addSubview:self.urlTextView];
    
    self.commitButton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 130.0f, 300.0f,40.0f)];
    [self.commitButton setTitle:@"获取商品信息" forState:UIControlStateNormal];
    self.commitButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commitButton.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
    [self.commitButton.layer setCornerRadius:3.0f];
    self.commitButton.layer.borderWidth = 0.5f;
    self.commitButton.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
    [self.commitButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.commitButton];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.scrollView.contentSize = CGSizeMake(320.0f,MainScreenHeight-NavigationBarHeight+1.0f);
}

- (void)textViewDidEndEditing:(UITextView *)textView;
{
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
    return YES;
}

- (void)commit:(id)sender
{
    [self.urlTextView resignFirstResponder];
    
    float yoffset = -(self.view.center.y-self.commitButton.center.y)+NavigationBarHeight;
    
    if([self.urlTextView.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请粘贴商品url地址" toYOffset:yoffset toView:self.view];
        return;
    }
    
    UrlGoodsDetailViewController *urlGoodsDetailViewController = [[UrlGoodsDetailViewController alloc] initWithNibName:@"UrlGoodsDetailViewController" bundle:nil];
    urlGoodsDetailViewController.url = self.urlTextView.text;
    urlGoodsDetailViewController.buyType = 1;
    [self.navigationController pushViewController:urlGoodsDetailViewController animated:YES];
}

@end
