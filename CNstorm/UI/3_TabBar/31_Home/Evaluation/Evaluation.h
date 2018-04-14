//
//  Evaluation.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Evaluation : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *memberGrade;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *reply;

- (id) init;

@end
