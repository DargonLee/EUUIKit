//
//  EUInstallProgress.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/15.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUInstallProgress.h"
#import "EUUICore.h"

@interface EUInstallProgress ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation EUInstallProgress

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialized];
    }
    
    return self;
}

- (void)initialized
{
    _fillColor = ProgressInstallFillColor;
    self.layer.borderColor = ProgressInstallBorderColor.CGColor;
    self.layer.cornerRadius = 4.0;
    self.layer.borderWidth = 1.0f;
    self.clipsToBounds = YES;
    self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self setTitleColor:_fillColor forState:UIControlStateNormal];
    [self.layer addSublayer:self.progressLayer];
    self.layer.borderColor = ProgressInstallBorderColor.CGColor;
    [self setTitleColor:ProgressInstallBorderColor forState:UIControlStateNormal];
}

- (CAShapeLayer *)progressLayer
{
    CGSize size = self.bounds.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, height / 2)];
    [bezierPath addLineToPoint:CGPointMake(width, height / 2)];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.path = bezierPath.CGPath;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeEnd = 0;
    _progressLayer.strokeColor = _fillColor.CGColor;
    _progressLayer.lineWidth = height;//线宽
    
    return _progressLayer;
}

- (void)setProgress:(CGFloat)progress
{
    if (_progress == progress) { return; }
    _progress = progress;

    if (progress >= 1.0) {
        if ([self.delegate respondsToSelector:@selector(installProgressDidDone:)]) {
            [_progressLayer removeFromSuperlayer];
            _progressLayer = nil;
            [self.delegate installProgressDidDone:self];
        }
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _progressLayer.strokeEnd = progress;
    [CATransaction commit];
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    _progressLayer.strokeColor = fillColor.CGColor;
}

@end
