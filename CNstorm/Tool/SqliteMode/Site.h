//
//  Site.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "Collectable.h"
#import "City.h"

@interface Site : XubModel
@property(nonatomic ,assign)NSInteger sid;
@property(nonatomic ,retain)Collectable* _Collectable;
@property(nonatomic ,retain)NSMutableArray* Restaurants;
@property(nonatomic ,retain)NSMutableArray* Hotels;
@property(nonatomic ,retain)NSMutableArray* TrafficHubs;
@property(nonatomic ,retain)NSMutableArray* TripSteps;
@property(nonatomic ,retain)NSMutableArray* SiteProjects;
@property(nonatomic ,retain)NSMutableArray* ViewSpots;
@property(nonatomic ,assign)NSInteger cid;
@property(nonatomic ,retain)City* _City;
@property(nonatomic ,assign)double longitude;
@property(nonatomic ,assign)double latitude;
@property(nonatomic ,assign)NSInteger type;
@property(nonatomic ,copy)NSString* detail;
@property(nonatomic ,copy)NSString* address;
@property(nonatomic ,copy)NSString* telephone;
@property(nonatomic ,copy)NSString* url;
@end
