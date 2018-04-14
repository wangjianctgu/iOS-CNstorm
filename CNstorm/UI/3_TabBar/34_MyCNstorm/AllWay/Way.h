//
//  Way.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-12.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Way : NSObject

//单头
@property (nonatomic, strong) NSString *wayTitel;//运单标题

@property (nonatomic, readwrite) int wayPackageCount;//运单中订单的数目

@property (nonatomic, readwrite) int wayGoodsTypeCount;//运单中订单中商品种类数目

@property (nonatomic, readwrite) float yunfei;//国际运费

@property (nonatomic, readwrite) bool isCancel;//是否取消

@property (nonatomic, readwrite) int wayStatus;//运单状态


@property (nonatomic, strong) NSString *receiveAddress;//收获地址

@property (nonatomic, strong) NSString *mailCode;//邮编

@property (nonatomic, strong) NSString *receiver;//收货人

@property (nonatomic, strong) NSString *telePhone;//电话

@property (nonatomic, readwrite) float weight;//重量

@property (nonatomic, readwrite) float volume;//体积

@property (nonatomic, strong) NSString *wayNo;//运单编号

@property (nonatomic, strong) NSString *wayDate;//下单日期:用来排序

@property (nonatomic, strong) NSString *express;

@property (nonatomic, strong) NSString *expressNumber;

//单身
@property (nonatomic, strong) NSMutableArray *packageList;//订单列表

- (id) init;

@end
