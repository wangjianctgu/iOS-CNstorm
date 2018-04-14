//
//  PayRecordDetailViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIDefine.h"

#import "Record.h"


@interface PayRecordDetailViewController : UIViewController

@property (nonatomic, strong) Record *record;

@property (nonatomic, strong) UIScrollView *scrollView;

@end
