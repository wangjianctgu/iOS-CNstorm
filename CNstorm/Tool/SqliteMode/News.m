//
//  News.h
//
//  Created by 徐彪
//

#import "News.h"

#define DATEFORMATTER @"yyyy/MM/dd HH:mm:ss"

@implementation News
@synthesize nid;
@synthesize _Collectable;
@synthesize NewsRelevants;
@synthesize cid;
@synthesize _City;
@synthesize contents;
@synthesize islocal;
@synthesize istop;
@synthesize toppic;
@synthesize createdate;
@synthesize exprirydate;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"nid",[NSNumber numberWithBool:false],@"cid",[NSNumber numberWithBool:false],@"contents",[NSNumber numberWithBool:false],@"islocal",[NSNumber numberWithBool:false],@"istop",[NSNumber numberWithBool:false],@"toppic",[NSNumber numberWithBool:false],@"createdate",[NSNumber numberWithBool:false],@"exprirydate",nil];
    }
    return self;
}
-(void)setNid:(NSInteger)_nid{
    nid=_nid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"nid"];
}
-(void)set_Collectable:(Collectable*)__Collectable{
    _Collectable=__Collectable;
    self.nid=_Collectable.cid;
}
-(void)setCid:(NSInteger)_cid{
    cid=_cid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"cid"];
}
-(void)set_City:(City*)__City{
    _City=__City;
    self.cid=_City.cid;
}
-(void)setContents:(NSString*)_contents{
    contents=_contents;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"contents"];
}
-(void)setIslocal:(BOOL)_islocal{
    islocal=_islocal;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"islocal"];
}
-(void)setIstop:(BOOL)_istop{
    istop=_istop;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"istop"];
}
-(void)setToppic:(NSString*)_toppic{
    toppic=_toppic;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"toppic"];
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
-(void)setExprirydate:(NSDate*)_exprirydate{
    if([_exprirydate isKindOfClass: [NSString class]])
    {
         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
         [dateFormatter setDateFormat: DATEFORMATTER];
        _exprirydate= [dateFormatter dateFromString:(NSString*)_exprirydate];
    }
    exprirydate=_exprirydate;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"exprirydate"];
}
@end
