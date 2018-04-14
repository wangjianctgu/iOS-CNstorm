//
//  TripStep.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "Trip.h"
#import "TripStep.h"
#import "Site.h"

@interface TripStep : XubModel
@property(nonatomic ,assign)NSInteger sid;
@property(nonatomic ,retain)NSMutableArray* TripSteps;
@property(nonatomic ,assign)NSInteger tid;
@property(nonatomic ,retain)Trip* _Trip;
@property(nonatomic ,assign)NSInteger lastsid;
@property(nonatomic ,retain)TripStep* _TripStep;
@property(nonatomic ,assign)NSInteger vehicle;
@property(nonatomic ,retain)NSDate* begintime;
@property(nonatomic ,assign)NSInteger siteid;
@property(nonatomic ,retain)Site* _Site;
@property(nonatomic ,retain)NSDate* arrivaltime;
@property(nonatomic ,copy)NSString* detail;
@end
