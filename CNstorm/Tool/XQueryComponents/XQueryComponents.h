//
//  XQueryComponents.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-15.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XQueryComponents)

- (NSString *)stringByDecodingURLFormat;

- (NSString *)stringByEncodingURLFormat;

- (NSMutableDictionary *)dictionaryFromQueryComponents;

@end

@interface NSURL (XQueryComponents)

- (NSMutableDictionary *)queryComponents;

@end

@interface NSDictionary (XQueryComponents)

- (NSString *)stringFromQueryComponents;

@end
