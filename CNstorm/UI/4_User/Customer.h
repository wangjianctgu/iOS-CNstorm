//
//  Customer.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-29.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XubModel.h"

@interface Customer : XubModel <NSCoding>

@property (nonatomic, readwrite) long long customerid;//用户ID
@property (nonatomic, copy) NSString *image;//邮箱
@property (nonatomic, copy) NSString *email;//邮箱
@property (nonatomic, copy) NSString *username;//用户名（昵称） －对应－ firstname
@property (nonatomic, copy) NSString *tname;//真实姓名－对应－lastname
@property (nonatomic, copy) NSString *password;//密码
@property (nonatomic, readwrite) long long scores;//积分
@property (nonatomic, readwrite) double money;

@property (nonatomic, copy) NSString *verification;//认证：0 1

- (id)init;

@end
