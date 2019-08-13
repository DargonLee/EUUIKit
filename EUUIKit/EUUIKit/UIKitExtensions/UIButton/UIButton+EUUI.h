//
//  UIButton+EUUI.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/14.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, EUImagePosition) {
    EUImagePositionLeft = 0,              //图片在左，文字在右，默认
    EUImagePositionRight = 1,             //图片在右，文字在左
    EUImagePositionTop = 2,               //图片在上，文字在下
    EUImagePositionBottom = 3,            //图片在下，文字在上
};
@interface UIButton (EUUI)


/**
 *  @brief  设置按钮额外热区
 */
@property (nonatomic, assign) UIEdgeInsets touchAreaInsets;

/**
 快速创建一个button

 @param image 图片
 @param title t标题
 @return 一个button
 */
- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title;

/**
 获取button文本的rect 注意： 需要提前设置好button的宽度

 @return 文本的rect
 */
- (CGRect)buttonTextRect;

/**
 获取button文本的高度 注意： 需要提前设置好button的宽度

 @return 文本的高度
 */
- (CGFloat)buttonTextHeight;

/**
 button 自适应高度 注意： 需要提前设置好button的宽度
 */
- (void)sizeToFitButton;

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(EUImagePosition)postion spacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
