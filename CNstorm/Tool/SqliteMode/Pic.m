//
//  Pic.h
//
//  Created by 徐彪
//

#import "Pic.h"

@implementation Pic
@synthesize pid;
@synthesize cid;
@synthesize _Collectable;
@synthesize detail;
@synthesize path;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"pid",[NSNumber numberWithBool:false],@"cid",[NSNumber numberWithBool:false],@"detail",[NSNumber numberWithBool:false],@"path",nil];
    }
    return self;
}
-(void)setPid:(NSInteger)_pid{
    pid=_pid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"pid"];
}
-(void)setCid:(NSInteger)_cid{
    cid=_cid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"cid"];
}
-(void)set_Collectable:(Collectable*)__Collectable{
    _Collectable=__Collectable;
    self.cid=_Collectable.cid;
}
-(void)setDetail:(NSString*)_detail{
    detail=_detail;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"detail"];
}
-(void)setPath:(NSString*)_path{
    path=_path;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"path"];
}
@end
