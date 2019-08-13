//
//  UIViewController+EUUI.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/17.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (EUUI)

/**
 隐藏Hud
 */
- (void)hideHud;

/**
 显示一个带有文字的Hud 在屏幕中间

 @param hint 提示内容
 */
- (void)showHint:(NSString *)hint;

/**
 显示一个带有文字的Hud 在屏幕底部
 
 @param hint 提示内容
 */
- (void)showHintBottom:(NSString *)hint;

/**
 显示一个带有文字的 Loading

 @param hint 提示内容
 */
- (void)showLoadingWithText:(NSString *)hint;

/**
 显示一个自定义的view

 @param view 要自定义的view
 */
- (void)showHudWithCustomView:(UIView *)view;

/**
 显示一个带图片和文字的

 @param imageName 图片名字
 @param hint 提示文本内容
 */
- (void)showHudWithImageName:(NSString *)imageName hint:(NSString *)hint;

/**
 显示一个加载进度的loading

 @param progress 进度值
 @param hint 提示文字
 */
- (void)showDeterminateWithProgress:(float)progress hint:(NSString *)hint;


/**
 显示一个带动画的加载 Loading

 @param imageName 图片的名字
 */
- (void)showAnimationLoadingViewWithImageName:(NSString *)imageName hint:(NSString *)hint;

@end


@interface UIViewController (Empty)

/**
 显示菊花加载view
 */
- (void)showEmptyViewWithLoading;

/**
 显示空页面view

 @param text 主标题
 @param detailText 副标题
 */
- (void)showEmptyViewWithText:(NSString *)text detailText:(NSString *)detailText;

/**
 显示空页面view

 @param image 图片
 @param text 主标题
 @param detailText 副标题
 */
- (void)showEmptyViewWithImage:(UIImage *_Nullable)image text:(NSString *)text detailText:(NSString *)detailText;

/**
 显示空页面view

 @param text 主标题
 @param detailText 副标题
 @param title 按钮的文本
 @param action 按钮的点击事件
 */
- (void)showEmptyViewWithText:(NSString *)text detailText:(NSString *)detailText buttonTitle:(NSString *_Nullable)title buttonAction:(void(^__nullable)(UIButton *clickButton))action;

/**
 显示空页面view

 @param image 图片
 @param text 主标题
 @param detailText 副标题
 @param title 按钮的文本
 @param action 按钮的点击事件
 */
- (void)showEmptyViewWithImage:(UIImage *_Nullable)image text:(NSString *)text detailText:(NSString *)detailText buttonTitle:(NSString *_Nullable)title buttonAction:(void(^__nullable)(UIButton *clickButton))action;


/**
 隐藏空页面
 */
- (void)hideEmptyView;

@end

NS_ASSUME_NONNULL_END
