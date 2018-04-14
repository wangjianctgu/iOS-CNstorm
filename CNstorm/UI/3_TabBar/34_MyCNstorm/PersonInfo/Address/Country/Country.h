//
//  Country.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (nonatomic, readwrite) int country_id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *iso_code_2;

@property (nonatomic, strong) NSString *iso_code_3;

@property (nonatomic, strong) NSString *address_format;

@property (nonatomic, readwrite) int postcode_required;

@property (nonatomic, readwrite) int status;

- (id)init;

@end
