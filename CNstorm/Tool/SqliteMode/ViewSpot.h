//
//  ViewSpot.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "Site.h"

@interface ViewSpot : XubModel
@property(nonatomic ,assign)NSInteger vid;
@property(nonatomic ,retain)Site* _Site;
@property(nonatomic ,retain)NSMutableArray* ViewSpotEquipments;
@property(nonatomic ,retain)NSMutableArray* ViewSpotTypeDetails;
@property(nonatomic ,assign)double price;
@end
