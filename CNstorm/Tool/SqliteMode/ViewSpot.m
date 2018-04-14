//
//  ViewSpot.h
//
//  Created by 徐彪
//

#import "ViewSpot.h"

@implementation ViewSpot
@synthesize vid;
@synthesize _Site;
@synthesize ViewSpotEquipments;
@synthesize ViewSpotTypeDetails;
@synthesize price;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"vid",[NSNumber numberWithBool:false],@"price",nil];
    }
    return self;
}
-(void)setVid:(NSInteger)_vid{
    vid=_vid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"vid"];
}
-(void)set_Site:(Site*)__Site{
    _Site=__Site;
    self.vid=_Site.sid;
}
-(void)setPrice:(double)_price{
    price=_price;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"price"];
}
@end
