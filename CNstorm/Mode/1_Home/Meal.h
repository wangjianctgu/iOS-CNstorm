//
//  Meal.h
//  fanqieDian
//
//  Created by chenzhihui on 13-11-7.
//  Copyright (c) 2013年 chenzhihui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meal : NSObject

@property (strong,nonatomic) NSString *mId;

@property (strong,nonatomic) NSString *title;

@property (strong,nonatomic) NSString *other;

@property (strong,nonatomic) NSString *imageUrl;

@property (strong,nonatomic) NSString *price;

@property (strong,nonatomic) NSString *point;

@property (assign,nonatomic) int num;


-(id)initWithID:(NSString *)mid andTitle:(NSString *)title andOther:(NSString *)other andImageUrl:(NSString *)imageUrl andPrice:(NSString *)price andPoint:(NSString *)point andNum:(int)num;

@end
