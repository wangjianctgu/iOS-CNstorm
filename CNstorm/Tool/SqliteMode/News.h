//
//  News.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "Collectable.h"
#import "City.h"

@interface News : XubModel
@property(nonatomic ,assign)NSInteger nid;
@property(nonatomic ,retain)Collectable* _Collectable;
@property(nonatomic ,retain)NSMutableArray* NewsRelevants;
@property(nonatomic ,assign)NSInteger cid;
@property(nonatomic ,retain)City* _City;
@property(nonatomic ,copy)NSString* contents;
@property(nonatomic ,assign)BOOL islocal;
@property(nonatomic ,assign)BOOL istop;
@property(nonatomic ,copy)NSString* toppic;
@property(nonatomic ,retain)NSDate* createdate;
@property(nonatomic ,retain)NSDate* exprirydate;
@end
