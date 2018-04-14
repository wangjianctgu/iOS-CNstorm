//
//  Goods.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-15.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject

@property (nonatomic, readwrite) long long goodsId;

@property (nonatomic, strong) NSString *num_iid;//淘宝id

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *goodsImage;

@property (nonatomic, strong) NSMutableArray *goodsImageArray;

@property (nonatomic, strong) NSMutableDictionary *goodsImageColorDictionary;

@property (nonatomic, strong) NSMutableArray *propImageArray;


@property (nonatomic, readwrite) float marketPrice;

@property (nonatomic, readwrite) float realPrice;

@property (nonatomic, strong) NSMutableDictionary *realPriceDictionary;

@property (nonatomic, readwrite) float yunfei;

@property (nonatomic, readwrite) int monthSaleQuantity;

@property (nonatomic, strong) NSString *saleAddress;


@property (nonatomic, readwrite) int buyQuantity;

@property (nonatomic, strong) NSMutableArray *quantityArray;

@property (nonatomic, readwrite) int kucun;

@property (nonatomic, strong) NSMutableDictionary *kucunDictionary;


@property (nonatomic, strong) NSString *buySize;

@property (nonatomic, strong) NSMutableArray *sizeArray;

@property (nonatomic, strong) NSMutableDictionary *sizeNumberDictionary;


@property (nonatomic, strong) NSString *color;

@property (nonatomic, strong) NSMutableArray *colorArray;

@property (nonatomic, strong) NSMutableDictionary *colorNumberDictionary;


@property (nonatomic, strong) NSString *remark;


@property (nonatomic, strong) NSString *goodsSeller;//掌柜信息

@property (nonatomic, strong) NSString *storeUrl;//店铺url

@property (nonatomic, strong) NSString *mstoreUrl;//手机店铺url

@property (nonatomic, strong) NSString *storeName;//店铺名称

@property (nonatomic, strong) NSString *sellerUrlWangWang;//阿里旺旺url

@property (nonatomic, strong) NSString *model;//

@property (nonatomic, readwrite) bool isSelected;

- (id) init;

@end
