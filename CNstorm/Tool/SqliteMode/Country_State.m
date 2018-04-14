//
//  Country_State.h
//
//  Created by 徐彪
//

#import "Country_State.h"

#define DATEFORMATTER @"yyyy/MM/dd HH:mm:ss"

@implementation Country_State
@synthesize csid;
@synthesize Citys;
@synthesize name;
@synthesize continent;
@synthesize createdate;
@synthesize updatedate;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"csid",[NSNumber numberWithBool:false],@"name",[NSNumber numberWithBool:false],@"continent",[NSNumber numberWithBool:false],@"createdate",[NSNumber numberWithBool:false],@"updatedate",nil];
    }
    return self;
}
-(void)setCsid:(NSInteger)_csid{
    csid=_csid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"csid"];
}
-(void)setName:(NSString*)_name{
    name=_name;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"name"];
}
-(void)setContinent:(NSInteger)_continent{
    continent=_continent;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"continent"];
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
