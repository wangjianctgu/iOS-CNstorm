//
//  BadgeKeyValue.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-9-30.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "BadgeKeyValue.h"

@implementation BadgeKeyValue

- (id)init
{
	if((self = [super init]))
    {
        self.tabBadge4 = 0;
        self.myStorageBadge = 0;
        self.awaitReceiveBadge = 0;
        self.allWayBadge = 0;
        self.messageBadge = 0;
        
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:
                           [NSNumber numberWithBool:false],@"tabBadge4",
                           [NSNumber numberWithBool:false],@"myStorageBadge",
                           [NSNumber numberWithBool:false],@"awaitReceiveBadge",
                           [NSNumber numberWithBool:false],@"allWayBadge",
                           [NSNumber numberWithBool:false],@"messageBadge",nil];
	}
	return self;
}

-(void)setTabBadge4:(int)tabBadge4
{
    _tabBadge4 = tabBadge4;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"tabBadge4"];
}

-(void)setMyStorageBadge:(int)myStorageBadge
{
    _myStorageBadge = myStorageBadge;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"myStorageBadge"];
}

-(void)setAwaitReceiveBadge:(int)awaitReceiveBadge
{
    _awaitReceiveBadge = awaitReceiveBadge;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"awaitReceiveBadge"];
}

-(void)setAllWayBadge:(int)allWayBadge
{
    _allWayBadge = allWayBadge;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"allWayBadge"];
}

-(void)setMessageBadge:(int)messageBadge
{
    _messageBadge = messageBadge;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"messageBadge"];
}

- (id)initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.tabBadge4 = [coder decodeIntForKey:@"tabBadge4"];
        self.myStorageBadge = [coder decodeIntForKey:@"myStorageBadge"];
        self.awaitReceiveBadge = [coder decodeIntForKey:@"awaitReceiveBadge"];
        self.allWayBadge = [coder decodeIntForKey:@"allWayBadge"];
        self.messageBadge = [coder decodeIntForKey:@"messageBadge"];
    }
    return self;
}

- (void)encodeWithCoder: (NSCoder *)coder
{
    [coder encodeInt:self.tabBadge4 forKey:@"tabBadge4"];
    [coder encodeInt:self.myStorageBadge forKey:@"myStorageBadge"];
    [coder encodeInt:self.awaitReceiveBadge forKey:@"awaitReceiveBadge"];
    [coder encodeInt:self.allWayBadge forKey:@"allWayBadge"];
    [coder encodeInt:self.messageBadge forKey:@"messageBadge"];
}

@end
