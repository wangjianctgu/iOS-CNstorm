//
//  Country_State.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"

@interface Country_State : XubModel
@property(nonatomic ,assign)NSInteger csid;
@property(nonatomic ,retain)NSMutableArray* Citys;
@property(nonatomic ,copy)NSString* name;
@property(nonatomic ,assign)NSInteger continent;
@property(nonatomic ,retain)NSDate* createdate;
@property(nonatomic ,retain)NSDate* updatedate;
@end
