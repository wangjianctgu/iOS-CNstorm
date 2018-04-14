//
//  RestaurantTypeDetail.h
//
//  Created by 徐彪
//

#import "RestaurantTypeDetail.h"

@implementation RestaurantTypeDetail
@synthesize rtdid;
@synthesize rid;
@synthesize _Restaurant;
@synthesize rtid;
@synthesize _RestaurantType;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"rtdid",[NSNumber numberWithBool:false],@"rid",[NSNumber numberWithBool:false],@"rtid",nil];
    }
    return self;
}
-(void)setRtdid:(NSInteger)_rtdid{
    rtdid=_rtdid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"rtdid"];
}
-(void)setRid:(NSInteger)_rid{
    rid=_rid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"rid"];
}
-(void)set_Restaurant:(Restaurant*)__Restaurant{
    _Restaurant=__Restaurant;
    self.rid=_Restaurant.rid;
}
-(void)setRtid:(NSInteger)_rtid{
    rtid=_rtid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"rtid"];
}
-(void)set_RestaurantType:(RestaurantType*)__RestaurantType{
    _RestaurantType=__RestaurantType;
    self.rtid=_RestaurantType.rid;
}
@end
