//
//  MyAlertView.h
//  Pods
//
//  Created by Zhang Lisheng on 14-4-15.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAlertView : UIAlertView <UIAlertViewDelegate>

//只弹出提示文字的确定按扭，不执行代理方法
//@param    mesageString    提示的肉容。
+ (void)showMessage:(NSString *)messageString;

+ (void)showTitle:(NSString *)titleString Message:(NSString *)messageString;

@end
