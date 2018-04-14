//
//  Favorite.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

//dg_favorite 收藏夹
//------- uid 用户id
//------- uname 用户名
//------- goodsurl 商品链接
//------- goodsname 商品名称
//------- goodsprice 商品价格
//------- goodsimg 商品图片
//------- goodsseller 卖家
//------- sellerurl 卖家链接
//------- goodssite 商品来源商城
//------- siteurl 商城链接
//------- addtime 收藏时间


//fid
//uid
//typeid
//uname
//goodsurl
//goodsname
//goodsprice
//goodsimg
//goodsseller
//sellerurl
//goodssite
//siteurl
//addtime

@interface Favorite : NSObject

@property (nonatomic, readwrite) long long fid;

@property (nonatomic, readwrite) long long uid;

@property (nonatomic, readwrite) long long typeid;

@property (nonatomic, strong) NSString *uname;

@property (nonatomic, strong) NSString *goodsurl;

@property (nonatomic, strong) NSString *goodsname;

@property (nonatomic, readwrite) float goodsprice;

@property (nonatomic, strong) NSString *goodsimg;

@property (nonatomic, strong) NSString *goodsseller;

@property (nonatomic, strong) NSString *sellerurl;

@property (nonatomic, strong) NSString *goodssite;

@property (nonatomic, strong) NSString *siteurl;

@property (nonatomic, readwrite) long long addtime;



@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, readwrite) float price;

@property (nonatomic, readwrite) long long product_id;

@property (nonatomic, strong) NSString *thumb;

@property (nonatomic, strong) NSString *model;

- (id)init;

@end
