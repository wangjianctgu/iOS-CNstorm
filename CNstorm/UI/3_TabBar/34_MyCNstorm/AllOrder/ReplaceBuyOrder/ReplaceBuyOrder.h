//
//  ReplaceBuyOrder.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-13.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

//按店铺区分的代购订单
@interface ReplaceBuyOrder : NSObject

//单头
@property (nonatomic, strong) NSString *storeName;//店铺名称

@property (nonatomic, strong) NSString *orderImage;//订单图像

@property (nonatomic, strong) NSString *orderTitle;//订单标题

@property (nonatomic, readwrite) int orderGoodTypeCount;//订单商品种类

@property (nonatomic, readwrite) float orderAllCost;//订单总计

@property (nonatomic, readwrite) int orderStatus;//订单状态
@property (nonatomic, strong) NSString *orderStatusC;//订单状态

@property (nonatomic, strong) NSString *receiveAddress;//收获地址

@property (nonatomic, strong) NSString *mailCode;//邮编

@property (nonatomic, strong) NSString *receiver;//收货人

@property (nonatomic, strong) NSString *telePhone;//电话


@property (nonatomic, readwrite) float yunfei;//订单运费

@property (nonatomic, strong) NSString *orderDate;//下单日期:用来排序

@property (nonatomic, strong) NSString *orderNo;//订单编号

@property (nonatomic, strong) NSString *express;

@property (nonatomic, strong) NSString *expressNumber;

//单身
@property (nonatomic, strong) NSMutableArray *goodsList;//商品列表

@end
