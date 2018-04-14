//
//  NewsRelevant.h
//
//  Created by 徐彪
//

#import "NewsRelevant.h"

@implementation NewsRelevant
@synthesize nrid;
@synthesize nid;
@synthesize _News;
@synthesize cid;
@synthesize _Collectable;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"nrid",[NSNumber numberWithBool:false],@"nid",[NSNumber numberWithBool:false],@"cid",nil];
    }
    return self;
}
-(void)setNrid:(NSInteger)_nrid{
    nrid=_nrid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"nrid"];
}
-(void)setNid:(NSInteger)_nid{
    nid=_nid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"nid"];
}
-(void)set_News:(News*)__News{
    _News=__News;
    self.nid=_News.nid;
}
-(void)setCid:(NSInteger)_cid{
    cid=_cid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"cid"];
}
-(void)set_Collectable:(Collectable*)__Collectable{
    _Collectable=__Collectable;
    self.cid=_Collectable.cid;
}
@end
