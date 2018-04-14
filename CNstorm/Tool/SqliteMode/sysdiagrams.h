//
//  sysdiagrams.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"

@interface sysdiagrams : XubModel
@property(nonatomic ,copy)NSString* name;
@property(nonatomic ,assign)NSInteger principal_id;
@property(nonatomic ,assign)NSInteger diagram_id;
@property(nonatomic ,assign)NSInteger version;
@property(nonatomic ,retain)NSData* definition;
@end
