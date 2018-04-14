//
//  MD5.m
//  Pods
//
//  Created by Zhang Lisheng on 14-4-18.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "MD5.h"

#import <CommonCrypto/CommonDigest.h>

@implementation MD5

//32位MD5加密方式
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString
{
    const char *cStr = [srcString UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}

+ (NSString *)getMd5_16Bit_String:(NSString *)srcString
{
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self getMd5_32Bit_String:srcString];
    
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return result;
}

//[32位md5二次加密]
//[resultLabel1 setText:[self getMd5_32Bit_String:[self getMd5_32Bit_String:srcStringTextField.text]]];

//16位md5二次加密]
//[resultLabel1 setText:[self getMd5_16Bit_String:[self getMd5_16Bit_String:srcStringTextField.text]]];

//[关于大小写]
//NSString *result = [self getMd5_32Bit_String:srcStringTextField.text] uppercaseString];

//二次转换大写要特别注意，第一次转换的结果要先转成大写，然后执行常规转换，然后再将结果转成大写，类似于这样:
//[resultLabel2 setText:[[self getMd5_32Bit_String:[[self getMd5_32Bit_String:srcStringTextField.text] uppercaseString]]uppercaseString]];


@end
