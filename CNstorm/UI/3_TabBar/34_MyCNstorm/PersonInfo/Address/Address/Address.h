//
//  Address.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-20.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject

@property (nonatomic, readwrite) int addressId;

@property (nonatomic, strong) NSString *recevicer;

@property (nonatomic, strong) NSString *telePhone;

@property (nonatomic, readwrite) int areaId;

@property (nonatomic, readwrite) int countryId;

@property (nonatomic, strong) NSString *country;

@property (nonatomic, readwrite) int provinceId;

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *addressDetail;

@property (nonatomic, strong) NSString *mailCode;

@property (nonatomic, readwrite) int isDefault;

- (id)init;

@end
