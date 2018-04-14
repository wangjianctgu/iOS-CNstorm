//
//  BuyPackage.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-17.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "Package.h"

@interface BuyPackage : Package

//订单清单单身
@property (nonatomic, strong) NSMutableArray *goodsList;//商品列表

@property (nonatomic, readwrite) int packageGoodTypeCount;//订单里的商品种类

@end
