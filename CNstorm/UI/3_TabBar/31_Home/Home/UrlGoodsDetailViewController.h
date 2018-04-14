//
//  UrlGoodsDetailViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-1.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommonFunc.h"
#import "CPTextViewPlaceholder.h"
#import "UIdefine.h"
#import "ASIRequestImport.h"

#import "GoodsIntroduceViewController.h"
#import "GoodSellerViewController.h"
#import "LoginViewController.h"
#import "MJNavigationController.h"

#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#import "Goods.h"
#import "Customer.h"

//抓取url的商品详情
@interface UrlGoodsDetailViewController : UIViewController <UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,LoginViewControllerDelegate>

@property (nonatomic, readwrite) int buyType;
@property (nonatomic, strong) NSString *url;//抓取url

@property (nonatomic, strong) IBOutlet UIView *myView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *scrollImageView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) IBOutlet UILabel *loadFailedLabel;

@property (nonatomic, strong) UILabel *realPriceLabel;
@property (nonatomic, strong) UITextField *quantityTextField;
@property (nonatomic, strong) UILabel *kucunLabel;
@property (nonatomic, strong) CPTextViewPlaceholder *remarkTextView;

@property (nonatomic, readwrite) float sizeTitleViewHeight;
@property (nonatomic, readwrite) float sizeViewHeight;
@property (nonatomic, readwrite) float colorTitleViewHeight;
@property (nonatomic, readwrite) float colorViewHeight;

@property (nonatomic, strong) Goods *goods;
@property (nonatomic, strong) NSMutableArray *urlArray;
@property (nonatomic, strong) NSMutableArray *sizeButtonArray;
@property (nonatomic, strong) NSMutableArray *colorButtonArray;

@property (nonatomic, strong) NSString *selectedColorId;
@property (nonatomic, strong) NSString *selectedSizeId;
@property (nonatomic, strong) NSString *selectedColor;
@property (nonatomic, strong) NSString *selectedSize;

@end
