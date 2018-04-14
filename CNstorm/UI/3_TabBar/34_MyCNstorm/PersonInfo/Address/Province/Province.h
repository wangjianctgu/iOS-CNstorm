//
//  Province.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-25.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province : NSObject

@property (nonatomic, readwrite) int zone_id;

@property (nonatomic, readwrite) int country_id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *code;

@property (nonatomic, readwrite) int status;

- (id)init;

@end
