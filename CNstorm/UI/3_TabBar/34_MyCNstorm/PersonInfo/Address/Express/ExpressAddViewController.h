//
//  ExpressAddViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "ASIRequestImport.h"
#import "Customer.h"
#import "Express.h"
#import "ExpressViewController.h"

@class ExpressAddViewController;

@protocol ExpressAddViewControllerDelegate <NSObject>

@optional
- (void)didFinishedWithExpress:(NSString *)express andNo:(NSString *)expressNo andHud:(MBProgressHUD *)hud;

@end


@interface ExpressAddViewController : UIViewController <UITextViewDelegate,ExpressViewControllerDelegate,UITextFieldDelegate>

@property (nonatomic, assign) id<ExpressAddViewControllerDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) Express *selectedExpress;

@property (nonatomic, strong) UILabel *expressesLabel;

@property (nonatomic, strong) UITextField *expressesNoTextField;

@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, strong) NSString *orderId;

@end
