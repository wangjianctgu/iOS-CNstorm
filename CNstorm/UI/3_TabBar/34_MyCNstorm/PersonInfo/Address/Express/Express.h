//
//  Express.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-15.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Express : NSObject

@property (nonatomic, readwrite) int expressId; //快递公司id

@property (nonatomic, strong) NSString *name_cn;

@property (nonatomic, strong) NSString *name_en;

- (id)init;

@end
