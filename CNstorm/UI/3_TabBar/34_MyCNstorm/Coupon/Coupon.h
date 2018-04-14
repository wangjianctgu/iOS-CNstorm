//
//  Coupon.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

//dg_coupon 优惠劵
//------- sn 优惠劵代码
//------- uid 用户id
//------- uname 用户名
//------- getway 获取方式
//------- endtime 有效期结束时间
//------- addtime 优惠券获得时间
//------- money 优惠券面值
//------- sellmoney 销售价格

@interface Coupon : NSObject

@property (nonatomic, readwrite) int cid;

@property (nonatomic, strong) NSString *sn;

@property (nonatomic, readwrite) long long uid;

@property (nonatomic, strong) NSString *uname;

@property (nonatomic, readwrite) int getway;

@property (nonatomic, readwrite) long long endtime;

@property (nonatomic, readwrite) long long addtime;

@property (nonatomic, readwrite) int money;

@property (nonatomic, readwrite) int sellmoney;

@property (nonatomic, readwrite) int state;

- (id)init;

@end
