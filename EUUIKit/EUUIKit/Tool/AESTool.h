//
//  AESTool.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/20.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AESTool : NSObject


/**
 对字典进行AES加密

 @param dictionary 要加密的字典
 @return 加密后的二进制数据
 */
+ (NSData *)aesEncryptWithDictionary:(NSDictionary *)dictionary;

/**
 对字典进行AES解密
 
 @param data 要解密的二进制数据
 @return 解密后的字典
 */
+ (NSDictionary *)aesDecryptWithDictionary:(NSData *)data;

/**
 对字符串进行加密
 
 @param string 要加密的字符串
 @return 加密后的二进制数据
 */
+ (NSData *)aesEncryptWithString:(NSString *)string;

/**
 对字符串进行解密
 
 @param data 要解密的二进制数据
 @return 解密后的字符串
 */
+ (NSString *)aesDecryptWithString:(NSData *)data;

/**
 对数组加密
 
 @param array 要加密的数组
 @return 加密后的二进制数据
 */
+ (NSData *)aesEncryptWithArray:(NSArray *)array;

/**
 对数组解密
 
 @param data 要解密的二进制数据
 @return 解密后的数组
 */
+ (NSArray *)aesDecryptWithArray:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
