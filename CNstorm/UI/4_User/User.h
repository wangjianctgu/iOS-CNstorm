//
//  User.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-30.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

//------- uid 用户id
//------- uname 用户名
//------- password 密码
//------- email 邮箱
//------- tname 微博昵称
//------- utype 会员等级
//------- sex 性别
//------- tel 电话
//------- zip 邮编
//------- address 地址
//------- country 国家
//------- city 城市
//------- face 头像
//------- scores 积分
//------- money 账户余额
//------- regip 注册ip
//------- regtime 注册时间
//------- loginip 登陆ip
//------- logintime 登陆时间
//------- activekey 账户激活码
//------- state 激活状态（1:激活 0:未激活）
//------- from 用户来源 （网站注册/微博登陆/QQ登陆）
//------- qiandao 签到时间（判断本日是否签到）
//------- question 答题时间（判断本日是否答题）

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, readwrite) long long customer_id;

@property (nonatomic, readwrite) long long store_id;

@property (nonatomic, strong) NSString *firstname;

@property (nonatomic, strong) NSString *lastname;

@property (nonatomic, strong) NSString *sex;

@property (nonatomic, strong) NSString *sexuality;

@property (nonatomic, strong) NSString *birthday;

@property (nonatomic, strong) NSString *email;

@property (nonatomic, strong) NSString *telephone;

@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *marriage;

@property (nonatomic, readwrite) int children;

@property (nonatomic, strong) NSString *education;

@property (nonatomic, strong) NSString *job;

@property (nonatomic, strong) NSString *salary;

@property (nonatomic, strong) NSString *hometown;

@property (nonatomic, strong) NSString *live;

@property (nonatomic, strong) NSString *blog;

@property (nonatomic, readwrite) int scores;

@property (nonatomic, readwrite) float money;

@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSString *salt;

@property (nonatomic, strong) NSString *cart;

@property (nonatomic, strong) NSString *wishlist;

@property (nonatomic, readwrite) int newsletter;

@property (nonatomic, readwrite) long long address_id;

@property (nonatomic, readwrite) long long customer_group_id;

@property (nonatomic, strong) NSString *ip;

@property (nonatomic, readwrite) int status;

@property (nonatomic, readwrite) int approved;

@property (nonatomic, strong) NSString *token;

@property (nonatomic, strong) NSString *date_added;

@property (nonatomic, strong) NSString *qiandao;

@property (nonatomic, strong) NSString *question_dati;

//customer_id

//store_id
//
//firstname//昵称
//
//lastname//真实姓名
//
//sex
//
//sexuality
//
//birthday
//
//email
//
//telephone
//
//mobile
//
//marriage
//
//children
//
//education
//
//job
//
//salary
//
//hometown
//
//live
//
//blog
//
//scores
//
//money
//
//password
//
//salt
//
//cart
//
//newsletter
//
//address_id
//
//customer_group_id
//
//ip
//
//status
//
//approved
//
//token
//
//date_added
//
//qiandao
//
//question_dati

- (id)init;

@end
