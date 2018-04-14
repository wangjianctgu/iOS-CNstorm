//
//  TransportOrder.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-14.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

//自寄的国际转运的订单
@interface TransportOrder : NSObject

@property (nonatomic, strong) NSString *orderTitle;//订单标题

@property (nonatomic, strong) NSString *orderRemark;//订单备注

@property (nonatomic, readwrite) int orderStatus;//订单状态
@property (nonatomic, strong) NSString *orderStatusC;//订单状态


@property (nonatomic, strong) NSString *receiveAddress;//收获地址

@property (nonatomic, strong) NSString *mailCode;//邮编

@property (nonatomic, strong) NSString *receiver;//收货人

@property (nonatomic, strong) NSString *telePhone;//电话


@property (nonatomic, strong) NSString *orderDate;//下单日期:用来排序

@property (nonatomic, strong) NSString *orderNo;//订单编号

@property (nonatomic, strong) NSString *express;

@property (nonatomic, strong) NSString *expressNumber;

@end
