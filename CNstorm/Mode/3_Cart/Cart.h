//
//  Cart.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-22.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StoreGoods.h"

@interface Cart : NSObject

@property (nonatomic, strong) NSMutableArray *storeGoodsArray;

@property (nonatomic, readwrite) bool isAllSelected;

@property (nonatomic, readwrite) float totalCost;

- (id)init;

@end
