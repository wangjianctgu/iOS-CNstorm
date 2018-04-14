//
//  TravelAgencyShop.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "TravelAgency.h"
#import "City.h"

@interface TravelAgencyShop : XubModel
@property(nonatomic ,assign)NSInteger tasid;
@property(nonatomic ,assign)NSInteger tid;
@property(nonatomic ,retain)TravelAgency* _TravelAgency;
@property(nonatomic ,assign)NSInteger cid;
@property(nonatomic ,retain)City* _City;
@property(nonatomic ,copy)NSString* address;
@property(nonatomic ,retain)NSData* telephone;
@property(nonatomic ,assign)double longitude;
@property(nonatomic ,assign)double latitude;
@end
