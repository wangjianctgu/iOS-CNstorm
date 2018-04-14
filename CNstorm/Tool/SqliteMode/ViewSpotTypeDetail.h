//
//  ViewSpotTypeDetail.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "ViewSpotType.h"
#import "ViewSpot.h"

@interface ViewSpotTypeDetail : XubModel
@property(nonatomic ,assign)NSInteger vtdid;
@property(nonatomic ,retain)ViewSpotType* _ViewSpotType;
@property(nonatomic ,assign)NSInteger vid;
@property(nonatomic ,retain)ViewSpot* _ViewSpot;
@property(nonatomic ,assign)NSInteger vtid;
@end
