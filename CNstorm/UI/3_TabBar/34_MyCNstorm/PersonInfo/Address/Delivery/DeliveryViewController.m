//
//  DeliveryViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "DeliveryViewController.h"

@interface DeliveryViewController ()

@end

@implementation DeliveryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.deliveryIndexList = [NSMutableArray arrayWithCapacity:0];
        self.deliveryArray = [NSMutableArray arrayWithCapacity:0];
        self.isSensitive = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"选择快递物流";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self callDeliveryWebService];
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

- (void)initTableViewData
{
//    NSString *deliveryJson = [[NSBundle mainBundle]pathForResource:@"delivery" ofType:@"json"];
//    NSLog(@"deliveryJson = %@",deliveryJson);
//    
//    NSMutableArray *deliveryArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:deliveryJson] options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *indexArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    
    for (int i = 0; i<26; i++)
    {
        DeliveryIndex *deliveryIndex = [[DeliveryIndex alloc]init];
        deliveryIndex.indexTitle = indexArray[i];
        [self.deliveryIndexList addObject:deliveryIndex];
    }
    
    for (NSMutableDictionary *deliveryDictionary in self.deliveryArray)
    {
        Delivery *delivery = [[Delivery alloc]init];
        
        delivery.areaid = [[deliveryDictionary objectForKey:@"areaid"]intValue];
        delivery.areaname = [deliveryDictionary objectForKey:@"areaname"];
        
        delivery.did = [[deliveryDictionary objectForKey:@"did"]intValue];
        delivery.serverfee = [[deliveryDictionary objectForKey:@"serverfee"]floatValue];
        delivery.deliveryname = [deliveryDictionary objectForKey:@"deliveryname"];
        delivery.delivery_time = [deliveryDictionary objectForKey:@"delivery_time"];
        delivery.senddate = [deliveryDictionary objectForKey:@"senddate"];
        delivery.queryurl = [deliveryDictionary objectForKey:@"queryurl"];
        delivery.carrierLogo = [deliveryDictionary objectForKey:@"carrierLogo"];
        delivery.carrierDesc = [deliveryDictionary objectForKey:@"carrierDesc"];
        
        delivery.first_weight = [[deliveryDictionary objectForKey:@"first_weight"]floatValue];
        delivery.continue_weight = [[deliveryDictionary objectForKey:@"continue_weight"]floatValue];
        delivery.fitst_fee = [[deliveryDictionary objectForKey:@"first_fee"] floatValue];
        delivery.continue_fee = [[deliveryDictionary objectForKey:@"continue_fee"]floatValue];
        delivery.fuel_fee = [[deliveryDictionary objectForKey:@"fuel_fee"]floatValue];
        delivery.customs_fee = [[deliveryDictionary objectForKey:@"customs_fee"]floatValue];
        
        delivery.state = [[deliveryDictionary objectForKey:@"state"]intValue];
        
        delivery.deliveryimg = [deliveryDictionary objectForKey:@"deliveryimg"];
        
        if (self.selectedAreaId == delivery.areaid)
        {
            NSString *deliveryNamePinYinStr = [PinYinForObjc chineseConvertToPinYinHead:delivery.deliveryname];
            if (!deliveryNamePinYinStr||[deliveryNamePinYinStr isEqualToString:@""])
            {
                deliveryNamePinYinStr = delivery.deliveryname;
            }
            
            NSString *deliveryNamePinYinHeadStr = [[deliveryNamePinYinStr substringToIndex:1]uppercaseStringWithLocale:[NSLocale currentLocale]];
            
            for (DeliveryIndex *deliveryIndexTemp in self.deliveryIndexList)
            {
                if([deliveryIndexTemp.indexTitle isEqualToString:deliveryNamePinYinHeadStr])
                {
                    [deliveryIndexTemp.deliveryList addObject:delivery];
                }
            }
        }
    }
    
    //去掉无省份的字母索引
    for(int i=0; i<self.deliveryIndexList.count; i++)
    {
        DeliveryIndex *deliveryIndexTemp = [self.deliveryIndexList objectAtIndex:i];
        
        if(deliveryIndexTemp.deliveryList.count == 0)
        {
            [self.deliveryIndexList removeObjectAtIndex:i];
            i--;
        }
    }
}

// 创建tableView
- (void) createTableView
{
    self.baTableView = [[BATableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight)];
    self.baTableView.delegate = self;
    self.baTableView.tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    self.baTableView.tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.baTableView];
}

//设置cell每行间隔的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

//自定义section的头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BATableViewHeaderView *headerView = [[BATableViewHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 30.0f)];//创建一个视图
    headerView.titleIndexLabel.text = ((DeliveryIndex *)self.deliveryIndexList[section]).indexTitle;
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSArray *) sectionIndexTitlesForABELTableView:(BATableView *)tableView
{
    NSMutableArray *indexTitles = [NSMutableArray array];
    
    for (DeliveryIndex *deliveryIndex in self.deliveryIndexList)
    {
        [indexTitles addObject:deliveryIndex.indexTitle];
    }
    return indexTitles;
}

//缩进10px
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    //遮挡无数据部分tableView的分割线
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    
    return self.deliveryIndexList.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [((DeliveryIndex *)self.deliveryIndexList[section]).deliveryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *BATableViewCellIdentifier = @"BATableViewCellIdentifier";
    
    BATableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BATableViewCellIdentifier];
    if (!cell) {
        cell = [[BATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BATableViewCellIdentifier];
    }
    
    DeliveryIndex *deliveryIndex = (DeliveryIndex *)self.deliveryIndexList[indexPath.section];
    Delivery *delivery = (Delivery *)deliveryIndex.deliveryList[indexPath.row];
    
    cell.title = delivery.deliveryname;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Delivery *selectedDelivery = ((DeliveryIndex *)self.deliveryIndexList[indexPath.section]).deliveryList[indexPath.row];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedReturnDelivery:)])
    {
        [self.delegate didFinishedReturnDelivery:selectedDelivery];
    }
}

/*****************************查询运输方式接口**********************************/
- (void)callDeliveryWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/guoji/address"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSLog(@"urlString = %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestFinished:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%d",self.selectedAreaId] forKey:@"areaid"];
    [param setValue:[NSString stringWithFormat:@"%d",self.isSensitive] forKey:@"mingan"];
    
    NSString *paramJson = [param JSONRepresentation];
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
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *data = [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if(resultCode == 1)
        {
            self.deliveryArray = [data objectForKey:@"result"];
            
            [self initTableViewData];
            
            [self createTableView];
        }
        else
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"加载失败";
            request.hud.detailsLabelText = errorMessage;
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
    }
}

@end
