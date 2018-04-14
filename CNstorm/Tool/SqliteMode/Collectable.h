//
//  Collectable.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"

@interface Collectable : XubModel
@property(nonatomic ,assign)NSInteger cid;
@property(nonatomic ,retain)NSMutableArray* Sites;
@property(nonatomic ,retain)NSMutableArray* Trips;
@property(nonatomic ,retain)NSMutableArray* Citys;
@property(nonatomic ,retain)NSMutableArray* Newss;
@property(nonatomic ,retain)NSMutableArray* NewsRelevants;
@property(nonatomic ,retain)NSMutableArray* Pics;
@property(nonatomic ,copy)NSString* title;
@property(nonatomic ,assign)NSInteger type;
@end
