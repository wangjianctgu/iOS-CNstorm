//
//  ScoreRecordUsedViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-27.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIDefine.h"

#import "ScoreRecord.h"
//接口
#import "ASIRequestImport.h"
#import "Customer.h"

@class ScoreRecordUsedViewController;
@protocol ScoreRecordUsedViewControllerDelegate <NSObject>

@optional
- (void)didFinishedReturnScoresValue:(float)scoresValue andScores:(int)scores;

@end

@interface ScoreRecordUsedViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, assign) id<ScoreRecordUsedViewControllerDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) ScoreRecord *scoreRecord;

@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *usedscoreLabel;
@property (nonatomic, strong) UITextField *scoreTextField;
                   
@property (nonatomic, strong) UILabel *deduRMBLabel;
@property (nonatomic, readwrite) float deduRMB;
@property (nonatomic, readwrite) int usedScores;

@property (nonatomic, strong) UIButton *commitButton;

@end
