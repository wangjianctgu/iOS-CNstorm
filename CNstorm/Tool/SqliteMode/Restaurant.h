//
//  Restaurant.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "Site.h"

@interface Restaurant : XubModel
@property(nonatomic ,assign)NSInteger rid;
@property(nonatomic ,retain)Site* _Site;
@property(nonatomic ,retain)NSMutableArray* RestaurantTypeDetails;
@property(nonatomic ,assign)double price;
@end
