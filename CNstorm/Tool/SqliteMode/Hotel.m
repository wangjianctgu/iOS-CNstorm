//
//  Hotel.h
//
//  Created by 徐彪
//

#import "Hotel.h"

@implementation Hotel
@synthesize hid;
@synthesize _Site;
@synthesize starlevel;
@synthesize minprice;
@synthesize maxprice;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"hid",[NSNumber numberWithBool:false],@"starlevel",[NSNumber numberWithBool:false],@"minprice",[NSNumber numberWithBool:false],@"maxprice",nil];
    }
    return self;
}
-(void)setHid:(NSInteger)_hid{
    hid=_hid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"hid"];
}
-(void)set_Site:(Site*)__Site{
    _Site=__Site;
    self.hid=_Site.sid;
}
-(void)setStarlevel:(NSInteger)_starlevel{
    starlevel=_starlevel;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"starlevel"];
}
-(void)setMinprice:(double)_minprice{
    minprice=_minprice;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"minprice"];
}
-(void)setMaxprice:(double)_maxprice{
    maxprice=_maxprice;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"maxprice"];
}
@end
