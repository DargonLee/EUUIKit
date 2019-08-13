//
//  UINavigationBar+EUUI.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/23.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (EUUI)

/**
 设置导航栏背景颜色

 @param backgroundColor 颜色
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor;

/**
 设置导航栏元素的透明度

 @param alpha 透明度
 */
- (void)setElementsAlpha:(CGFloat)alpha;

/**
 设置y值

 @param translationY y
 */
- (void)setTranslationY:(CGFloat)translationY;

/**
 重置所有设置
 */
- (void)reset;

/**
 UINavigationBar 的背景 view，可能显示磨砂、背景图，顶部有一部分溢出到 UINavigationBar 外。
 
 在 iOS 10 及以后是私有的 _UIBarBackground 类。
 
 在 iOS 9 及以前是私有的 _UINavigationBarBackground 类。
 */
@property(nonatomic, strong, readonly) UIView *backgroundView;

/**
 qmui_backgroundView 内显示实际背景的 view，可能是磨砂或者背景图片。
 
 在 iOS 10 及以后，该 view 为 qmui_backgroundView 的 subview，当显示磨砂时是一个 UIVisualEffectView，当显示背景图时是一个 UIImageView。
 
 在 iOS 9 及以前，如果显示磨砂，该 view 为 qmui_backgroundView 的 subview，是一个 _UIBackdropView，如果显示背景图，则返回 qmui_backgroundView 自身，因为 _UINavigationBarBackground 本身就是一个 UIImageView。
 
 @warning 如果要以 view 的方式去修改 UINavigationBar 的背景，由于不同的 iOS 版本，qmui_shadowImageView 和 qmui_backgroundContentView 的层级关系不同，所以为了效果的统一，建议这种情况下操作 qmui_backgroundView 会好过于操作 qmui_backgroundContentView。
 */
@property(nonatomic, strong, readonly) __kindof UIView *backgroundContentView;

@end

NS_ASSUME_NONNULL_END
