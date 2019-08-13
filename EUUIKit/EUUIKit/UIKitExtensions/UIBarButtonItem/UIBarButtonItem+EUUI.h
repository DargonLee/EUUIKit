//
//  UIBarButtonItem+EUUI.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/23.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (EUUI)

/**
 快速创建一个BarItem

 @param image 图片名字
 @param target target
 @param action action
 @return UIBarButtonItem
 */
+ (instancetype)itemWithImage:(NSString *)image target:(id)target action:(SEL)action;

/**
 快速创建一个BarItem

 @param image Normal 图片
 @param highImage Hight 图片
 @param target target
 @param action action
 @return UIBarButtonItem
 */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

/**
 快速创建一个BarItem

 @param text 文本
 @param color 文本颜色
 @param font 文字大小
 @param target target
 @param action action
 @return UIBarButtonItem
 */
+ (instancetype)itemWithText:(NSString *)text textColor:(UIColor *)color font:(CGFloat)font target:(id)target action:(SEL)action;

/**
 快速创建一个BarItem

 @param text 文本
 @param target  target
 @param action action
 @return UIBarButtonItem
 */
+ (instancetype)itemWithText:(NSString *)text target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
