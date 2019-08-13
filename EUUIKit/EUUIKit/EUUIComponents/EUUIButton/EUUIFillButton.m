//
//  EUUIFillButton.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/14.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUUIFillButton.h"
#import "EUUICore.h"

@implementation EUUIFillButton

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWitFillType:EUUIFillButtonColorTypeBlue];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        self.fillColor = [UIColor blueColor];
        self.titleTextColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWitFillType:(EUUIFillButtonColorType)fillType
{
    UIColor *fillColor = nil;
    UIColor *textColor = [UIColor whiteColor];
    switch (fillType) {
        case EUUIFillButtonColorTypeBlue:
            fillColor = FillButtonColorBlue;
            break;
        case EUUIFillButtonColorTypeRed:
            fillColor = FillButtonColorRed;
            break;
        case EUUIFillButtonColorTypeGreen:
            fillColor = FillButtonColorGreen;
            break;
        case EUUIFillButtonColorTypeGray:
            fillColor = FillButtonColorGray;
            break;
        case EUUIFillButtonColorTypeWhite:
            fillColor = FillButtonColorWhite;
            break;
            
        default:
            break;
    }
    return [self initWithFillColor:fillColor titleTextColor:textColor];
}

+ (instancetype)fillButtonType:(EUUIFillButtonColorType)fillType
{
    return [[self alloc]initWitFillType:fillType];
}

- (instancetype)initWithFillColor:(nullable UIColor *)fillColor titleTextColor:(nullable UIColor *)textColor
{
    if (self == [super initWithFrame:CGRectZero]) {
        self.fillColor = fillColor;
        self.titleTextColor = textColor;
        self.cornerRadius = -1;
    }
    return self;
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    self.backgroundColor = fillColor;
}

- (void)setTitleTextColor:(UIColor *)titleTextColor
{
    _titleTextColor = titleTextColor;
    [self setTitleColor:titleTextColor forState:UIControlStateNormal];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self setNeedsLayout];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    if (self.cornerRadius != -1) {
        self.layer.cornerRadius = self.cornerRadius;
    }else {
        self.layer.cornerRadius = CGRectGetHeight(self.bounds) * 0.5;
    }
}

@end
