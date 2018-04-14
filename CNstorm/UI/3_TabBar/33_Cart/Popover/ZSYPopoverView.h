//
//  ZSYPopoverView.h
//  MyCustomTableViewForSelected
//
//  Created by Zhang Lisheng on 14-7-18.
//  Copyright (c) 2014年 zhu shouyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZSYPopoverListViewButtonBlock)();

@class ZSYPopoverView;

@protocol ZSYPopoverViewDelegate <NSObject>

@end

@interface ZSYPopoverView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleName;

@property (nonatomic, strong) UITextField *buyQuantityTextField;

//展示界面
- (void)show;

//消失界面
- (void)dismiss;

//设置确定按钮的标题，如果不设置的话，不显示确定按钮
- (void)setDoneButtonWithTitle:(NSString *)aTitle block:(ZSYPopoverListViewButtonBlock)block;

//设置取消按钮的标题，不设置，按钮不显示
- (void)setCancelButtonTitle:(NSString *)aTitle block:(ZSYPopoverListViewButtonBlock)block;

@end
