//
//  Trip.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "Collectable.h"
#import "TripOwner.h"
#import "City.h"

@interface Trip : XubModel
@property(nonatomic ,assign)NSInteger tid;
@property(nonatomic ,retain)Collectable* _Collectable;
@property(nonatomic ,retain)NSMutableArray* TripSteps;
@property(nonatomic ,assign)NSInteger oid;
@property(nonatomic ,retain)TripOwner* _TripOwner;
@property(nonatomic ,copy)NSString* detail;
@property(nonatomic ,assign)NSInteger share;
@property(nonatomic ,assign)NSInteger startcid;
@property(nonatomic ,retain)City* _City;
@end
