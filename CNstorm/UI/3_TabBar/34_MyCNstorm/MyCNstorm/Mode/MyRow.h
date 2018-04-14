//
//  MyRow.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-7.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRow : NSObject

@property (nonatomic, strong) NSString *rowImageName;

@property (nonatomic, strong) NSString *rowSelectedImageName;

@property (nonatomic, strong) NSString *rowName;

@property (nonatomic, strong) NSString *rowDetail;

- (id)init;

@end
