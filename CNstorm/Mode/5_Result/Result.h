//
//  Result.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-4-17.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject

@property (nonatomic) int resultCode;

@property (nonatomic, strong) NSString *errorMessage;

@end
