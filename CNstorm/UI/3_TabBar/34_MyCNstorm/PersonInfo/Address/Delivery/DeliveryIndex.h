//
//  DeliveryIndex.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Delivery.h"

@interface DeliveryIndex : NSObject

@property (nonatomic, strong) NSString *indexTitle;

@property (nonatomic, strong) NSMutableArray *deliveryList;

- (id)init;

@end
