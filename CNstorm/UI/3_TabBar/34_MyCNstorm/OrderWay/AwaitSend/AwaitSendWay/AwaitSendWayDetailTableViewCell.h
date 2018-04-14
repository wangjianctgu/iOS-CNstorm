//
//  AwaitSendWayDetailTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-17.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

//图片下载并显示
#import "UIImageView+MJWebCache.h"

#import "Goods.h"

@interface AwaitSendWayDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) Goods *goods;//运单商品


@property (nonatomic, strong) UIImageView *goodsImageView;

@property (nonatomic, strong) UILabel *goodsNameLabel;

@property (nonatomic, strong) UILabel *realPriceLabel;

@property (nonatomic, strong) UILabel *colorSizeLabel;

@property (nonatomic, strong) UILabel *remarkLabel;

@property (nonatomic, strong) UILabel *buyQuantityLabel;


@end
