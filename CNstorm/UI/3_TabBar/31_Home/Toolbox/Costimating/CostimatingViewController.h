//
//  CostimatingViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "ASIRequestImport.h"
#import "Customer.h"
#import "Costimating.h"
#import "CountryViewController.h"
#import "CostimatingListViewController.h"

@interface CostimatingViewController : UIViewController <CountryViewControllerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *replaceBuyButton;

@property (nonatomic, strong) UIButton *selfBuyButton;

@property (nonatomic, strong) UITextField *goodsCostTextField;
@property (nonatomic, strong) UILabel *countryLabel;
@property (nonatomic, strong) UITextField *packageWeightTextField;
@property (nonatomic, strong) UITextField *lengthTextField;
@property (nonatomic, strong) UITextField *widthTextField;
@property (nonatomic, strong) UITextField *heightTextField;
@property (nonatomic, strong) UIButton *commitButton;
@property (nonatomic, strong) NSMutableArray *costimatingList;

@end
