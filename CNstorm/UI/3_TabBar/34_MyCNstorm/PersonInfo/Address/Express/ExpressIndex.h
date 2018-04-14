//
//  ExpressIndex.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-15.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpressIndex : NSObject

@property (nonatomic, strong) NSString *indexTitle;

@property (nonatomic, strong) NSMutableArray *expressList;

- (id)init;

@end
