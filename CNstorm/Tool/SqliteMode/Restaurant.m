//
//  Restaurant.h
//
//  Created by 徐彪
//

#import "Restaurant.h"

@implementation Restaurant
@synthesize rid;
@synthesize _Site;
@synthesize RestaurantTypeDetails;
@synthesize price;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"rid",[NSNumber numberWithBool:false],@"price",nil];
    }
    return self;
}
-(void)setRid:(NSInteger)_rid{
    rid=_rid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"rid"];
}
-(void)set_Site:(Site*)__Site{
    _Site=__Site;
    self.rid=_Site.sid;
}
-(void)setPrice:(double)_price{
    price=_price;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"price"];
}
@end
