//
//  GoodsListTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-2.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

//图片下载并显示
#import "UIImageView+MJWebCache.h"

#import "Product.h"

@interface GoodsListTableViewCell : UITableViewCell

@property (nonatomic, strong) Product *product;

@property (nonatomic, strong) UIImageView *goodsImageView;

@property (nonatomic, strong) UILabel *goodsNameLabel;

@property (nonatomic, strong) UILabel *realPriceLabel;

@property (nonatomic, strong) UILabel *yunfeiLabel;

@property (nonatomic, strong) UILabel *monthSaleQuantityLabel;

//@property (nonatomic, strong) UILabel *saleAddressLabel;

@end
