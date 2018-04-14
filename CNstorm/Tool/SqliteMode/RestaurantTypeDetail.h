//
//  RestaurantTypeDetail.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "Restaurant.h"
#import "RestaurantType.h"

@interface RestaurantTypeDetail : XubModel
@property(nonatomic ,assign)NSInteger rtdid;
@property(nonatomic ,assign)NSInteger rid;
@property(nonatomic ,retain)Restaurant* _Restaurant;
@property(nonatomic ,assign)NSInteger rtid;
@property(nonatomic ,retain)RestaurantType* _RestaurantType;
@end
