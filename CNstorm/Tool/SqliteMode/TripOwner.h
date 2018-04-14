//
//  TripOwner.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"

@interface TripOwner : XubModel
@property(nonatomic ,assign)NSInteger oid;
@property(nonatomic ,retain)NSMutableArray* Userss;
@property(nonatomic ,retain)NSMutableArray* Trips;
@property(nonatomic ,assign)NSInteger type;
@end
