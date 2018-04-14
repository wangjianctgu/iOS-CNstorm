//
//  AskTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-9-26.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AskMessage.h"

@interface AskTableViewCell : UITableViewCell

@property (nonatomic, strong) AskMessage *askMessage;

@property (nonatomic, strong) UILabel *askContentLabel;
@property (nonatomic, strong) UILabel *answerContentLabel;

@end
