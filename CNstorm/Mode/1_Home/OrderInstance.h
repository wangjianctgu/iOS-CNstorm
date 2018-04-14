//
//  OrderInstance.h
//  fanqieDian
//
//  Created by chenzhihui on 13-11-7.
//  Copyright (c) 2013年 chenzhihui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Meal.h"

@interface OrderInstance : NSObject

@property(strong,nonatomic)NSMutableArray *orderArr;

+ (OrderInstance *) sharedInstance;

- (void)addOrder:(Meal *)meal;

- (void)deleOrder:(Meal *)meal;

- (void)addNum:(int)index;

- (void)subNum:(int)index;

- (int)gettotalMealCount;

- (BOOL)hasOredr:(int)mid;

- (float)getTotalPrice;

@end
