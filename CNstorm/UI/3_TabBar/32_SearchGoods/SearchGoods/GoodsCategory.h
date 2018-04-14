//
//  GoodsCategory.h
//  InfiniteTreeView
//
//  Created by Zhang Lisheng on 14-6-3.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsCategory : NSObject

@property (nonatomic, readwrite) long long category_id;

@property (nonatomic, readwrite) int column;

@property (nonatomic, strong) NSString *date_added;

@property (nonatomic, strong) NSString *date_modified;

@property (nonatomic, strong) NSString *desc;//描述description

@property (nonatomic, strong) NSString *image;

@property (nonatomic, readwrite) int language_id;

@property (nonatomic, strong) NSString *meta_description;
@property (nonatomic, strong) NSString *meta_keyword;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, readwrite) long long parent_id;

@property (nonatomic, readwrite) int sort_order;

@property (nonatomic, readwrite) int status;

@property (nonatomic, readwrite) int store_id;

@property (nonatomic, readwrite) int top;

@property (nonatomic, strong) NSMutableArray *goodsCategoryArray;


//重置GoodsCategoryCell
@property (nonatomic, readwrite) CGRect imagefram;
@property (nonatomic, readwrite) CGRect namefram;
@property (nonatomic, readwrite) UIColor *nameColor;
@property (nonatomic, readwrite) BOOL isHiddenNextCategoryName;
@property (nonatomic, readwrite) BOOL isHiddenIndicator;
@property (nonatomic, readwrite) BOOL isHiddenLineView;

- (id)init;

@end
