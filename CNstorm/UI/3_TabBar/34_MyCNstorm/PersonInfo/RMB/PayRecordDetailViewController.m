//
//  PayRecordDetailViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "PayRecordDetailViewController.h"

@interface PayRecordDetailViewController ()

@end

@implementation PayRecordDetailViewController

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
    
    self.navigationItem.title = @"消费详情";
    
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

- (void)initMyView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView setScrollEnabled:YES];
    [self.view addSubview:self.scrollView];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 104.0f)];
    view1.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:view1];
    
    UILabel *addTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 10.0f, 70.0f, 28.0f)];
    addTimeLabel.text = @"消费日期:";
    addTimeLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    addTimeLabel.font = [UIFont systemFontOfSize:14.0f];
    addTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    addTimeLabel.numberOfLines = 1;
    addTimeLabel.textAlignment = NSTextAlignmentLeft;
    addTimeLabel.adjustsFontSizeToFitWidth = YES;
    addTimeLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:addTimeLabel];
    
    //时间戳转成时间
    NSTimeInterval timeInterval = [[NSString stringWithFormat:@"%lld", self.record.addtime] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    UILabel *addTimeInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(80.0f, 10.0f, 230.0f, 28.0f)];
    addTimeInfoLabel.text = [self stringFromDate:date];
    addTimeInfoLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    addTimeInfoLabel.font = [UIFont systemFontOfSize:13.0f];
    addTimeInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    addTimeInfoLabel.numberOfLines = 1;
    addTimeInfoLabel.textAlignment = NSTextAlignmentLeft;
    addTimeInfoLabel.adjustsFontSizeToFitWidth = YES;
    addTimeInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:addTimeInfoLabel];
    
    UILabel *payLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 38.0f, 70.0f, 28.0f)];
    payLabel.text = @"消费金额:";
    payLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    payLabel.font = [UIFont systemFontOfSize:14.0f];
    payLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    payLabel.numberOfLines = 1;
    payLabel.textAlignment = NSTextAlignmentLeft;
    payLabel.adjustsFontSizeToFitWidth = YES;
    payLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:payLabel];
    
    UILabel *payInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(80.0f, 38.0f, 230.0f, 28.0f)];
    payInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",self.record.money];
    payInfoLabel.textColor = [UIColor colorWithRed:(253.0f/255.0f) green:(78.0f/255.0f) blue:(46.0f/255.0f) alpha:1.0f];
    payInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    payInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    payInfoLabel.numberOfLines = 1;
    payInfoLabel.textAlignment = NSTextAlignmentLeft;
    payInfoLabel.adjustsFontSizeToFitWidth = YES;
    payInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:payInfoLabel];
    
    UILabel *yuerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 66.0f, 70.0f, 28.0f)];
    yuerLabel.text = @"余       额:";
    yuerLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    yuerLabel.font = [UIFont systemFontOfSize:14.0f];
    yuerLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    yuerLabel.numberOfLines = 1;
    yuerLabel.textAlignment = NSTextAlignmentLeft;
    yuerLabel.adjustsFontSizeToFitWidth = YES;
    yuerLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:yuerLabel];
    
    UILabel *yuerInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(80.0f, 66.0f, 230.0f, 28.0f)];
    yuerInfoLabel.text = [NSString stringWithFormat:@"￥%.2f",self.record.accountmoney];
    yuerInfoLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    yuerInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    yuerInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    yuerInfoLabel.numberOfLines = 1;
    yuerInfoLabel.textAlignment = NSTextAlignmentLeft;
    yuerInfoLabel.adjustsFontSizeToFitWidth = YES;
    yuerInfoLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view1 addSubview:yuerInfoLabel];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 104.0f, 320.0f, 46.0f)];
    view2.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.scrollView addSubview:view2];
    
    UILabel *remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 46.0f)];
    remarkLabel.text = self.record.remark;
    remarkLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
    remarkLabel.font = [UIFont systemFontOfSize:14.0f];
    remarkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    remarkLabel.numberOfLines = 3;
    remarkLabel.textAlignment = NSTextAlignmentLeft;
    remarkLabel.adjustsFontSizeToFitWidth = YES;
    remarkLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [view2 addSubview:remarkLabel];
    
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 1.0f)];
    lineView1.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [view2 addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 45.0f, 320.0f, 1.0f)];
    lineView2.backgroundColor = [UIColor colorWithRed:(229.0f/255.0f) green:(229.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
    [view2 addSubview:lineView2];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320.0f,MainScreenHeight-NavigationBarHeight+1.0f);
}

- (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

@end
