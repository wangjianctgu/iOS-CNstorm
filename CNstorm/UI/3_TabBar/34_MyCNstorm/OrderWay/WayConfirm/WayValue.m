//
//  WayValue.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-8-19.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "WayValue.h"

@implementation WayValue

- (id) init
{
	if((self = [super init]))
    {
        self.addressId = 0;
        
        self.dabao = 0;
        self.dingdan = 0;
        self.cailiao = 0;
        self.zengzhi = 0;
        
        self.orderIds = [NSString stringWithFormat:@""];
        self.deliveryId = 0;
        self.deliveryname = [NSString stringWithFormat:@""];
        self.freight = 0.00f;
        self.totalFreight = 0.00f;
        self.allWeight = 0.00f;
        self.serverfee = 0.00f;
        self.customsFee = 0.00f;
        
        self.zengzhiValue = 0.00f;
        self.cailiaoValue = 0.00f;
        self.dingdanValue = 0.00f;
        self.dabaoValue = 0.00f;
	}
	return self;
}

@end
