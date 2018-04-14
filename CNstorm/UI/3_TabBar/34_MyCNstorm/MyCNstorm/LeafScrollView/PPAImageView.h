//
//  PPAImageView.h
//  AvatarImageView
//
//  Created by Zhang Lisheng on 14-6-7.
//  Copyright (c) 2014年 <https://github.com/cheng534078182>. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+MJWebCache.h"//图片下载并显示

@interface PPAImageView : UIView

- (id)initWithFrame:(CGRect)frame backgroundProgressColor:(UIColor *)backgroundProgresscolor progressColor:(UIColor *)progressColor;

- (void)setImageURL:(NSString *)URL;

@end

