//
//  SearchGoodsViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-12.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
//接口
#import "ASIRequestImport.h"
//搜索拼音匹配
#import "ChineseInclude.h"
#import "PinYinForObjc.h"

//分类列表TreeCell
#import "InfiniteTreeView.h"
#import "GoodsCategoryCell.h"
#import "GoodsSendCategoryCell.h"
#import "GoodsCategory.h"

#import "SearchViewController.h"
#import "GoodsListViewController.h"

@interface SearchGoodsViewController : UIViewController <PushTreeViewDataSource, PushTreeViewDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

//网络连接错误nullView
@property (nonatomic, strong) UIView *nullView;
@property (nonatomic, strong) UILabel *loadFailedLabel;
@property (nonatomic, strong) UILabel *reloadLabel;
@property (nonatomic, strong) UIButton *reloadButton;

//分类部分
@property (nonatomic, strong) InfiniteTreeView *pushTreeView;
//@property (nonatomic, weak) UIView *containerView; //weak会内存被清空
@property (nonatomic, strong) UIView *containerView;//商品分类列表View
@property (nonatomic, strong) NSMutableArray *goodsCategoryList;
@property (nonatomic, strong) NSMutableArray *goodsSecondCategoryList;
@property (nonatomic, readwrite) NSInteger levelindexPathRow;

//存放分类图片
@property (nonatomic, strong) NSMutableArray *categoryImageList;
@property (nonatomic, strong) NSMutableDictionary *categoryImageDictionary;
@property (nonatomic, strong) NSMutableArray *secondCategoryImageList;

@end
