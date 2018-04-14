//
//  AskMessage.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-9-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AskMessage : NSObject

@property (nonatomic, readwrite) int gid;

@property (nonatomic, strong) NSString *askContent;

@property (nonatomic, strong) NSString *answerContent;

- (id) init;

@end
