//
//  QRCodeTool.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/28.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRCodeTool : NSObject


/**
 根据字符串生成二维码

 @param string 字符串
 @return 二维码图片
 */
+ (UIImage *)generatorQRCodeWithString:(NSString *)string;

/**
 生成自定义二维码
 
 @param string 二维码信息
 @param r r
 @param g g
 @param b b
 @param alpha alpha
 @return 二维码图片
 */
+ (UIImage *)generatorQRCodeWithString:(NSString *)string r:(NSUInteger)r g:(NSUInteger)g b:(NSUInteger)b alpha:(CGFloat)alpha;

/**
 生成自定义二维码

 @param string 二维码信息
 @param image 中间的图片
 @return 二维码图片
 */
+ (UIImage *)generatorQRCodeWithString:(NSString *)string centerImage:(UIImage *)image;

/**
 生成自定义二维码

 @param string 二维码信息
 @param image 中间的图片
 @param r r description
 @param g g description
 @param b b description
 @param alpha alpha description
 @return 二维码图片
 */
+ (UIImage *)generatorQRCodeWithString:(NSString *)string centerImage:(UIImage *)image r:(NSUInteger)r g:(NSUInteger)g b:(NSUInteger)b alpha:(CGFloat)alpha;


/**
 识别一张图中多个二维码

 @param sourceImage 二维码图片
 @return 多个二维码信息
 */
+ (NSArray <NSString *>*)detectorQRCodeWithQRCodeImage:(UIImage *)sourceImage;

/**
 识别单个二维码

 @param sourceImage 二维码图
 @return 二维码信息
 */
+ (NSString *)detectorQRCodeWithSingleQRCodeImage:(UIImage *)sourceImage;

@end

NS_ASSUME_NONNULL_END
