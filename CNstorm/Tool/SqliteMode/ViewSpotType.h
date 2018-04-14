//
//  ViewSpotType.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"

@interface ViewSpotType : XubModel
@property(nonatomic ,assign)NSInteger vid;
@property(nonatomic ,retain)NSMutableArray* ViewSpotTypeDetails;
@property(nonatomic ,copy)NSString* name;
@property(nonatomic ,retain)NSDate* createdate;
@property(nonatomic ,retain)NSDate* updatedate;
@end
