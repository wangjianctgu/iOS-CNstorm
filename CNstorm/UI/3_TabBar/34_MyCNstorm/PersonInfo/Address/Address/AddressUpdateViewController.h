//
//  AddressUpdateViewController.h
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

@class AddressUpdateViewController;

@protocol AddressUpdateViewControllerDelegate <NSObject>

@optional
- (void)didFinishedReturn:(AddressUpdateViewController *)addressUpdateViewController andHud:(MBProgressHUD *)hud;

@end

//修改收货地址
@interface AddressUpdateViewController : UIViewController <CountryViewControllerDelegate,ProvinceViewControllerDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, assign) id<AddressUpdateViewControllerDelegate> delegate;

@property (nonatomic, strong) Address *address;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextField *recevicerTextField;

@property (nonatomic, strong) UITextField *telePhoneTextField;

@property (nonatomic, strong) UILabel *countryLabel;

@property (nonatomic, strong) UILabel *provinceLabel;

@property (nonatomic, strong) CPTextViewPlaceholder *addressDetailTextView;

@property (nonatomic, strong) UITextField *mailCodeTextField;

@property (nonatomic, strong) UIButton *setDefaultButton;

@end
