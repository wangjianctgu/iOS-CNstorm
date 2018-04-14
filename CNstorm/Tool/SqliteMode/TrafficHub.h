//
//  TrafficHub.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "Site.h"

@interface TrafficHub : XubModel
@property(nonatomic ,assign)NSInteger tid;
@property(nonatomic ,retain)Site* _Site;
@property(nonatomic ,assign)NSInteger type;
@end
