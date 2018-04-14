//
//  Constant.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-4-15.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constant : NSObject

//声明属性
@property (nonatomic, strong) NSString *ipUrl;//IP地址(内网)
@property (nonatomic, strong) NSString *domainUrl;//域名（外网）
@property (assign, nonatomic) BOOL isRelease;

//单例模式实现方法，获取唯一的系统基本信息常量
+ (Constant *)sharedConstant;

@end
