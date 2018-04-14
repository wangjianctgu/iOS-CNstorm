//
//  EquipmentType.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "EquipmentType.h"

@interface EquipmentType : XubModel
@property(nonatomic ,assign)NSInteger eid;
@property(nonatomic ,retain)NSMutableArray* EquipmentTypes;
@property(nonatomic ,retain)NSMutableArray* ViewSpotEquipments;
@property(nonatomic ,copy)NSString* name;
@property(nonatomic ,assign)NSInteger fathereid;
@property(nonatomic ,retain)EquipmentType* _EquipmentType;
@property(nonatomic ,retain)NSDate* createdate;
@property(nonatomic ,retain)NSDate* updatedate;
@property(nonatomic ,copy)NSString* cid;
@end
