//
//  SiteProject.h
//
//  Created by 徐彪
//

#import "SiteProject.h"

@implementation SiteProject
@synthesize spid;
@synthesize sid;
@synthesize _Site;
@synthesize name;
@synthesize price;
@synthesize picpath;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"spid",[NSNumber numberWithBool:false],@"sid",[NSNumber numberWithBool:false],@"name",[NSNumber numberWithBool:false],@"price",[NSNumber numberWithBool:false],@"picpath",nil];
    }
    return self;
}
-(void)setSpid:(NSInteger)_spid{
    spid=_spid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"spid"];
}
-(void)setSid:(NSInteger)_sid{
    sid=_sid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"sid"];
}
-(void)set_Site:(Site*)__Site{
    _Site=__Site;
    self.sid=_Site.sid;
}
-(void)setName:(NSString*)_name{
    name=_name;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"name"];
}
-(void)setPrice:(double)_price{
    price=_price;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"price"];
}
-(void)setPicpath:(NSString*)_picpath{
    picpath=_picpath;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"picpath"];
}
@end
