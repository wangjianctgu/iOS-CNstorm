//
//  UIdefine.h
//  TianKeLong
//
//  Created by chenzhihui on 13-9-5.
//  Copyright (c) 2013年 青岛晨之辉信息服务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KxMenu.h"

@interface UIdefine : NSObject

// 公共
#define MainScreenBounds [[UIScreen mainScreen] bounds]
#define MainScreenSize [[UIScreen mainScreen] bounds].size
#define MainScreenWidth [[UIScreen mainScreen] bounds].size.width
#define MainScreenHeight [[UIScreen mainScreen] bounds].size.height
#define StatusbarHeight 20.0f
#define TabBarHeight 49.0f
#define NavigationBarHeight 64.0f
#define NavigationItemHeight 44.0f
#define TableViewFooterViewHeight 12.0f

//首页
#define HomeScrollImageViewHeight 140.0f

//商品详情
#define AddCartTransparentBarHeight 60.0f//加入购物车透明栏
#define ScrollImageViewHeight 250.0f
#define NameViewHeight 50.0f
#define PriceViewHeight 56.0f
#define ScrollViewHeight ScrollImageViewHeight+NameViewHeight+PriceViewHeight
#define DarkViewHeight 12.0f
#define DemonstrationViewHeight 45.0f
#define DarkDemonDarkViewHeight DarkViewHeight+DemonstrationViewHeight+DarkViewHeight
#define SizeTitleViewHeight 45.0f
#define ColorTitleViewHeight 45.0f
#define QuantityViewHeight 55.0f
#define RemarkViewHeight 80.0f
#define SaleViewHeight 50.0f

//购物车
#define TransparentBarHeight 50.0f//透明栏
#define CartTableViewHeaderViewHeight 37.5f

//My
#define CellHeight 64.0f

#define HEight_3 (HEIGTH-50-20-44)/3
#define BG @"bg"
#define systemVesion [[UIDevice currentDevice] systemVersion]
#define MHHeadUrl @"http://api.chenzhihui.com/interface.php?"
#define ImageMHUrl @"http://api.chenzhihui.com"

//color
#define CellBGColor [UIColor colorWithRed:111.0/255 green:67.0/255 blue:15.0/255 alpha:1]
#define MiaoBianColor [UIColor colorWithRed:210.0/255 green:145.0/255 blue:62.0/255 alpha:1]
#define CharColor [UIColor colorWithRed:206.0/255 green:140.0/255 blue:62.0/255 alpha:1]


#define BUNDLE_NAME @"Resource"
#define DefulatImage [UIImage imageNamed:@"123.jpg"]
//新浪微博
#define App_Key @"2543493366"
#define App_Secret @"6d26bf591f35823c6e02a180a23ccc7f"
#define RedirectURI @"http://www.sina.com"
#define IMAGE_NAME @"icon"
#define IMAGE_EXT @"png"
#define CONTENT @"黔乡牧人主题火锅店，拍3D照片，吃特色美食"
#define SHARE_URL @"http://qcyqd.com"

//颜色定义 UIColorDefine
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@end
