//
//  CategoryUpdate.h
//
//  Created by 徐彪
//

#import "CategoryUpdate.h"

#define DATEFORMATTER @"yyyy/MM/dd HH:mm:ss"

@implementation CategoryUpdate
@synthesize tablename;
@synthesize updatetime;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"tablename",[NSNumber numberWithBool:false],@"updatetime",nil];
    }
    return self;
}
-(void)setTablename:(NSString*)_tablename{
    tablename=_tablename;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"tablename"];
}
-(void)setUpdatetime:(NSDate*)_updatetime{
    if([_updatetime isKindOfClass: [NSString class]])
    {
         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
         [dateFormatter setDateFormat: DATEFORMATTER];
        _updatetime= [dateFormatter dateFromString:(NSString*)_updatetime];
    }
    updatetime=_updatetime;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"updatetime"];
}
@end
