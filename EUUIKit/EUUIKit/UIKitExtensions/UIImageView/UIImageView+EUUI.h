//
//  UIImageView+EUUI.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/22.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (EUUI)

/**
 快速创建一个 动画imageView

 @param imageArray 图片数组
 @param duration 动画时长
 @return UIImageView对象
 */
+ (instancetype)imageViewWithImageArray:(NSArray <UIImage *>*)imageArray duration:(NSTimeInterval)duration;

/**
 给图片画圆角

 @param radius 圆角半径
 */
- (void)maskCornerRadius:(CGFloat)radius;

/**
 画水印

 @param image 原图片
 @param mark 水印图片
 @param rect 水印图片位置
 */
- (UIImage *)drawOrignImage:(UIImage *)image waterMark:(UIImage *)mark inRect:(CGRect)rect;

/**
 给当前图片画水印图片 需要先设置UIImageView 的 Image

 @param waterMark 水印图片
 @param rect 水印图片位置
 */
- (void)drawWaterMark:(UIImage *)waterMark inRect:(CGRect)rect;

/**
 给当前图片添加文字水印

 @param string 文字文本
 @param point 起始点
 */
- (void)drawOrignImageWithString:(NSString *)string atPoint:(CGPoint)point;

/**
 给当前图片添加文字水印

 @param image 要添加水印的图片
 @param string 水印文本
 @param point 起始点
 @param color 文本颜色
 @param font 文本大小
 @return 加好水印的图片
 */
- (UIImage *)drawOrignImage:(UIImage *)image waterMaskString:(NSString *)string atPoint:(CGPoint)point textColor:(UIColor *)color textFont:(UIFont *)font;

/**
 给当前图片添加文字水印

 @param image 要添加水印的图片
 @param string 水印文本
 @param point 起始点
 @param attributed 文本相关属性
 @return 加好水印的图片
 */
- (UIImage *)drawOrignImage:(UIImage *)image waterMaskString:(NSString *)string atPoint:(CGPoint)point attributedString:(nullable NSDictionary<NSString *,id> *)attributed;

@end

NS_ASSUME_NONNULL_END
