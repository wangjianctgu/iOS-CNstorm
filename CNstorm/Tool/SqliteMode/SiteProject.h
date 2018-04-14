//
//  SiteProject.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "Site.h"

@interface SiteProject : XubModel
@property(nonatomic ,assign)NSInteger spid;
@property(nonatomic ,assign)NSInteger sid;
@property(nonatomic ,retain)Site* _Site;
@property(nonatomic ,copy)NSString* name;
@property(nonatomic ,assign)double price;
@property(nonatomic ,copy)NSString* picpath;
@end
