//
//  Hotel.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "Site.h"

@interface Hotel : XubModel
@property(nonatomic ,assign)NSInteger hid;
@property(nonatomic ,retain)Site* _Site;
@property(nonatomic ,assign)NSInteger starlevel;
@property(nonatomic ,assign)double minprice;
@property(nonatomic ,assign)double maxprice;
@end
