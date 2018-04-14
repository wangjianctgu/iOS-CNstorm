//
//  DeliveryViewController.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-24.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIdefine.h"
#import "Customer.h"
#import "ASIRequestImport.h"

#import "PinYinForObjc.h"
#import "BATableView.h"
#import "BATableViewCell.h"
#import "BATableViewHeaderView.h"

#import "DeliveryIndex.h"
#import "Delivery.h"

@protocol DeliveryViewControllerDelegate <NSObject>

@optional
- (void)didFinishedReturnDelivery:(Delivery *) selectedDelivery;

@end

//选择快递物流公司
@interface DeliveryViewController : UIViewController <BATableViewDelegate>

@property (nonatomic, assign) id<DeliveryViewControllerDelegate> delegate;

@property (nonatomic, strong) BATableView *baTableView;

@property (nonatomic, strong) NSMutableArray *deliveryIndexList;

@property (nonatomic, strong) NSMutableArray *deliveryArray;

@property (nonatomic, readwrite) int selectedAreaId;
@property (nonatomic, readwrite) int isSensitive;

@end
