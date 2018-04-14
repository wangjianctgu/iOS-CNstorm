//
//  MD5.h
//  Pods
//
//  Created by Zhang Lisheng on 14-4-18.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5 : NSObject

+ (NSString *)getMd5_32Bit_String:(NSString *)srcString;

+ (NSString *)getMd5_16Bit_String:(NSString *)srcString;

@end
