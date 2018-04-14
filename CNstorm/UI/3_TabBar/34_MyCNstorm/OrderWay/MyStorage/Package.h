//
//  Package.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-16.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Package : NSObject

//订单清单单头
@property (nonatomic, strong) NSString *packageNo;//订单编号

@property (nonatomic, strong) NSString *packageIndex;//订单序号

@property (nonatomic, strong) NSString *packageTitle;//订单标题
//当为购买订单时，订单标题来源于第一个商品的名称;当为代寄订单时，则为用户填写的订单名称

@property (nonatomic, readwrite) float packageWeight;//订单重量

@property (nonatomic, readwrite) int isSensitive;//是否敏感

@property (nonatomic, readwrite) BOOL isSelected;//是否被选择

@property (nonatomic, strong) NSString *packageDate;//订单日期

@property (nonatomic, readwrite) int packageType;//订单类型 0代购／自助购订单、1代寄订单

- (id) init;

@end
