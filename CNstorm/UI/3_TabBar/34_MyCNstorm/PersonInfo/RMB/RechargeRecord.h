//
//  RechargeRecord.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

//dg_rechargerecord 充值记录
//------- rid 记录id
//------- uid 用户id
//------- uname 用户名
//------- sn 充值编号
//------- amount 充值金额
//------- currency 币种
//------- money 换算过的额度
//------- paytype 充值方式（0转账1支付宝支付2paypal充值3psi充值4其他）
//------- payname 支付方式
//------- addtime 付款发生时间
//------- successtime 付款完成时间
//------- remark 操作备注
//------- state 付款判断（1:失败 2:成功）

@interface RechargeRecord : NSObject

@property (nonatomic, readwrite) long long rid;

@property (nonatomic, readwrite) long long uid;

@property (nonatomic, strong) NSString *uname;

@property (nonatomic, strong) NSString *sn;

@property (nonatomic, readwrite) double amount;

@property (nonatomic, strong) NSString *currency;

@property (nonatomic, readwrite) double money;

@property (nonatomic, readwrite) double accountmoney;

@property (nonatomic, readwrite) int paytype;

@property (nonatomic, strong) NSString *payname;

@property (nonatomic, readwrite) long long addtime;

@property (nonatomic, readwrite) long long successtime;

@property (nonatomic, strong) NSString *remark;

@property (nonatomic, readwrite) int state;

- (id)init;


@end
