//
//  Site.h
//
//  Created by 徐彪
//

#import "Site.h"

@implementation Site
@synthesize sid;
@synthesize _Collectable;
@synthesize Restaurants;
@synthesize Hotels;
@synthesize TrafficHubs;
@synthesize TripSteps;
@synthesize SiteProjects;
@synthesize ViewSpots;
@synthesize cid;
@synthesize _City;
@synthesize longitude;
@synthesize latitude;
@synthesize type;
@synthesize detail;
@synthesize address;
@synthesize telephone;
@synthesize url;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"sid",[NSNumber numberWithBool:false],@"cid",[NSNumber numberWithBool:false],@"longitude",[NSNumber numberWithBool:false],@"latitude",[NSNumber numberWithBool:false],@"type",[NSNumber numberWithBool:false],@"detail",[NSNumber numberWithBool:false],@"address",[NSNumber numberWithBool:false],@"telephone",[NSNumber numberWithBool:false],@"url",nil];
    }
    return self;
}
-(void)setSid:(NSInteger)_sid{
    sid=_sid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"sid"];
}
-(void)set_Collectable:(Collectable*)__Collectable{
    _Collectable=__Collectable;
    self.sid=_Collectable.cid;
}
-(void)setCid:(NSInteger)_cid{
    cid=_cid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"cid"];
}
-(void)set_City:(City*)__City{
    _City=__City;
    self.cid=_City.cid;
}
-(void)setLongitude:(double)_longitude{
    longitude=_longitude;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"longitude"];
}
-(void)setLatitude:(double)_latitude{
    latitude=_latitude;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"latitude"];
}
-(void)setType:(NSInteger)_type{
    type=_type;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"type"];
}
-(void)setDetail:(NSString*)_detail{
    detail=_detail;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"detail"];
}
-(void)setAddress:(NSString*)_address{
    address=_address;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"address"];
}
-(void)setTelephone:(NSString*)_telephone{
    telephone=_telephone;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"telephone"];
}
-(void)setUrl:(NSString*)_url{
    url=_url;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"url"];
}
@end
