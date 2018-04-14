//
//  Area.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Area : NSObject

@property (nonatomic, readwrite) int aid; //区域id
@property (nonatomic, strong) NSString *name_cn; //区域中文名
@property (nonatomic, strong) NSString *name_en; //区域英文名
@property (nonatomic, readwrite) float severfeepct; //服务费费率
@property (nonatomic, readwrite) float serverfee; //服务费最高封顶
@property (nonatomic, readwrite) int def; //是否默认
@property (nonatomic, readwrite) int listorder;
@property (nonatomic, readwrite) int state; //区域是否隐藏

@end

//dg_area 运送区域
//------- name_cn 区域中文名
//------- name_en 区域英文名
//------- severfeepct 服务费费率
//------- serverfee 服务费最高封顶
//------- state 区域是否隐藏