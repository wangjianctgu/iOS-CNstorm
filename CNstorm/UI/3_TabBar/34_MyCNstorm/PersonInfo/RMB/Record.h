//
//  Record.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-25.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

//dg_record 消费记录
//------- rid 记录id
//------- uid 用户id
//------- uname 用户名
//------- type 消费类别（1:支出 2:收入）
//------- action 消费行为(1:购买商品 2:国内运费 3:国际运费 5:价格调整 9:账户充值）
//------- money 消费金额（-XXX:支出 XXX:收入）
//------- accountmoney 消费后账户余额
//------- remark 消费详情
//------- addtime 发生时间

//消费记录 收入、支出
@interface Record : NSObject

@property (nonatomic, readwrite) long long rid;

@property (nonatomic, readwrite) long long uid;

@property (nonatomic, strong) NSString *uname;

@property (nonatomic, readwrite) int type;

@property (nonatomic, readwrite) int action;

@property (nonatomic, readwrite) double money;

@property (nonatomic, readwrite) double accountmoney;

@property (nonatomic, strong) NSString *remark;

@property (nonatomic, readwrite) long long addtime;

- (id)init;

@end
