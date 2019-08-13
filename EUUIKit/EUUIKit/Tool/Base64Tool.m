//
//  Base64Tool.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/22.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "Base64Tool.h"

@implementation Base64Tool

- (NSString *)base64EncodedWithString:(NSString *)string
{
    if (![string length]) return nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]; // base64格式的字符串
}

- (NSString *)base64DecodedWithString:(NSString *)base64String;
{
    if (![base64String length]) return nil;
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *result =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

@end
