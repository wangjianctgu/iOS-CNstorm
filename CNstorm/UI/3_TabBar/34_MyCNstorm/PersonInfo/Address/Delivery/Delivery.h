//
//  Delivery.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Delivery : NSObject

@property (nonatomic, readwrite) int did; //快递公司id

//外键
@property (nonatomic, readwrite) int areaid; //区域id
@property (nonatomic, strong) NSString *areaname; //区域名称
@property (nonatomic, readwrite) float serverfee;

@property (nonatomic, strong) NSString *deliveryname;//快递公司名字
@property (nonatomic, strong) NSString *delivery_time; //快递时效

@property (nonatomic, strong) NSString *senddate;

@property (nonatomic, strong) NSString *queryurl; //快递查询地址
@property (nonatomic, strong) NSString *carrierLogo; //快递公司logo
@property (nonatomic, strong) NSString *carrierDesc; //快递公司简介

@property (nonatomic, readwrite) float first_weight; //首重标准
@property (nonatomic, readwrite) float continue_weight; //续重标准
@property (nonatomic, readwrite) float fitst_fee; //首重价格
@property (nonatomic, readwrite) float continue_fee; //续重价格
@property (nonatomic, readwrite) float fuel_fee;
@property (nonatomic, readwrite) float customs_fee; //报关收费
@property (nonatomic, readwrite) int state; //是否隐藏该快递方式

@property (nonatomic, strong) NSString *deliveryimg;

//@property (nonatomic, readwrite) BOOL isSensitive;//是否可寄送敏感物品

- (id)init;

@end

//dg_delivery 邮寄方式
//------- areaid 区域id
//------- areaname 区域名称
//------- deliveryname 快递公司名字
//------- delivery_time 快递时效
//------- queryurl 快递查询地址
//------- carrierLogo 快递公司logo
//------- carrierDesc 快递公司简介
//------- first_weight 首重标准
//------- continue_weight 续重标准
//------- fitst_fee 首重价格
//------- continue_fee 续重价格
//------- customs_fee 报关收费
//------- state 是否隐藏该快递方式

//1	did	int(11)
//2   areaid	int(11)
//3	areaname	varchar(50)
//4	serverfee	float(10,2)
//5	deliveryname	varchar(50)
//6	delivery_time	varchar(20)
//7	senddate varchar(50)
//8	queryurl	varchar(255)
//9	carrierLogo	varchar(255)
//10	carrierDesc	varchar(255)
//11	first_weight	float(10,2)
//12	continue_weight	float(10,2)
//13	first_fee	float(10,2)
//14	continue_fee	float(10,2)
//15	fuel_fee	float(10,2)
//16	customs_fee	float(10,2)
//17	state	smallint(5)
//18	deliveryimg	varchar(255)