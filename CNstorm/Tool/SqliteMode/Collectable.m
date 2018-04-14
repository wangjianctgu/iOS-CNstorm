//
//  Collectable.h
//
//  Created by 徐彪
//

#import "Collectable.h"

@implementation Collectable
@synthesize cid;
@synthesize Sites;
@synthesize Trips;
@synthesize Citys;
@synthesize Newss;
@synthesize NewsRelevants;
@synthesize Pics;
@synthesize title;
@synthesize type;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"cid",[NSNumber numberWithBool:false],@"title",[NSNumber numberWithBool:false],@"type",nil];
    }
    return self;
}
-(void)setCid:(NSInteger)_cid{
    cid=_cid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"cid"];
}
-(void)setTitle:(NSString*)_title{
    title=_title;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"title"];
}
-(void)setType:(NSInteger)_type{
    type=_type;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"type"];
}
@end
