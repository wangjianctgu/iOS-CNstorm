//
//  ViewSpotEquipment.h
//
//  Created by 徐彪
//

#import "ViewSpotEquipment.h"

@implementation ViewSpotEquipment
@synthesize veid;
@synthesize vid;
@synthesize _ViewSpot;
@synthesize etid;
@synthesize _EquipmentType;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"veid",[NSNumber numberWithBool:false],@"vid",[NSNumber numberWithBool:false],@"etid",nil];
    }
    return self;
}
-(void)setVeid:(NSInteger)_veid{
    veid=_veid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"veid"];
}
-(void)setVid:(NSInteger)_vid{
    vid=_vid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"vid"];
}
-(void)set_ViewSpot:(ViewSpot*)__ViewSpot{
    _ViewSpot=__ViewSpot;
    self.vid=_ViewSpot.vid;
}
-(void)setEtid:(NSInteger)_etid{
    etid=_etid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"etid"];
}
-(void)set_EquipmentType:(EquipmentType*)__EquipmentType{
    _EquipmentType=__EquipmentType;
    self.etid=_EquipmentType.eid;
}
@end
