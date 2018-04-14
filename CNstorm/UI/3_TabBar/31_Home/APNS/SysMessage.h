//
//  SysMessage.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SysMessage : NSObject

@property (nonatomic, readwrite) int mid;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *content;

- (id)init;

@end
