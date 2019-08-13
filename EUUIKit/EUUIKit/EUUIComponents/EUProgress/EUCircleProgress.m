//
//  EUCircleProgress.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/15.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUCircleProgress.h"
#import "EUUICore.h"


@interface EUCircleProgress ()

@property (nonatomic, weak) UILabel *valueLabel;

@end

@implementation EUCircleProgress

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UILabel *label = [[UILabel alloc]initWithFrame:self.bounds];
    label.font = UIFontMake(16);
    label.textColor = ProgressColor;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.valueLabel = label;
    
    self.backgroundColor = [UIColor clearColor];
    self.lineWidth = 5.0;
    self.tintColor = ProgressColor;
    self.bottomTintColor = ProgressTintColor;
    self.valueString = @"Done";
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    if (progress > 1) {
        if ([self.delegate respondsToSelector:@selector(circleProgressDidDone:)]) {
            [self.delegate circleProgressDidDone:self];
        }
        return;
    }
    // floor 如果参数是小数  则求最大的整数但不大于本身
    // 用两个%%代表一个%
    self.valueLabel.text = [NSString stringWithFormat:@"%.0f%%", progress*100];

    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.valueLabel.textColor = textColor;
}

- (void)setValueString:(NSString *)valueString
{
    _valueString = valueString;
    if (self.progress > 1) {
        self.valueLabel.text = valueString;
    }
}

- (void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius0 = (MIN(rect.size.width, rect.size.height) - self.lineWidth) * 0.5;
    CGFloat strartAngle = M_PI * 1.5;
    CGFloat angle = self.progress * M_PI * 2;
    CGFloat endAngle0 = strartAngle + M_PI * 2;
    CGFloat endAngle = strartAngle + angle;
    UIBezierPath *path0 = [[UIBezierPath alloc]init];
    path0.lineWidth = self.lineWidth;
    [self.bottomTintColor set];
    path0.lineCapStyle = kCGLineCapRound;
    path0.lineJoinStyle = kCGLineJoinRound;
    [path0 addArcWithCenter:center radius:radius0 startAngle:strartAngle endAngle:endAngle0 clockwise:YES];
    [path0 stroke];
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    path.lineWidth = self.lineWidth;
    [self.tintColor set];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [path addArcWithCenter:center radius:radius0 startAngle:strartAngle endAngle:endAngle clockwise:YES];
    [path stroke];
    
}

@end
