//
//  ViewController.h
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"
#import "ICSDrawerController.h"

@class ViewController;

@protocol ViewControllerDelegate <NSObject>

- (void)didFinishedPushGoodsList:(ViewController *) viewController;

@end

@interface ViewController : UIViewController <SKSTableViewDelegate,ICSDrawerControllerChild,ICSDrawerControllerPresenting>

@property (nonatomic, assign) id <ViewControllerDelegate> delegate;

@property (nonatomic, weak) IBOutlet SKSTableView *tableView;

@property(nonatomic, weak) ICSDrawerController *drawer;

@end
