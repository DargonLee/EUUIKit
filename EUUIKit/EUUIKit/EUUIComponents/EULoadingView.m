//
//  EULoadingView.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/17.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EULoadingView.h"
#import "UIView+EUUI.h"
#import "EUUICore.h"

#define kLineWidth 5.0f

@interface EULoadingView ()

@property (nonatomic, strong) CAGradientLayer * gradientLayer;

@property (nonatomic, strong) CAShapeLayer *shapLayer;

@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation EULoadingView

- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        _gradientLayer = [[CAGradientLayer alloc]init];
        _gradientLayer.colors = @[(__bridge id)UIColorMakeWithRGBA(245, 222, 179, 0.8).CGColor,(__bridge id)UIColorMakeWithRGBA(255, 165, 0.0, 0.8).CGColor];
        _gradientLayer.locations = @[@0.3,@0.1];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1.0, 0);
    }
    return _gradientLayer;
}

- (CAShapeLayer *)shapLayer
{
    if (!_shapLayer) {
        _shapLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        CGFloat radius = self.frame.size.width * 0.5 - 5;
        CGFloat startA = -M_PI_2;
        CGFloat angle =  1.0 *  M_PI * 2;
        CGFloat endA = startA + angle;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        _shapLayer.path = path.CGPath;
        _shapLayer.lineWidth = 2.0f;
        _shapLayer.fillColor = [UIColor clearColor].CGColor;
        _shapLayer.strokeColor = [UIColor greenColor].CGColor;
        
    }
    return _shapLayer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        UIImageView *bgImageView = [[UIImageView alloc]init];
        [self addSubview:bgImageView];
        self.bgImageView = bgImageView;
        self.gradientLayer.mask = self.shapLayer;
        [self.layer insertSublayer:self.gradientLayer atIndex:0];
    }
    return self;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self animation];
    [self animation1];
}

- (void)animation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 2;
    animation.removedOnCompletion = NO;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    self.gradientLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.gradientLayer addAnimation:animation forKey:@""];
}

- (void)animation1
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.duration = 3;
    animation.removedOnCompletion = NO;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.bgImageView.layer addAnimation:animation forKey:@""];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bgImageView.frame = CGRectMake(15, 15, self.width - 30, self.height - 30);
    self.gradientLayer.frame = self.bounds;
    self.shapLayer.frame = self.bounds;
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(100, 100);
}

- (void)setLogoImageName:(NSString *)logoImageName
{
    _logoImageName = logoImageName;
    self.bgImageView.image = [[UIImage imageNamed:logoImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
}

- (void)setColors:(NSArray *)colors
{
    _colors = colors;
    self.gradientLayer.colors = colors;
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    self.shapLayer.lineWidth = lineWidth;
}

@end
