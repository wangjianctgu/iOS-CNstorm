//
//  MyAlertView.m
//  Pods
//
//  Created by Zhang Lisheng on 14-4-15.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "MyAlertView.h"

@implementation MyAlertView

+ (void)showMessage:(NSString *)messageString
{
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
                                                      message:messageString
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                            otherButtonTitles:@"确定",nil];
    [alertView show];
    [alertView release];
}

+ (void)showTitle:(NSString *)titleString Message:(NSString *)messageString
{
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:titleString
                                                      message:messageString
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                            otherButtonTitles:@"确定",nil];
    [alertView show];
    [alertView release];
}

@end
