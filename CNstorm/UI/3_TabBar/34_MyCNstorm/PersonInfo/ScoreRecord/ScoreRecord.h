//
//  ScoreRecord.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-27.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

//dg_scorerecord 积分记录
//------- sid 记录id
//------- uid 用户id
//------- uname 用户名
//------- remark 积分变更详情
//------- score 获得/减少积分额
//------- totalscore 用户总积分
//------- type 类别（1:获得 2:消费支出）
//------- addtime 发生时间

@interface ScoreRecord : NSObject
//sid
//uid
//uname
//remark
//score
//totalscore
//type
//addtime
@property (nonatomic, readwrite) long long sid;
@property (nonatomic, readwrite) long long uid;
@property (nonatomic, strong) NSString *uname;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, readwrite) long long score;
@property (nonatomic, readwrite) long long totalscore;
@property (nonatomic, readwrite) int type;
@property (nonatomic, readwrite) int addtime;

- (id)init;

@end
