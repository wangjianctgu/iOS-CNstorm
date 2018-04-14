//
//  CountryIndex.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryIndex : NSObject

@property (nonatomic, strong) NSString *indexTitle;

@property (nonatomic, strong) NSMutableArray *countryList;

- (id)init;

@end
