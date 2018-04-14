//
//  NewsRelevant.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "News.h"
#import "Collectable.h"

@interface NewsRelevant : XubModel
@property(nonatomic ,assign)NSInteger nrid;
@property(nonatomic ,assign)NSInteger nid;
@property(nonatomic ,retain)News* _News;
@property(nonatomic ,assign)NSInteger cid;
@property(nonatomic ,retain)Collectable* _Collectable;
@end
