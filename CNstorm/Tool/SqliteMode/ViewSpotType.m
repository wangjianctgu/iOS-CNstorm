//
//  ViewSpotType.h
//
//  Created by 徐彪
//

#import "ViewSpotType.h"

#define DATEFORMATTER @"yyyy/MM/dd HH:mm:ss"

@implementation ViewSpotType
@synthesize vid;
@synthesize ViewSpotTypeDetails;
@synthesize name;
@synthesize createdate;
@synthesize updatedate;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"vid",[NSNumber numberWithBool:false],@"name",[NSNumber numberWithBool:false],@"createdate",[NSNumber numberWithBool:false],@"updatedate",nil];
    }
    return self;
}
-(void)setVid:(NSInteger)_vid{
    vid=_vid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"vid"];
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
