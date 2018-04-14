//
//  Users.h
//
//  Created by 徐彪
//

#import <Foundation/Foundation.h>
#import "XubModel.h"
#import "TripOwner.h"

@interface Users : XubModel
@property(nonatomic ,assign)NSInteger uid;
@property(nonatomic ,retain)TripOwner* _TripOwner;
@property(nonatomic ,copy)NSString* name;
@property(nonatomic ,copy)NSString* password;
@property(nonatomic ,assign)BOOL male;
@property(nonatomic ,copy)NSString* city;
@property(nonatomic ,copy)NSString* head;
@property(nonatomic ,copy)NSString* qq;
@property(nonatomic ,copy)NSString* email;
@property(nonatomic ,assign)BOOL secrecy;
@end
