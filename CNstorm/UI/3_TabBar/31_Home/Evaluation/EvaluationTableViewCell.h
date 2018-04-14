//
//  EvaluationTableViewCell.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Evaluation.h"

#import "PPAImageView.h"

@interface EvaluationTableViewCell : UITableViewCell

@property (nonatomic, strong) Evaluation *evaluation;

@property (nonatomic, strong) PPAImageView *avaterImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *memberGradeLabel;
@property (nonatomic, strong) UILabel *countryLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *replyLabel;

@end
