//
//  AESTool.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/20.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "AESTool.h"
#import "encrypt.h"

static NSString *EncryptSymbol = @"EUUIKit";

@implementation AESTool

+ (NSData *)aesEncryptWithDictionary:(NSDictionary *)dictionary
{
    @autoreleasepool {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
        //加密
        unsigned  long dest_len;
        char *acckey = (char *)[EncryptSymbol cStringUsingEncoding:NSASCIIStringEncoding];
        void * dest = (char *)xencrypt(data.bytes, (int)data.length, acckey, &dest_len);
        NSData *data1 = [[NSData alloc]initWithBytes:dest length:dest_len];
        free(dest);
        return data1;
    }
}

+ (NSDictionary *)aesDecryptWithDictionary:(NSData *)data
{
    @autoreleasepool {
        char *acckey = (char *)[EncryptSymbol cStringUsingEncoding:NSASCIIStringEncoding];
        unsigned long decrypted_len;
        void * decrpyted = (char *)decrypt(data.bytes, (int)data.length, acckey, &decrypted_len);
        NSData *data2 = [[NSData alloc]initWithBytes:decrpyted length:decrypted_len];
        free(decrpyted);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:nil];
        return dict;
    }
}

+ (NSData *)aesEncryptWithString:(NSString *)string
{
    @autoreleasepool {
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        //加密
        unsigned  long dest_len;
        char *acckey = (char *)[EncryptSymbol cStringUsingEncoding:NSASCIIStringEncoding];
        void * dest = (char *)xencrypt(data.bytes, (int)data.length, acckey, &dest_len);
        NSData *data1 = [[NSData alloc]initWithBytes:dest length:dest_len];
        free(dest);
        return data1;
    }
}

+ (NSString *)aesDecryptWithString:(NSData *)data
{
    @autoreleasepool {
        char *acckey = (char *)[EncryptSymbol cStringUsingEncoding:NSASCIIStringEncoding];
        unsigned long decrypted_len;
        void * decrpyted = (char *)decrypt(data.bytes, (int)data.length, acckey, &decrypted_len);
        NSData *data2 = [[NSData alloc]initWithBytes:decrpyted length:decrypted_len];
        free(decrpyted);
        NSString *string = [[NSString alloc]initWithData:data2 encoding:NSUTF8StringEncoding];
        return string;
    }
}

+ (NSData *)aesEncryptWithArray:(NSArray *)array
{
    @autoreleasepool {
        NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
        //加密
        unsigned  long dest_len;
        char *acckey = (char *)[EncryptSymbol cStringUsingEncoding:NSASCIIStringEncoding];
        void * dest = (char *)xencrypt(data.bytes, (int)data.length, acckey, &dest_len);
        NSData *data1 = [[NSData alloc]initWithBytes:dest length:dest_len];
        free(dest);
        return data1;
    }
}

+ (NSArray *)aesDecryptWithArray:(NSData *)data
{
    @autoreleasepool {
        char *acckey = (char *)[EncryptSymbol cStringUsingEncoding:NSASCIIStringEncoding];
        unsigned long decrypted_len;
        void * decrpyted = (char *)decrypt(data.bytes, (int)data.length, acckey, &decrypted_len);
        NSData *data2 = [[NSData alloc]initWithBytes:decrpyted length:decrypted_len];
        free(decrpyted);
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:nil];
        return array;
    }
}

@end
