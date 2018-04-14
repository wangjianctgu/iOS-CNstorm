//
//  Costimating.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-30.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Costimating : NSObject

@property (nonatomic, readwrite) int cid;

@property (nonatomic, strong) NSString *carrierLogo;

@property (nonatomic, readwrite) double customsFee;

@property (nonatomic, strong) NSString *deliveryName;

@property (nonatomic, strong) NSString *deliveryTime;

@property (nonatomic, readwrite) double freight;

@property (nonatomic, readwrite) double servefee;

@property (nonatomic, readwrite) double total;

- (id)init;

@end
