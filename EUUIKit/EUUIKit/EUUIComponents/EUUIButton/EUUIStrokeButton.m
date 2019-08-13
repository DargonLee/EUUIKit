//
//  EUUIStrokeButton.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/14.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUUIStrokeButton.h"

@implementation EUUIStrokeButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        [self initializeWithColor:StrokeButtonColorBlue];
    }
    return self;
}

- (instancetype)initWithStrokeType:(EUUIStrokeButtonColorType)strokeType
{
    UIColor *color = nil;
    switch (strokeType) {
        case EUUIStrokeButtonColorTypeBlue:
            color = StrokeButtonColorBlue;
            break;
        case EUUIStrokeButtonColorTypeRed:
            color = StrokeButtonColorRed;
            break;
        case EUUIStrokeButtonColorTypeGreen:
            color = StrokeButtonColorGreen;
            break;
        case EUUIStrokeButtonColorTypeGray:
            color = StrokeButtonColorGray;
            break;
        case EUUIStrokeButtonColorTypeWhite:
            color = StrokeButtonColorWhite;
            break;
            
        default:
            break;
    }
    return [self initWithStrokeColor:color];
}

+ (instancetype)strokeTypeButton:(EUUIStrokeButtonColorType)strokeType
{
    return [[self alloc]initWithStrokeType:strokeType];
}

- (instancetype)initWithStrokeColor:(nullable UIColor *)strokeColor
{
    if (self == [super initWithFrame:CGRectZero]) {
        [self initializeWithColor:strokeColor];
    }
    return self;
}

- (void)initializeWithColor:(UIColor *)color
{
    self.strokeColor = color;
    self.borderWidth = 1.0f;
    self.cornerRadius = -1;
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    [self setTitleColor:strokeColor forState:UIControlStateNormal];
    self.layer.borderColor = _strokeColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth;
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
