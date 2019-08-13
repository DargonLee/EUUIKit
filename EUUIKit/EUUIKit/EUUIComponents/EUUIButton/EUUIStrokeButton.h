//
//  EUUIStrokeButton.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/14.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <EUUIKit/EUUIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EUUIStrokeButtonColorType) {
    EUUIStrokeButtonColorTypeBlue,
    EUUIStrokeButtonColorTypeRed,
    EUUIStrokeButtonColorTypeGreen,
    EUUIStrokeButtonColorTypeGray,
    EUUIStrokeButtonColorTypeWhite,
};

@interface EUUIStrokeButton : EUUIButton

@property(nonatomic, strong, nullable) IBInspectable UIColor *strokeColor;    // 默认为 GhostButtonColorBlue
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;    // 默认为 1pt
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;   // 默认为 QMUIGhostButtonCornerRadiusAdjustsBounds，也即固定保持按钮高度的一半。


- (instancetype)initWithStrokeType:(EUUIStrokeButtonColorType)strokeType;
+ (instancetype)strokeTypeButton:(EUUIStrokeButtonColorType)strokeType;
- (instancetype)initWithStrokeColor:(nullable UIColor *)strokeColor;

@end

NS_ASSUME_NONNULL_END
