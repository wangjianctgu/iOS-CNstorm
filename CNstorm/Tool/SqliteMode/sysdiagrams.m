//
//  sysdiagrams.h
//
//  Created by 徐彪
//

#import "sysdiagrams.h"

@implementation sysdiagrams
@synthesize name;
@synthesize principal_id;
@synthesize diagram_id;
@synthesize version;
@synthesize definition;
-(id)init{
    if(self=[super init]){
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:false],@"name",[NSNumber numberWithBool:false],@"principal_id",[NSNumber numberWithBool:false],@"diagram_id",[NSNumber numberWithBool:false],@"version",[NSNumber numberWithBool:false],@"definition",nil];
    }
    return self;
}
-(void)setName:(NSString*)_name{
    name=_name;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"name"];
}
-(void)setPrincipal_id:(NSInteger)_principal_id{
    principal_id=_principal_id;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"principal_id"];
}
-(void)setDiagram_id:(NSInteger)_diagram_id{
    diagram_id=_diagram_id;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"diagram_id"];
}
-(void)setVersion:(NSInteger)_version{
    version=_version;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"version"];
}
-(void)setDefinition:(NSData*)_definition{
    definition=_definition;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"definition"];
}
@end
