//
//  TrafficHub.h
//
//  Created by 徐彪
//

#import "TrafficHub.h"

@implementation TrafficHub
@synthesize tid;
@synthesize _Site;
@synthesize type;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"tid",[NSNumber numberWithBool:false],@"type",nil];
    }
    return self;
}
-(void)setTid:(NSInteger)_tid{
    tid=_tid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"tid"];
}
-(void)set_Site:(Site*)__Site{
    _Site=__Site;
    self.tid=_Site.sid;
}
-(void)setType:(NSInteger)_type{
    type=_type;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"type"];
}
@end
