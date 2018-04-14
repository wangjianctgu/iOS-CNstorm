//
//  AddressAddViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-21.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
//接口
#import "ASIRequestImport.h"

#import "MBProgressHUD+Add.h"

#import "Address.h"

#import "CountryViewController.h"

#import "ProvinceViewController.h"

#import "Customer.h"

#import "CPTextViewPlaceholder.h"

@class AddressAddViewController;

@protocol AddressAddViewControllerDelegate <NSObject>

@optional
- (void)didFinishedReturn:(AddressAddViewController *)addressAddViewController;

@end

//新增收货地址
@interface AddressAddViewController : UIViewController <CountryViewControllerDelegate,ProvinceViewControllerDelegate,UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, assign) id<AddressAddViewControllerDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextField *recevicerTextField;

@property (nonatomic, strong) UITextField *telePhoneTextField;

@property (nonatomic, strong) UILabel *countryLabel;

@property (nonatomic, strong) UILabel *provinceLabel;

@property (nonatomic, strong) CPTextViewPlaceholder *addressDetailTextView;

@property (nonatomic, strong) UITextField *mailCodeTextField;

@property (nonatomic, strong) UIButton *setDefaultButton;

@end
