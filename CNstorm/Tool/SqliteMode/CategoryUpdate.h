//
//  CategoryUpdate.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"

@interface CategoryUpdate : XubModel
@property(nonatomic ,copy)NSString* tablename;
@property(nonatomic ,retain)NSDate* updatetime;
@end
