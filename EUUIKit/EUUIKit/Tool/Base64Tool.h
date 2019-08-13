//
//  Base64Tool.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/22.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Base64Tool : NSObject

/**
 Base64加密

 @param string 要加密的字符串
 @return 加密后的字符串
 */
- (NSString *)base64EncodedWithString:(NSString *)string;

/**
 Base64解密

 @param base64String 要解密的字符串
 @return 解密后的字符串
 */
- (NSString *)base64DecodedWithString:(NSString *)base64String;

@end

NS_ASSUME_NONNULL_END
