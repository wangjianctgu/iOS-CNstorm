//
//  Pic.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "Collectable.h"

@interface Pic : XubModel
@property(nonatomic ,assign)NSInteger pid;
@property(nonatomic ,assign)NSInteger cid;
@property(nonatomic ,retain)Collectable* _Collectable;
@property(nonatomic ,copy)NSString* detail;
@property(nonatomic ,copy)NSString* path;
@end
