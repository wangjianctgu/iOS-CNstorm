//
//  EquipmentType.h
//
//  Created by 徐彪
//

#import "EquipmentType.h"

#define DATEFORMATTER @"yyyy/MM/dd HH:mm:ss"

@implementation EquipmentType
@synthesize eid;
@synthesize EquipmentTypes;
@synthesize ViewSpotEquipments;
@synthesize name;
@synthesize fathereid;
@synthesize _EquipmentType;
@synthesize createdate;
@synthesize updatedate;
@synthesize cid;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"eid",[NSNumber numberWithBool:false],@"name",[NSNumber numberWithBool:false],@"fathereid",[NSNumber numberWithBool:false],@"createdate",[NSNumber numberWithBool:false],@"updatedate",[NSNumber numberWithBool:false],@"cid",nil];
    }
    return self;
}
-(void)setEid:(NSInteger)_eid{
    eid=_eid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"eid"];
}
-(void)setName:(NSString*)_name{
    name=_name;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"name"];
}
-(void)setFathereid:(NSInteger)_fathereid{
    fathereid=_fathereid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"fathereid"];
}
-(void)set_EquipmentType:(EquipmentType*)__EquipmentType{
    _EquipmentType=__EquipmentType;
    self.fathereid=_EquipmentType.eid;
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
-(void)setCid:(NSString*)_cid{
    cid=_cid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"cid"];
}
@end
