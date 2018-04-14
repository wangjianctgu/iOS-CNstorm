//
//  ViewSpotTypeDetail.h
//
//  Created by 徐彪
//

#import "ViewSpotTypeDetail.h"

@implementation ViewSpotTypeDetail
@synthesize vtdid;
@synthesize _ViewSpotType;
@synthesize vid;
@synthesize _ViewSpot;
@synthesize vtid;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"vtdid",[NSNumber numberWithBool:false],@"vid",[NSNumber numberWithBool:false],@"vtid",nil];
    }
    return self;
}
-(void)setVtdid:(NSInteger)_vtdid{
    vtdid=_vtdid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"vtdid"];
}
-(void)set_ViewSpotType:(ViewSpotType*)__ViewSpotType{
    _ViewSpotType=__ViewSpotType;
    self.vtdid=_ViewSpotType.vid;
}
-(void)setVid:(NSInteger)_vid{
    vid=_vid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"vid"];
}
-(void)set_ViewSpot:(ViewSpot*)__ViewSpot{
    _ViewSpot=__ViewSpot;
    self.vid=_ViewSpot.vid;
}
-(void)setVtid:(NSInteger)_vtid{
    vtid=_vtid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"vtid"];
}
@end
