//
//  RestaurantType.h
//
//  Created by 徐彪
//

#import "RestaurantType.h"

#define DATEFORMATTER @"yyyy/MM/dd HH:mm:ss"

@implementation RestaurantType
@synthesize rid;
@synthesize RestaurantTypeDetails;
@synthesize name;
@synthesize createdate;
@synthesize updatedate;

-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"rid",[NSNumber numberWithBool:false],@"name",[NSNumber numberWithBool:false],@"createdate",[NSNumber numberWithBool:false],@"updatedate",nil];
    }
    return self;
}
-(void)setRid:(NSInteger)_rid{
    rid=_rid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"rid"];
}
-(void)setName:(NSString*)_name{
    name=_name;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"name"];
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
