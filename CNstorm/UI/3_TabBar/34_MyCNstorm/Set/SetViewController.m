//
//  SetViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-4-11.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "SetViewController.h"

#import "UIdefine.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.sectionArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"系统设置";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    self.isShow = NO;

    //初始化数据
    [self initTableViewData];
    [self initMyView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)popToRootView
{
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedReturn:)])
    {
        [self.delegate didFinishedReturn:self];
    }
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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f,0.0f,MainScreenWidth,MainScreenHeight-NavigationBarHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (void)initTableViewData
{
    NSString *mySetJson = [[NSBundle mainBundle]pathForResource:@"mySet" ofType:@"json"];
    
    NSMutableArray *sectionMutableArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:mySetJson] options:NSJSONReadingMutableContainers error:nil];
    
    for (NSMutableArray *mySetionMutableArray in sectionMutableArray)
    {
        MySection *mySection = [[MySection alloc]init];
        
        for (NSMutableDictionary *myRowMutableDictionary in mySetionMutableArray)
        {
            MyRow *myRow = [[MyRow alloc]init];
            myRow.rowImageName = [myRowMutableDictionary objectForKey:@"rowImageName"];
            myRow.rowSelectedImageName = [myRowMutableDictionary objectForKey:@"rowSelectedImageName"];
            myRow.rowName = [myRowMutableDictionary objectForKey:@"rowName"];
            myRow.rowDetail = [myRowMutableDictionary objectForKey:@"rowDetail"];
            [mySection.myRowMutableArray addObject:myRow];
        }
        [self.sectionArray addObject:mySection];
    }
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //遮挡无数据部分tableView的分割线
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    
    return self.sectionArray.count;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MySection *mySection =  self.sectionArray[section];
    
    return mySection.myRowMutableArray.count;
}

//缩进15px
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 15.0f;
}

//设置每行调用的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"MyCNstormTableViewCell";
    
    MyCNstormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                    CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[MyCNstormTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:CellWithIdentifier];
    }
    
    MySection *mySection =  self.sectionArray[indexPath.section];
    cell.myRow = mySection.myRowMutableArray[indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        cell.rowImageViewFram = CGRectMake(20.0f, 14.0f, 16.0f, 18.0f);
        cell.rowDetailLabel.textColor = RGBCOLOR(200.0f,200.0f,200.0f);

        cell.myRow.rowDetail = [NSString stringWithFormat:@"约%.2fM",[self getSize]];

    }
    else if (indexPath.section == 1 && indexPath.row == 2)
    {
        cell.rowImageViewFram = CGRectMake(20.0f, 14.0f, 16.0f, 15.0f);
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        cell.rowImageViewFram = CGRectMake(20.0f, 14.0f, 16.0f, 16.0f);
        cell.rowDetailLabel.textColor = RGBCOLOR(200.0f,200.0f,200.0f);
    }
    else
    {
        cell.rowImageViewFram = CGRectMake(20.0f, 14.0f, 16.0f, 16.0f);
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        MessageAwakeController *messageAwakeController = [[MessageAwakeController alloc]initWithNibName:@"MessageAwakeController" bundle:nil];
        [self.navigationController pushViewController:messageAwakeController animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        [self clearCaches];
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        FeedbackViewController *feedbackViewController = [[FeedbackViewController alloc]initWithNibName:@"FeedbackViewController" bundle:nil];
        [self.navigationController pushViewController:feedbackViewController animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        [self updateVersionWebService];
    }
    else
    {
        AboutMeViewController *aboutMeViewController = [[AboutMeViewController alloc]initWithNibName:@"AboutMeViewController" bundle:nil];
        [self.navigationController pushViewController:aboutMeViewController animated:YES];
    }
}

//设置cell每行间隔的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UITableViewHeaderFooterView *view = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
//    return view;
//}

//设置高度是设置View的前提，高度不能比View的高度小，否则view上面的操作不生效
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 156.0f;
    }
    else
    {
        return 1.0;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
        TableViewFooterView *footerView = [[TableViewFooterView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 156.0f)];
        [footerView.loginOutButton addTarget:self action:@selector(loginOut:) forControlEvents:UIControlEventTouchUpInside];
        return footerView;
    }
    else
    {
        UITableViewHeaderFooterView *footerView = [[UITableViewHeaderFooterView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 1.0f)];
        return footerView;
    }
}

- (void)loginOut:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@""
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:@"退出当前账号"
                                                   otherButtonTitles:nil,nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
//    [actionSheet setTitlesTextColor:[UIColor blackColor]];
//    [actionSheet setTextColors:@[RGBCOLOR(233.0f,64.0f,86.0f), [UIColor blackColor]] forButtonIndexes:@[@(0),@(1)]];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    [actionSheet showInView:self.view];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //退出登录接口
        [self loginOutWebService];
        
//        self.tabBarController.selectedIndex = 0;
//        [self.navigationController popViewControllerAnimated:YES];
//        
//        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"customer"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//        [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
//        [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
    }
}

//清空缓存
- (void)clearCaches
{
    self.clearCachesAlertView = [[UIAlertView alloc]initWithTitle:@"您确认清空缓存吗？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [self.clearCachesAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && alertView == self.clearCachesAlertView)
    {
        dispatch_async(
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                           
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
            
        for (NSString *p in files)
        {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path])
            {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
            
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
        });
    }
    else if (buttonIndex == 1 && alertView == self.updateAlertView)
    {
        NSString *updateURL = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id914402588"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateURL]];
    }
    else if (buttonIndex == 1 && alertView == self.checkAlertView)
    {
        NSString *updateURL = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id914402588"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateURL]];
    }
}

-(void)clearCacheSuccess
{
    [self.tableView reloadData];
    NSLog(@"清理成功");
}

//计算所有文件的大小
- (float)getSize
{
    NSString *cachPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    unsigned long long size = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:cachPath];
    
    for (NSString *fileName in fileEnumerator)
    {
        NSString *filePath = [cachPath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        //size += [attrs fileSize];//计算单个文件的大小
        size += [[attrs objectForKey:NSFileSize] unsignedLongLongValue];
    }
    //得到MB
    float floatSize = size/(1024.00f*1024.00f);
    return floatSize;
}

/***************************退出系统接口******************************/
- (void)loginOutWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/user/logout"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSLog(@"urlString = %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setDidFinishSelector:@selector(requestLoginOut:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [userDefaults stringForKey:@"userid"];
    NSString *channelid = [userDefaults stringForKey:@"channelid"];
    Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%lld", customer.customerid]forKey:@"customerId"];
    [param setValue:userid forKey:@"userid"];
    [param setValue:channelid forKey:@"channelid"];
    [param setValue:[NSString stringWithFormat:@"1"] forKey:@"deviceType"];
    NSString *paramJson = [param JSONRepresentation];
    
    NSLog(@"paramJson = %@",paramJson);
    
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在退出";
    request.hud.detailsLabelText = @"请稍候";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestLoginOut:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSString *responseString =[request responseString];
        NSLog(@"logOut responseString = %@",responseString);
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *data= [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if (resultCode == 1)
        {
            //退出成功
            self.tabBarController.selectedIndex = 0;
            
            //iOS8.1中会导致系统崩溃,替换成popToRootViewControllerAnimated则不会
            //[self.navigationController popViewControllerAnimated:YES];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"customer"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
            [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
        }
        else
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"退出失败";
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
    
    request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
    request.hud.mode = MBProgressHUDModeCustomView;
    request.hud.removeFromSuperViewOnHide = YES;
    request.hud.labelText = @"网络异常";
    request.hud.detailsLabelText = @"请检查网络";
}

/***************************检查版本更新接口******************************/
- (void)updateVersionWebService
{
    NSString *ipDomainUrl = [Constant sharedConstant].isRelease?[Constant sharedConstant].domainUrl:[Constant sharedConstant].ipUrl;
    NSString *fuctionName = [NSString stringWithFormat:@"/app/version"];
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ipDomainUrl,fuctionName];
    NSLog(@"urlString = %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIFormDataRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:kTimeInterval];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestUpdateFailed:)];
    [request setDidFinishSelector:@selector(requestUpdate:)];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    //type，1iPhone、2iPad、3Android
    [param setValue:[NSString stringWithFormat:@"1"] forKey:@"type"];
    NSString *paramJson = [param JSONRepresentation];
    
    NSLog(@"paramJson = %@",paramJson);
    
    [request setPostValue:paramJson forKey:@"param"];
    [request startAsynchronous];//异步传输
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    request.hud.labelText = @"正在检查更新";
    request.hud.detailsLabelText = @"请稍候";
    request.hud.square = YES;
    [request.hud show:YES];
    [self.view addSubview:request.hud];
}

- (void)requestUpdate:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    if (![request error])
    {
        NSString *responseString =[request responseString];
        NSLog(@"Update responseString = %@",responseString);
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *data= [dataDictionary objectForKey:@"data"];
        
        int resultCode = [[data objectForKey:@"resultCode"]intValue];
        
        if (resultCode == 1)
        {
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            //当前app版本号
            NSString *curVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            NSLog(@"curVersion = %@",curVersion);
            
            NSString *version = [data objectForKey:@"result"];
            NSLog(@"version = %@",version);
            
            if ([version isEqualToString:curVersion])
            {
                self.checkAlertView = [[UIAlertView alloc]initWithTitle:@"已是最新版本！" message:@"" delegate:self cancelButtonTitle:@"下次再说" otherButtonTitles:@"去评分", nil];
                [self.checkAlertView show];
            }
            else
            {
                //跳转AppStore
                self.updateAlertView = [[UIAlertView alloc] initWithTitle:@"有新版本可更新" message: @"" delegate:self cancelButtonTitle:@"下次再说" otherButtonTitles:@"前往更新", nil];
                [self.updateAlertView show];
            }
        }
        else
        {
            NSString *errorMessage = [data objectForKey:@"errorMessage"];
            request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
            request.hud.mode = MBProgressHUDModeCustomView;
            request.hud.removeFromSuperViewOnHide = YES;
            request.hud.labelText = @"检查更新失败";
            request.hud.detailsLabelText = errorMessage;
        }
    }
}

- (void)requestUpdateFailed:(ASIHTTPRequest *)request
{
    if (request.hud)
    {
        [request.hud hide:YES afterDelay:1.5f];
    }
    
    request.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"error"]]];
    request.hud.mode = MBProgressHUDModeCustomView;
    request.hud.removeFromSuperViewOnHide = YES;
    request.hud.labelText = @"网络异常";
    request.hud.detailsLabelText = @"请检查网络";
}


@end
