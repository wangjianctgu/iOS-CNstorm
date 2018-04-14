//
//  City.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "Collectable.h"
#import "Country_State.h"

@interface City : XubModel
@property(nonatomic ,assign)NSInteger cid;
@property(nonatomic ,retain)Collectable* _Collectable;
@property(nonatomic ,retain)NSMutableArray* Sites;
@property(nonatomic ,retain)NSMutableArray* Trips;
@property(nonatomic ,retain)NSMutableArray* TravelAgencyShops;
@property(nonatomic ,retain)NSMutableArray* Newss;
@property(nonatomic ,assign)NSInteger csid;
@property(nonatomic ,retain)Country_State* _Country_State;
@property(nonatomic ,assign)double longitude;
@property(nonatomic ,assign)double latitude;
@property(nonatomic ,copy)NSString* detail;
@property(nonatomic ,copy)NSString* pinyin;
@property(nonatomic ,copy)NSString* forshort;
@property(nonatomic ,assign)BOOL istourcity;
@property(nonatomic ,retain)NSDate* createdate;
@property(nonatomic ,retain)NSDate* updatedate;
@end
