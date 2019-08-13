//
//  NSMutableParagraphStyle+EUUI.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/13.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableParagraphStyle (EUUI)

/**
 快速创建一个 NSMutableParagraphStyle

 @param lineHeight 行高
 @return 一个NSMutableParagraphStyle对象
 */
+ (instancetype)paragraphStyleWithLineHeight:(CGFloat)lineHeight;


/**
 快速创建一个 NSMutableParagraphStyle

 @param Spaceing 行间距
 @return 一个NSMutableParagraphStyle对象
 */
+ (instancetype)paragraphStyleWithLineSpaceing:(CGFloat)Spaceing;


/**
 快速创建一个 NSMutableParagraphStyle

 @param paragraphSpacing 段落间距
 @return 一个NSMutableParagraphStyle对象
 */
+ (instancetype)paragraphStyleWithParagraphSpacing:(CGFloat)paragraphSpacing;


/**
 快速创建一个 NSMutableParagraphStyle

 @param lineHeight 行高
 @param lineBreakMode 换行模式
 @param textAlign 文本对齐模式
 @return 一个NSMutableParagraphStyle对象
 */
+ (instancetype)paragraphStyleWithLineHeight:(CGFloat)lineHeight lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment)textAlign;


/**
 快速创建一个 NSMutableParagraphStyle

 @param lineSpaceing 行间距
 @param paragraphSpacing 段落间距
 @return 一个NSMutableParagraphStyle对象
 */
+ (instancetype)paragraphStyleWithLineSpaceing:(CGFloat)lineSpaceing paragraphSpacing:(CGFloat)paragraphSpacing;

@end

NS_ASSUME_NONNULL_END
