//
//  Constant.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-4-15.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "Constant.h"

@implementation Constant

static Constant *sharedConstant = nil;

//构造函数，此类中主要用于只读属性的初始化
- (id)init
{
    self = [super init];
    if (self)
    {
        //测试环境
        self.ipUrl = @"http://192.168.1.131/cnstorm/index.php?route=app";
        //正式环境
        self.domainUrl = @"http://www.cnstorm.com/index.php?route=app";
        self.isRelease = YES;
    }
    return self;
}

//单例模式实现方法
+ (Constant *)sharedConstant
{
    @synchronized(self)
    {
        if (sharedConstant == nil)
        {
            sharedConstant = [[Constant alloc] init];
            //写法意义相同:sharedConstant = [[self alloc] init];
        }
        return sharedConstant;
    }
}

@end
