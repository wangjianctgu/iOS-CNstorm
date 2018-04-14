//
//  Trip.h
//
//  Created by 徐彪
//

#import "Trip.h"

@implementation Trip
@synthesize tid;
@synthesize _Collectable;
@synthesize TripSteps;
@synthesize oid;
@synthesize _TripOwner;
@synthesize detail;
@synthesize share;
@synthesize startcid;
@synthesize _City;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"tid",[NSNumber numberWithBool:false],@"oid",[NSNumber numberWithBool:false],@"detail",[NSNumber numberWithBool:false],@"share",[NSNumber numberWithBool:false],@"startcid",nil];
    }
    return self;
}
-(void)setTid:(NSInteger)_tid{
    tid=_tid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"tid"];
}
-(void)set_Collectable:(Collectable*)__Collectable{
    _Collectable=__Collectable;
    self.tid=_Collectable.cid;
}
-(void)setOid:(NSInteger)_oid{
    oid=_oid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"oid"];
}
-(void)set_TripOwner:(TripOwner*)__TripOwner{
    _TripOwner=__TripOwner;
    self.oid=_TripOwner.oid;
}
-(void)setDetail:(NSString*)_detail{
    detail=_detail;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"detail"];
}
-(void)setShare:(NSInteger)_share{
    share=_share;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"share"];
}
-(void)setStartcid:(NSInteger)_startcid{
    startcid=_startcid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"startcid"];
}
-(void)set_City:(City*)__City{
    _City=__City;
    self.startcid=_City.cid;
}
@end
