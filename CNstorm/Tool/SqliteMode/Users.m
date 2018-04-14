//
//  Users.h
//
//  Created by 徐彪
//

#import "Users.h"

@implementation Users
@synthesize uid;
@synthesize _TripOwner;
@synthesize name;
@synthesize password;
@synthesize male;
@synthesize city;
@synthesize head;
@synthesize qq;
@synthesize email;
@synthesize secrecy;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"uid",[NSNumber numberWithBool:false],@"name",[NSNumber numberWithBool:false],@"password",[NSNumber numberWithBool:false],@"male",[NSNumber numberWithBool:false],@"city",[NSNumber numberWithBool:false],@"head",[NSNumber numberWithBool:false],@"qq",[NSNumber numberWithBool:false],@"email",[NSNumber numberWithBool:false],@"secrecy",nil];
    }
    return self;
}
-(void)setUid:(NSInteger)_uid{
    uid=_uid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"uid"];
}
-(void)set_TripOwner:(TripOwner*)__TripOwner{
    _TripOwner=__TripOwner;
    self.uid=_TripOwner.oid;
}
-(void)setName:(NSString*)_name{
    name=_name;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"name"];
}
-(void)setPassword:(NSString*)_password{
    password=_password;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"password"];
}
-(void)setMale:(BOOL)_male{
    male=_male;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"male"];
}
-(void)setCity:(NSString*)_city{
    city=_city;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"city"];
}
-(void)setHead:(NSString*)_head{
    head=_head;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"head"];
}
-(void)setQq:(NSString*)_qq{
    qq=_qq;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"qq"];
}
-(void)setEmail:(NSString*)_email{
    email=_email;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"email"];
}
-(void)setSecrecy:(BOOL)_secrecy{
    secrecy=_secrecy;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"secrecy"];
}
@end
