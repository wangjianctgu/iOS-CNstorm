//
//  RestaurantType.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"

@interface RestaurantType : XubModel
@property(nonatomic ,assign)NSInteger rid;
@property(nonatomic ,retain)NSMutableArray* RestaurantTypeDetails;
@property(nonatomic ,copy)NSString* name;
@property(nonatomic ,retain)NSDate* createdate;
@property(nonatomic ,retain)NSDate* updatedate;
@end
