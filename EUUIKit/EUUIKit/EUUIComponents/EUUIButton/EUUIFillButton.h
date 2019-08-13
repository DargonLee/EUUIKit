//
//  EUUIFillButton.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/14.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUUIButton.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EUUIFillButtonColorType) {
    EUUIFillButtonColorTypeBlue,
    EUUIFillButtonColorTypeRed,
    EUUIFillButtonColorTypeGreen,
    EUUIFillButtonColorTypeGray,
    EUUIFillButtonColorTypeWhite,
};

@interface EUUIFillButton : EUUIButton

/**
 快速创建一个EUUIFillButton

 @param fillType 填充类型
 @return 一个EUUIFillButton
 */
- (instancetype)initWitFillType:(EUUIFillButtonColorType)fillType;


/**
 快速创建一个EUUIFillButton

 @param fillType fillType 填充类型
 @return 一个EUUIFillButton
 */
+ (instancetype)fillButtonType:(EUUIFillButtonColorType)fillType;


/**
 快速创建一个EUUIFillButton

 @param fillColor 填充颜色
 @param textColor 字体颜色
 @return 一个EUUIFillButton
 */
- (instancetype)initWithFillColor:(nullable UIColor *)fillColor titleTextColor:(nullable UIColor *)textColor;

@property(nonatomic, strong, nullable) IBInspectable UIColor *fillColor; // 默认为 FillButtonColorBlue
@property(nonatomic, strong, nullable) IBInspectable UIColor *titleTextColor; // 默认为 UIColorWhite
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;// 默认为 QMUIFillButtonCornerRadiusAdjustsBounds，也即固定保持按钮高度的一半。

@end

NS_ASSUME_NONNULL_END
