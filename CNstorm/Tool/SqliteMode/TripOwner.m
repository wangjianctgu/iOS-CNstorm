//
//  TripOwner.h
//
//  Created by 徐彪
//

#import "TripOwner.h"

@implementation TripOwner
@synthesize oid;
@synthesize Userss;
@synthesize Trips;
@synthesize type;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"oid",[NSNumber numberWithBool:false],@"type",nil];
    }
    return self;
}
-(void)setOid:(NSInteger)_oid{
    oid=_oid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"oid"];
}
-(void)setType:(NSInteger)_type{
    type=_type;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"type"];
}
@end
