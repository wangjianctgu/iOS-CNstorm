//
//  RadioButton.h
//  travelApp
//
//  Created by 徐彪 on 13-9-3.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioButton : UIButton
{
    NSString* groupId;
}

@property (nonatomic,assign) BOOL isChecked;

- (id)initWithFrame:(CGRect)frame groupId:(NSString*)_groupId;

- (void)removeRadioButton;

@end
