//
//  Customer.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-29.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "Customer.h"

@implementation Customer

- (id)init
{
	if((self = [super init])){
        
        self.customerid = 0;
        self.image = @"";
        self.email = @"";
        self.username = @"";
        self.tname = @"";
        self.password = @"";
        self.scores = 0;
        self.money = 0.00f;
        self.verification = @"0";
        
        propertiesChanged=[[NSMutableDictionary alloc]initWithObjectsAndKeys:
                           [NSNumber numberWithBool:false],@"customerid",
                           [NSNumber numberWithBool:false],@"image",
                           [NSNumber numberWithBool:false],@"email",
                           [NSNumber numberWithBool:false],@"username",
                           [NSNumber numberWithBool:false],@"tname",
                           [NSNumber numberWithBool:false],@"password",
                           [NSNumber numberWithBool:false],@"scores",
                           [NSNumber numberWithBool:false],@"money",[NSNumber numberWithBool:false],@"verification",nil];
	}
	return self;
}

-(void)setCustomerid:(long long)customerid{
    _customerid = customerid;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"customerid"];
}

-(void)setImage:(NSString *)image{
    _image = image;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"image"];
}

-(void)setEmail:(NSString *)email{
    _email = email;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"email"];
}

-(void)setUsername:(NSString *)username{
    _username = username;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"username"];
}

-(void)setTname:(NSString *)tname{
    _tname = tname;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"nickname"];
}

-(void)setPassword:(NSString *)password{
    _password = password;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"password"];
}

-(void)setScores:(long long)scores{
    _scores = scores;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"scores"];
}

-(void)setMoney:(double)money{
    _money = money;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"money"];
}

-(void)setVerification:(NSString *)verification
{
    _verification = verification;
    [propertiesChanged setObject:[NSNumber numberWithBool:true] forKey:@"verification"];
}

- (id)initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.customerid = [coder decodeInt64ForKey:@"customerid"];
        self.image = [coder decodeObjectForKey:@"image"];
        self.email = [coder decodeObjectForKey:@"email"];
        self.username = [coder decodeObjectForKey:@"username"];
        self.tname = [coder decodeObjectForKey:@"tname"];
        self.password = [coder decodeObjectForKey:@"password"];
        self.scores = [coder decodeInt64ForKey:@"scores"];
        self.money = [coder decodeDoubleForKey:@"money"];
        self.verification = [coder decodeObjectForKey:@"verification"];
    }
    return self;
}

- (void)encodeWithCoder: (NSCoder *)coder
{
    [coder encodeInt64:self.customerid forKey:@"customerid"];
    [coder encodeObject:self.email forKey:@"email"];
    [coder encodeObject:self.image forKey:@"image"];
    [coder encodeObject:self.username forKey:@"username"];
    [coder encodeObject:self.tname forKey:@"tname"];
    [coder encodeObject:self.password forKey:@"password"];
    [coder encodeInt64:self.scores forKey:@"scores"];
    [coder encodeDouble:self.money forKey:@"money"];
    [coder encodeObject:self.verification forKey:@"verification"];
}

@end
