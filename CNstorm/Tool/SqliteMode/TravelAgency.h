//
//  TravelAgency.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"

@interface TravelAgency : XubModel
@property(nonatomic ,assign)NSInteger tid;
@property(nonatomic ,retain)NSMutableArray* TravelAgencyShops;
@property(nonatomic ,copy)NSString* detail;
@end
