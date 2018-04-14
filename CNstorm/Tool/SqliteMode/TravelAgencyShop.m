//
//  TravelAgencyShop.h
//
//  Created by 徐彪
//

#import "TravelAgencyShop.h"

@implementation TravelAgencyShop
@synthesize tasid;
@synthesize tid;
@synthesize _TravelAgency;
@synthesize cid;
@synthesize _City;
@synthesize address;
@synthesize telephone;
@synthesize longitude;
@synthesize latitude;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"tasid",[NSNumber numberWithBool:false],@"tid",[NSNumber numberWithBool:false],@"cid",[NSNumber numberWithBool:false],@"address",[NSNumber numberWithBool:false],@"telephone",[NSNumber numberWithBool:false],@"longitude",[NSNumber numberWithBool:false],@"latitude",nil];
    }
    return self;
}
-(void)setTasid:(NSInteger)_tasid{
    tasid=_tasid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"tasid"];
}
-(void)setTid:(NSInteger)_tid{
    tid=_tid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"tid"];
}
-(void)set_TravelAgency:(TravelAgency*)__TravelAgency{
    _TravelAgency=__TravelAgency;
    self.tid=_TravelAgency.tid;
}
-(void)setCid:(NSInteger)_cid{
    cid=_cid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"cid"];
}
-(void)set_City:(City*)__City{
    _City=__City;
    self.cid=_City.cid;
}
-(void)setAddress:(NSString*)_address{
    address=_address;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"address"];
}
-(void)setTelephone:(NSData*)_telephone{
    telephone=_telephone;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"telephone"];
}
-(void)setLongitude:(double)_longitude{
    longitude=_longitude;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"longitude"];
}
-(void)setLatitude:(double)_latitude{
    latitude=_latitude;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"latitude"];
}
@end
