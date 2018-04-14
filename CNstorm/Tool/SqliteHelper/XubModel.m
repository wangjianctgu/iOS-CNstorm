//
//  XubModel.m
//  travelApp
//
//  Created by 徐彪 on 13-8-25.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import "XubModel.h"

#import <objc/runtime.h>

@implementation XubModel
@synthesize propertiesChanged;

- (id)copy
{
    unsigned int nCount = 0;
    
    XubModel *newmodel = [[[self class]alloc] init];
    
    //objc_objectptr_t *popertylist = class_copyPropertyList([self class],&nCount);//消除警告
    objc_property_t *popertylist = class_copyPropertyList([self class],&nCount);

    for (int i = 0; i < nCount; i++) {
        //objc_objectptr_t property = popertylist[i];//消除警告
        objc_property_t property = popertylist[i];
        NSString *propname=[NSString stringWithUTF8String:property_getName(property)];
        [newmodel setValue:[self valueForKey:propname] forKey:propname];
    }
    return newmodel;

}
@end
