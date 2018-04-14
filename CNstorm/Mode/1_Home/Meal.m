//
//  Meal.m
//  fanqieDian
//
//  Created by chenzhihui on 13-11-7.
//  Copyright (c) 2013年 chenzhihui. All rights reserved.
//

#import "Meal.h"

@implementation Meal

-(id)initWithID:(NSString *)mid andTitle:(NSString *)title andOther:(NSString *)other andImageUrl:(NSString *)imageUrl andPrice:(NSString *)price andPoint:(NSString *)point andNum:(int)num
{
    if ([super init])
    {
        self.mId=mid;
        
        self.title=title;
        
        self.other=other;
        
        self.imageUrl=imageUrl;
        
        self.price=price;
        
        self.point=point;
        
        self.num=num;
    }
    return self;
}

@end
