//
//  CNstormAppDelegate.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-4-10.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "CNstormAppDelegate.h"

//百度云推送
#import "BPush.h"
#import "JSONKit.h"
#import "OpenUDID.h"

static NSString * const kCNstormStoreName = @"CNstorm.sqlite";

@implementation CNstormAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.openingViewController = [[OpeningViewController alloc]initWithNibName:@"OpeningViewController" bundle:nil];
    self.openingViewController.delegate = self;
    
    //增加标识，用于判断是否是第一次启动应用
    //返回一个和defaultName关联的bool值，如果不存在defaultName的话返回NO
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];//持久化
    }
    
    //第一次启动则加载前导页
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        GuideViewController *guideViewController = [[GuideViewController alloc] init];
        guideViewController.delegate = self;
        self.window.rootViewController = guideViewController;
    }
    else
    {
        self.window.rootViewController = self.openingViewController;
    }
    [self.window.rootViewController.view setNeedsDisplay];
    [self.window makeKeyAndVisible];
    
    //第三方插件初始化
    [self thirdPartInitialize];
    //百度云推送，注册apns
    [self registerApnsWithApplication:application andLaunchOptions:launchOptions];
    //[[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSString *appScheme = @"CNstormAliPay";
    if ([[url scheme] isEqualToString:appScheme] == YES)
    {
        //支付宝
        [self parse:url application:application];
        return YES;
    }
    
    //社交：weibo、QQ
    return [ShareSDK handleOpenURL:url wxDelegate:nil];;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSString *appScheme = @"CNstormAliPay";
    if ([[url scheme] isEqualToString:appScheme] == YES)
    {
        //支付宝
        [self parse:url application:application];
        return YES;
    }
    
    //社交：weibo、QQ
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:nil];
}

/*******************************delegate*****************************/
//加载完前导页后加载open页
- (void)didFinishedLoadGuideView:(GuideViewController *) guideViewController
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0f)
    {
        self.window.rootViewController = self.openingViewController;
    }
    else
    {
        [self.window setRootViewController:self.openingViewController];
        
        [self.window addSubview:self.openingViewController.view];
    }
}

//加载完open页后加载ICSDrawerController（左边导航leftBarView和中间UITabBarView）
- (void)didFinishedLoadOpeningView:(OpeningViewController *)openingViewController
{
    //添加左边导航和中间主页面
    self.tabBarViewController = [[TabBarViewController alloc] initWithNibName:@"TabBarViewController" bundle:nil];
    
    self.window.rootViewController = self.tabBarViewController;
}

/*******************************初始化*****************************/
//第三方插件初始化
- (void)thirdPartInitialize
{
    //初始化PayPal支付环境——输入你的证书－客户端ID（产品－Sandbox沙盒测试）
    [PayPalMobile initializeWithClientIdsForEnvironments:
     @{PayPalEnvironmentProduction:@"AcmbLBAMsXbenzSdHNE9GYwI-KGMQK4flFyOoYTru7VP1k82QNaFktwqWxEb",
       PayPalEnvironmentSandbox:@"AUm-EhBYnCOj-SYRe4Z5TE3DKxwiid97Fy8cD1OKSPndNgBl_VUDMNqlbNgy"}];
    
    //预加载数据库
    [self preloadSqlite];
    
    //注册shareSDK key
    [ShareSDK registerApp:@"1a6f1812a1e0"];//参数为ShareSDK官网中添加应用后得到的AppKey
    [ShareSDK connectSinaWeiboWithAppKey:@"3731466828"
                               appSecret:@"712f29cf7a9bb8873282dec101dbff74"
                             redirectUri:@"http://www.cnstorm.com"];
    
    [ShareSDK connectQZoneWithAppKey:@"100360874"
                           appSecret:@"7a42d46a007a24b36b6db81d23724e21"];
}

//支付宝
- (void)parse:(NSURL *)url application:(UIApplication *)application
{
    NSLog(@"paymentResult 支付宝客户端");
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    NSLog(@"result = %@",result);
    
    if (result)
    {
        if (result.statusCode == 9000)
        {
            /*
             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
             */
            
            //交易成功
            //            NSString* key = @"签约帐户后获取到的支付宝公钥";
            //			id<DataVerifier> verifier;
            //            verifier = CreateRSADataVerifier(key);
            //
            //			if ([verifier verifyString:result.resultString withSign:result.signString])
            //            {
            //                //验证签名成功，交易结果无篡改
            //			}
            
            //回调接口
            ThirdPayViewController *thirdPayViewController = [ThirdPayViewController shareInstance];
            
            NSLog(@"thirdPayViewController.payType = %d",thirdPayViewController.payType);
            
            if (thirdPayViewController.payType == 2)
            {
                [thirdPayViewController thirdRechargeWebService];
            }
            else
            {
                [thirdPayViewController thirdPayWebService];
            }
        }
        else
        {
            //支付失败
            [MBProgressHUD showError:@"取消支付" toView:self.window];
        }
    }
    else
    {
        //失败
        [MBProgressHUD showError:@"取消支付" toView:self.window];
    }
}

- (AlixPayResult *)resultFromURL:(NSURL *)url
{
    NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
    return [[AlixPayResult alloc] initWithString:query];
#endif
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
    AlixPayResult * result = nil;
    
    if (url != nil && [[url host] compare:@"safepay"] == 0) {
        result = [self resultFromURL:url];
    }
    return result;
}


//预加载数据库:创建Sqlite、更新Sqlite
- (void)preloadSqlite
{
    //NSString *date = [ToolMethod DateToString:[NSDate date] formatString:DATEFORMATTER];
    
    //创建并更新sqlite
    NSString *resourcepath = [[NSBundle mainBundle] pathForResource:@"SQLite" ofType:@"json"];
    
    NSLog(@"resourcepath = %@",resourcepath);
    
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *local = [document stringByAppendingPathComponent:@"SQLite.json"];
    
    NSString *dbpath = [document stringByAppendingPathComponent:@"CNstorm.sqlite"];
    
    [CheckSqlite checkSqlite:resourcepath LocalConfigurationPath:local DBPath:dbpath];
    
    //将表结构，数据库路径信息以单例的形式保存到内存，方便调取
    [DataBaseInfo InitDefaultDataBaseInfo:local DBPath:dbpath];
    
    [self initSqliteToDBPath:dbpath];
}

//初始化数据库:存放数据
- (void)initSqliteToDBPath:(NSString *)dbpath
{
    //将测试数据中的数据读取到模型类
    NSString *testdata = [[NSBundle mainBundle]pathForResource:@"testdata" ofType:@"json"];
    
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:testdata] options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray *cities = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in arr)
    {
        City *city = [ToolMethod NSDictionaryToObject:dic ObjectName:@"City"];
        [cities addObject:city];
    }
    
    SqliteHelper *helper = [[SqliteHelper alloc]initWithDataPath:dbpath];
    helper.delegate = self;
    @try
    {
        [helper OpenSqlite];
        [helper BeginTransaction];
        //将测试数据保存到sqlite
        for (City *city in cities)
        {
            if(![helper checkXubModelExist:city])//检查数据库中是否有同一主键的行
                [helper InsertXubModel:city throwEx:false];
            
            if(![helper checkXubModelExist:city._Collectable])
                [helper InsertXubModel:city._Collectable throwEx:false];
            
            for (Site *site in city.Sites)
            {
                if(![helper checkXubModelExist:site])
                    [helper InsertXubModel:site throwEx:false];
                
                if(![helper checkXubModelExist:site._Collectable])
                    [helper InsertXubModel:site._Collectable throwEx:false];
                
                for (ViewSpot *viewspot in site.ViewSpots)
                {
                    if(![helper checkXubModelExist:viewspot])
                        [helper InsertXubModel:viewspot throwEx:false];
                }
            }
        }
        
        [helper CommitTransaction];
    }
    @catch (NSException *exception)
    {
        NSLog(@"[exception reason] = %@",[exception reason]);
        [helper RollbackTransaction];
    }
    @finally
    {
        [helper CloseSqlite];
    }
}

- (void)configurationParameterForStmt:(sqlite3_stmt *)stmt forTag:(NSInteger)tag
{
    
}

- (void)configurationParameterForStmt:(sqlite3_stmt *)stmt forTag:(NSInteger)tag forRow:(NSInteger)row
{
    //    if(tag==100){
    //        City *city=cities[row];
    //        [helper sqlite3_bind_Int:stmt Int:city.cid column:1];
    //        [helper sqlite3_bind_Int:stmt Int:city.csid column:2];
    //        [helper sqlite3_bind_float:stmt Float:city.longitude column:3];
    //         [helper sqlite3_bind_float:stmt Float:city.latitude column:4];
    //        [helper sqlite3_bind_String:stmt String:city.detail column:5];
    //        [helper sqlite3_bind_String:stmt String:city.pinyin column:6];
    //       [helper sqlite3_bind_String:stmt String:city.forshort column:7];
    //        [helper sqlite3_bind_Bool:stmt BOOL:city.istourcity column:8];
    //        [helper sqlite3_bind_Date:stmt Date:city.createdate Formatter:@"yyyy/MM/dd HH:mm:ss" column:9];
    //         [helper sqlite3_bind_Date:stmt Date:city.updatedate Formatter:@"yyyy/MM/dd HH:mm:ss" column:10];
    //    }
}

- (id)manageValueForSelect:(sqlite3_stmt*) stmt forTag:(NSInteger) tag
{
    return nil;
}

#pragma mark - apns
//注册APNS
- (void)registerApnsWithApplication:(UIApplication *)application andLaunchOptions:(NSDictionary *)launchOptions
{
    //判断是否由远程消息通知触发应用程序启动
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]!=nil)
    {
        //获取应用程序消息通知标记数（即小红圈中的数字）
        int badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
        if (badge > 0)
        {
            //如果应用程序消息通知标记数（即小红圈中的数字）大于0，清除标记。
            badge--;
            //清除标记。清除小红圈中数字，小红圈中数字为0，小红圈才会消除。
            [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
        }
        
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if(userInfo)
        {
            [self dealRemoteNotification:userInfo];
        }
    }
    
    [BPush setupChannel:launchOptions];
    [BPush setDelegate:self];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        //UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound; //|UIRemoteNotificationTypeNewsstandContentAvailability
        
        //警告 iOS8.1替换
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        
        [application registerUserNotificationSettings:settings];
    }
    else
    {
        //UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound; //|UIRemoteNotificationTypeNewsstandContentAvailability
        
        //警告 iOS8.1替换
        UIRemoteNotificationType myTypes = UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert;
        
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    NSString *launchOptionsJSONString = @"";
    launchOptionsJSONString= [launchOptionsJSONString stringByAppendingFormat:@"Launch: %@\n", [launchOptions JSONString]];
    NSLog(@"launchOptionsJSONString = %@",launchOptionsJSONString);
    
    //绑定
    [BPush bindChannel];
    //解绑
    //[BPush unbindChannel];
    
}

#if SUPPORT_IOS8
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}
#endif

// 获取DeviceToken成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *deviceTokenString = [[[NSString stringWithFormat:@"%@",deviceToken] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"注册消息推送成功，deviceToken = %@",deviceTokenString);
    //这里进行的操作，是将Device Token发送到服务端
    [BPush registerDeviceToken:deviceToken];
    
    NSString *deviceTokenAndOpenUDID = @"";
    deviceTokenAndOpenUDID= [deviceTokenAndOpenUDID stringByAppendingFormat:@"Register device token: %@\n openudid: %@", deviceToken, [OpenUDID value]];
    NSLog(@"deviceTokenAndOpenUDID = %@",deviceTokenAndOpenUDID);
}

// 注册消息推送失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"注册远程消息推送失败，错误信息是：%@",[error localizedDescription]);
}

// 处理收取到的消息推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //推送反馈
    [BPush handleNotification:userInfo];
    
    //消除应用程序圆角数字
    [application setApplicationIconBadgeNumber:1];
    [application setApplicationIconBadgeNumber:0];
    
    [self dealRemoteNotification:userInfo];
}

- (void)dealRemoteNotification:(NSDictionary *)userInfo
{
    //获取Account用户所有的Message消息
    NSLog(@"Receive Notify: %@",[userInfo JSONString]);
    
    int state = [[userInfo objectForKey:@"state"] intValue];
    
    NSString *alertTitle = @"";
    NSString *alertCount = @"";
    NSString *alertId = @"";
    
    if (state == 0)
    {
        alertTitle = [NSString stringWithFormat:@"CNstorm公告"];
        alertCount = [NSString stringWithFormat:@"%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]];
        
    }
    else if (state == 1)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
        BadgeKeyValue *badgeKeyValue = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:[NSString stringWithFormat:@"%lld",customer.customerid]]];
        badgeKeyValue.myStorageBadge = badgeKeyValue.myStorageBadge+1;
        badgeKeyValue.tabBadge4 = badgeKeyValue.tabBadge4+1;
        [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:badgeKeyValue] forKey:[NSString stringWithFormat:@"%lld",customer.customerid]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addBadgeValue" object:nil];
        
        alertId = [userInfo objectForKey:@"order_id"];
        alertTitle = [NSString stringWithFormat:@"已入库消息推送"];
        alertCount = [NSString stringWithFormat:@"亲爱的CNstorm会员:%@[订单单号%@]",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"],alertId];
    }
    else if (state == 2)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
        BadgeKeyValue *badgeKeyValue = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:[NSString stringWithFormat:@"%lld",customer.customerid]]];
        badgeKeyValue.awaitReceiveBadge = badgeKeyValue.awaitReceiveBadge+1;
        badgeKeyValue.tabBadge4 = badgeKeyValue.tabBadge4+1;
        [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:badgeKeyValue] forKey:[NSString stringWithFormat:@"%lld",customer.customerid]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addBadgeValue" object:nil];
        
        alertId = [userInfo objectForKey:@"order_id"];
        alertTitle = [NSString stringWithFormat:@"已邮寄消息推送"];
        alertCount = [NSString stringWithFormat:@"亲爱的CNstorm会员:%@[运单单号%@]",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"],alertId];
    }
    else if (state == 3)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
        BadgeKeyValue *badgeKeyValue = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:[NSString stringWithFormat:@"%lld",customer.customerid]]];
        badgeKeyValue.allWayBadge = badgeKeyValue.allWayBadge+1;
        badgeKeyValue.tabBadge4 = badgeKeyValue.tabBadge4+1;
        [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:badgeKeyValue] forKey:[NSString stringWithFormat:@"%lld",customer.customerid]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addBadgeValue" object:nil];
        
        alertId = [userInfo objectForKey:@"order_id"];
        alertTitle = [NSString stringWithFormat:@"已确认收货消息推送"];
        alertCount = [NSString stringWithFormat:@"亲爱的CNstorm会员:%@[运单单号%@]",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"],alertId];
    }
    else if (state == 4)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
        BadgeKeyValue *badgeKeyValue = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:[NSString stringWithFormat:@"%lld",customer.customerid]]];
        badgeKeyValue.messageBadge = badgeKeyValue.messageBadge+1;
        [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:badgeKeyValue] forKey:[NSString stringWithFormat:@"%lld",customer.customerid]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addMessageBadgeValue" object:nil];
        
        alertId = [userInfo objectForKey:@"mid"];
        alertTitle = [NSString stringWithFormat:@"系统消息推送"];
        alertCount = [NSString stringWithFormat:@"亲爱的CNstorm会员:%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]];
    }
    else if (state == 5)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
        BadgeKeyValue *badgeKeyValue = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:[NSString stringWithFormat:@"%lld",customer.customerid]]];
        badgeKeyValue.messageBadge = badgeKeyValue.messageBadge+1;
        [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:badgeKeyValue] forKey:[NSString stringWithFormat:@"%lld",customer.customerid]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addMessageBadgeValue" object:nil];
        
        alertId = [userInfo objectForKey:@"mid"];
        alertTitle = [NSString stringWithFormat:@"交易消息推送"];
        alertCount = [NSString stringWithFormat:@"亲爱的CNstorm会员:%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]];
    }
    else if (state == 6)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
        BadgeKeyValue *badgeKeyValue = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:[NSString stringWithFormat:@"%lld",customer.customerid]]];
        badgeKeyValue.messageBadge = badgeKeyValue.messageBadge+1;
        [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:badgeKeyValue] forKey:[NSString stringWithFormat:@"%lld",customer.customerid]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addMessageBadgeValue" object:nil];
        
        alertId = [userInfo objectForKey:@"gid"];
        alertTitle = [NSString stringWithFormat:@"咨询回复推送"];
        alertCount = [NSString stringWithFormat:@"亲爱的CNstorm会员:%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]];
    }
    
    //    if (application.applicationState == UIApplicationStateActive)
    //    {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertCount
                                                       delegate:self
                                              cancelButtonTitle:@"忽略"
                                              otherButtonTitles:@"点击查看",nil];
    alertView.tag = state;
    [alertView show];
    //    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0 && buttonIndex == 1)
    {
        //系统公告
        self.tabBarViewController.selectedIndex = 0;
    }
    else if (alertView.tag == 1 && buttonIndex == 1)
    {
        //入库
        self.tabBarViewController.selectedIndex = 3;
        MyStorageViewController *myStorageViewController = [[MyStorageViewController alloc]initWithNibName:@"MyStorageViewController" bundle:nil];
        myStorageViewController.hidesBottomBarWhenPushed = YES;
        [self.tabBarViewController.myCNstormViewController.navigationController pushViewController:myStorageViewController animated:YES];
    }
    else if (alertView.tag == 2 && buttonIndex == 1)
    {
        //邮寄
        self.tabBarViewController.selectedIndex = 3;
        
        AwaitReceiveViewController *awaitReceiveViewController = [[AwaitReceiveViewController alloc]initWithNibName:@"AwaitReceiveViewController" bundle:nil];
        awaitReceiveViewController.hidesBottomBarWhenPushed = YES;
        [self.tabBarViewController.myCNstormViewController.navigationController pushViewController:awaitReceiveViewController animated:YES];
    }
    else if (alertView.tag == 3 && buttonIndex == 1)
    {
        //运单确认
        self.tabBarViewController.selectedIndex = 3;
        AllWayViewController *allWayViewController = [[AllWayViewController alloc]initWithNibName:@"AllWayViewController" bundle:nil];
        allWayViewController.hidesBottomBarWhenPushed = YES;
        [self.tabBarViewController.myCNstormViewController.navigationController pushViewController:allWayViewController animated:YES];
    }
    else if (alertView.tag == 4 && buttonIndex == 1)
    {
        //系统消息
        self.tabBarViewController.selectedIndex = 0;
        MessageViewController *messageViewController = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
        messageViewController.hidesBottomBarWhenPushed = YES;
        [self.tabBarViewController.homeViewController.navigationController pushViewController:messageViewController animated:YES];
    }
    else if (alertView.tag == 5 && buttonIndex == 1)
    {
        //交易消息
        self.tabBarViewController.selectedIndex = 0;
        MessageViewController *messageViewController = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
        messageViewController.hidesBottomBarWhenPushed = YES;
        messageViewController.index = 1;
        [messageViewController.view bringSubviewToFront:messageViewController.dealView];
        [self.tabBarViewController.homeViewController.navigationController pushViewController:messageViewController animated:YES];
    }
    else if (alertView.tag == 6 && buttonIndex == 1)
    {
        //咨询问题
        self.tabBarViewController.selectedIndex = 0;
        MessageViewController *messageViewController = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
        messageViewController.hidesBottomBarWhenPushed = YES;
        messageViewController.index = 2;
        [messageViewController.view bringSubviewToFront:messageViewController.askView];
        [self.tabBarViewController.homeViewController.navigationController pushViewController:messageViewController animated:YES];
    }
}

- (void)onMethod:(NSString*)method response:(NSDictionary*)data
{
    NSLog(@"On method:%@", method);
    NSLog(@"data:%@", [data description]);
    
    NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
    
    if ([BPushRequestMethod_Bind isEqualToString:method])
    {
        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
        //NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        
        if (returnCode == BPushErrorCode_Success)
        {
            NSLog(@"appid = %@",appid);
            NSLog(@"userid = %@",userid);
            NSLog(@"channelid = %@",channelid);
            
            // 在内存中备份，以便短时间内进入可以看到这些值，而不需要重新bind
            self.appId = appid;
            self.channelId = channelid;
            self.userId = userid;
            
            //            userid = 1050306827442185727
            //            channelid = 4868459025779081708
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:userid forKey:@"userid"];
            [userDefaults setObject:channelid forKey:@"channelid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    }
    else if ([BPushRequestMethod_Unbind isEqualToString:method])
    {
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        if (returnCode == BPushErrorCode_Success)
        {
            //没有绑定的情况，都为空
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults removeObjectForKey:@"userid"];
            [userDefaults removeObjectForKey:@"channelid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
    NSString *methodAnddataDescription = [NSString stringWithFormat: @"%@ return: \n%@", method, [data description]];
    NSLog(@"methodAnddataDescription = %@",methodAnddataDescription);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"appid = %@",self.appId);
    NSLog(@"userid = %@",self.userId);
    NSLog(@"channelid = %@",self.channelId);
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"appid = %@",[BPush getAppId]);
    NSLog(@"userid = %@",[BPush getUserId]);
    NSLog(@"channelid = %@",[BPush getChannelId]);
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
