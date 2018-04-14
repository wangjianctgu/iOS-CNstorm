//
//  XubModel.h
//  travelApp
//
//  Created by 徐彪 on 13-8-25.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColunmInfo.h"
@interface XubModel : NSObject
{
    NSMutableDictionary* propertiesChanged;
}

@property (nonatomic,readonly,retain) NSMutableDictionary *propertiesChanged;

-(id)copy;

@end
