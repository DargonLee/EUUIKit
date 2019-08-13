//
//  UIImage+EUUI.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/22.
//  Copyright © 2019 Harlans. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CompletionBlock)( NSError *error);
typedef NS_ENUM(NSUInteger ,EUGradientType) {
    EUGradientTypeTopToBottom = 0,//从上到小
    EUGradientTypeLeftToRight = 1,//从左到右
    EUGradientTypeUpleftTolowRight = 2,//左上到右下
    EUGradientTypeUprightTolowLeft = 3,//右上到左下
};


@interface UIImage (EUUI)

/**
 根据颜色生成一张图片

 @param color 图片颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 根据颜色生成一张图片

 @param color 图片颜色
 @param size 图片大小
 @param roundSize 圆角大小
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size andRoundSize:(CGFloat)roundSize;

/**
 根据颜色生成一张圆角图片

 @param color 颜色
 @param cornerRadius 圆角大小
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

/**
 *  压缩上传图片到指定字节
 *
 *  @param image     压缩的图片
 *  @param maxLength 压缩后最大字节大小
 *
 *  @return 压缩后图片的二进制
 */
+ (NSData *)compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength maxWidth:(NSInteger)maxWidth;

/**
 *  获得指定size的图片
 *
 *  @param image   原始图片
 *  @param newSize 指定的size
 *
 *  @return 调整后的图片
 */
+ (UIImage *)resizeImage:(UIImage *) image withNewSize:(CGSize) newSize;

/**
 *  通过指定图片最长边，获得等比例的图片size
 *
 *  @param image       原始图片
 *  @param imageLength 图片允许的最长宽度（高度）
 *
 *  @return 获得等比例的size
 */
+ (CGSize)scaleImage:(UIImage *) image withLength:(CGFloat) imageLength;


/**
 对指定图片进行拉伸

 @param name 图片名字
 @return 拉伸后的图片
 */
+ (UIImage*)resizableImage:(NSString *)name;

/**
 生成一张渐变颜色的图片

 @param size 大小
 @param colors 颜色数组
 @param gradientType 颜色排布类型
 @return 图片
 */
+(UIImage*)imageWithFrame:(CGSize)size Colors:(NSArray*)colors GradientType:(EUGradientType)gradientType;

/**
 *  保存图片到相册
 */
-(void)imageWriteToSavedPhotosAlbum:(UIImage *)image result:(CompletionBlock) completionBlock;

+ (UIImage *)maskRoundCornerRadiusImageWithColor:(UIColor *)color
                                    cornerRadius:(CGSize)cornerRadius
                                            size:(CGSize)size
                                         corners:(UIRectCorner)corners
                                     borderColor:(UIColor *)borderColor
                                     borderWidth:(CGFloat)borderWidth;

@end

NS_ASSUME_NONNULL_END
