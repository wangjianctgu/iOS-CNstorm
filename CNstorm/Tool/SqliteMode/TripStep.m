//
//  TripStep.h
//
//  Created by 徐彪
//

#import "TripStep.h"

#define DATEFORMATTER @"yyyy/MM/dd HH:mm:ss"

@implementation TripStep
@synthesize sid;
@synthesize TripSteps;
@synthesize tid;
@synthesize _Trip;
@synthesize lastsid;
@synthesize _TripStep;
@synthesize vehicle;
@synthesize begintime;
@synthesize siteid;
@synthesize _Site;
@synthesize arrivaltime;
@synthesize detail;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"sid",[NSNumber numberWithBool:false],@"tid",[NSNumber numberWithBool:false],@"lastsid",[NSNumber numberWithBool:false],@"vehicle",[NSNumber numberWithBool:false],@"begintime",[NSNumber numberWithBool:false],@"siteid",[NSNumber numberWithBool:false],@"arrivaltime",[NSNumber numberWithBool:false],@"detail",nil];
    }
    return self;
}
-(void)setSid:(NSInteger)_sid{
    sid=_sid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"sid"];
}
-(void)setTid:(NSInteger)_tid{
    tid=_tid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"tid"];
}
-(void)set_Trip:(Trip*)__Trip{
    _Trip=__Trip;
    self.tid=_Trip.tid;
}
-(void)setLastsid:(NSInteger)_lastsid{
    lastsid=_lastsid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"lastsid"];
}
-(void)set_TripStep:(TripStep*)__TripStep{
    _TripStep=__TripStep;
    self.lastsid=_TripStep.sid;
}
-(void)setVehicle:(NSInteger)_vehicle{
    vehicle=_vehicle;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"vehicle"];
}
-(void)setBegintime:(NSDate*)_begintime{
    if([_begintime isKindOfClass: [NSString class]])
    {
         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
         [dateFormatter setDateFormat: DATEFORMATTER];
        _begintime= [dateFormatter dateFromString:(NSString*)_begintime];
    }
    begintime=_begintime;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"begintime"];
}
-(void)setSiteid:(NSInteger)_siteid{
    siteid=_siteid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"siteid"];
}
-(void)set_Site:(Site*)__Site{
    _Site=__Site;
    self.siteid=_Site.sid;
}
-(void)setArrivaltime:(NSDate*)_arrivaltime{
    if([_arrivaltime isKindOfClass: [NSString class]])
    {
         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
         [dateFormatter setDateFormat: DATEFORMATTER];
        _arrivaltime= [dateFormatter dateFromString:(NSString*)_arrivaltime];
    }
    arrivaltime=_arrivaltime;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"arrivaltime"];
}
-(void)setDetail:(NSString*)_detail{
    detail=_detail;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"detail"];
}
@end
