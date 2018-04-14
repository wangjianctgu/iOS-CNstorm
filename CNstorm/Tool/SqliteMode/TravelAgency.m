//
//  TravelAgency.h
//
//  Created by 徐彪
//

#import "TravelAgency.h"

@implementation TravelAgency
@synthesize tid;
@synthesize TravelAgencyShops;
@synthesize detail;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"tid",[NSNumber numberWithBool:false],@"detail",nil];
    }
    return self;
}
-(void)setTid:(NSInteger)_tid{
    tid=_tid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"tid"];
}
-(void)setDetail:(NSString*)_detail{
    detail=_detail;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"detail"];
}
@end
