//
//  WayValue.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WayValue : NSObject

//  address_id，customerId，zengzhi，cailiao，dingdan，dabao，orderIds（订单编号逗号分隔），deliveryname（快递名），freight（运费），total_freight（总价），all_weight（总重），serverfee（服务费）
@property (nonatomic, readwrite) int addressId;
@property (nonatomic, readwrite) int zengzhi;
@property (nonatomic, readwrite) int cailiao;
@property (nonatomic, readwrite) int dingdan;
@property (nonatomic, readwrite) int dabao;
@property (nonatomic, strong) NSString *orderIds;
@property (nonatomic, readwrite) int deliveryId;
@property (nonatomic, strong) NSString *deliveryname;
@property (nonatomic, readwrite) float freight;
@property (nonatomic, readwrite) float totalFreight;
@property (nonatomic, readwrite) float allWeight;
@property (nonatomic, readwrite) float serverfee;

@property (nonatomic, readwrite) float zengzhiValue;
@property (nonatomic, readwrite) float cailiaoValue;
@property (nonatomic, readwrite) float dingdanValue;
@property (nonatomic, readwrite) float dabaoValue;

@property (nonatomic, readwrite) float firstWeight;
@property (nonatomic, readwrite) float continueWeight;
@property (nonatomic, readwrite) float firstFee;
@property (nonatomic, readwrite) float continueFee;
@property (nonatomic, readwrite) float customsFee;

@property (nonatomic, readwrite) int scores;
@property (nonatomic, readwrite) float scoresValue;
@property (nonatomic, readwrite) int couponId;
@property (nonatomic, readwrite) float couponValue;

- (id) init;

@end
