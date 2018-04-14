//
//  StoreGoods.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-23.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreGoods : NSObject

@property (nonatomic, strong) NSString *storeName;

@property (nonatomic, readwrite) float storeYunFei;

@property (nonatomic, readwrite) float storeCost;

@property (nonatomic, readwrite) bool isSelected;

@property (nonatomic, strong) NSMutableArray *goodsArray;


- (id)init;

@end
