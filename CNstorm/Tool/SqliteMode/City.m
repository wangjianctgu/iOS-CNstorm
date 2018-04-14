//
//  City.h
//
//  Created by 徐彪
//

#import "City.h"

#define DATEFORMATTER @"yyyy/MM/dd HH:mm:ss"

@implementation City
@synthesize cid;
@synthesize _Collectable;
@synthesize Sites;
@synthesize Trips;
@synthesize TravelAgencyShops;
@synthesize Newss;
@synthesize csid;
@synthesize _Country_State;
@synthesize longitude;
@synthesize latitude;
@synthesize detail;
@synthesize pinyin;
@synthesize forshort;
@synthesize istourcity;
@synthesize createdate;
@synthesize updatedate;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"cid",[NSNumber numberWithBool:false],@"csid",[NSNumber numberWithBool:false],@"longitude",[NSNumber numberWithBool:false],@"latitude",[NSNumber numberWithBool:false],@"detail",[NSNumber numberWithBool:false],@"pinyin",[NSNumber numberWithBool:false],@"forshort",[NSNumber numberWithBool:false],@"istourcity",[NSNumber numberWithBool:false],@"createdate",[NSNumber numberWithBool:false],@"updatedate",nil];
    }
    return self;
}
-(void)setCid:(NSInteger)_cid{
    cid=_cid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"cid"];
}
-(void)set_Collectable:(Collectable*)__Collectable{
    _Collectable=__Collectable;
    self.cid=_Collectable.cid;
}
-(void)setCsid:(NSInteger)_csid{
    csid=_csid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"csid"];
}
-(void)set_Country_State:(Country_State*)__Country_State{
    _Country_State=__Country_State;
    self.csid=_Country_State.csid;
}
-(void)setLongitude:(double)_longitude{
    longitude=_longitude;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"longitude"];
}
-(void)setLatitude:(double)_latitude{
    latitude=_latitude;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"latitude"];
}
-(void)setDetail:(NSString*)_detail{
    detail=_detail;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"detail"];
}
-(void)setPinyin:(NSString*)_pinyin{
    pinyin=_pinyin;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"pinyin"];
}
-(void)setForshort:(NSString*)_forshort{
    forshort=_forshort;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"forshort"];
}
-(void)setIstourcity:(BOOL)_istourcity{
    istourcity=_istourcity;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"istourcity"];
}
-(void)setCreatedate:(NSDate*)_createdate{
    if([_createdate isKindOfClass: [NSString class]])
    {
         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
         [dateFormatter setDateFormat: DATEFORMATTER];
        _createdate= [dateFormatter dateFromString:(NSString*)_createdate];
    }
    createdate=_createdate;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"createdate"];
}
-(void)setUpdatedate:(NSDate*)_updatedate{
    if([_updatedate isKindOfClass: [NSString class]])
    {
         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
         [dateFormatter setDateFormat: DATEFORMATTER];
        _updatedate= [dateFormatter dateFromString:(NSString*)_updatedate];
    }
    updatedate=_updatedate;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"updatedate"];
}
@end
