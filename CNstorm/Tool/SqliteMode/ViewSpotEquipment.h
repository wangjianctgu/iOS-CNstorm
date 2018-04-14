//
//  ViewSpotEquipment.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "ViewSpot.h"
#import "EquipmentType.h"

@interface ViewSpotEquipment : XubModel
@property(nonatomic ,assign)NSInteger veid;
@property(nonatomic ,assign)NSInteger vid;
@property(nonatomic ,retain)ViewSpot* _ViewSpot;
@property(nonatomic ,assign)NSInteger etid;
@property(nonatomic ,retain)EquipmentType* _EquipmentType;
@end
