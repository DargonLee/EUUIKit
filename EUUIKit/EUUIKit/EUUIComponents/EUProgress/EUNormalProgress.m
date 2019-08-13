//
//  EUNormalProgress.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/15.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUNormalProgress.h"
#import "EUUICore.h"

@interface EUNormalProgress ()

@property (nonatomic, weak) UIView *pView;

@property (nonatomic, weak) UIView *borderView;

@end

@implementation EUNormalProgress

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.borderWidth = 2.0f;
        self.padding = UIEdgeInsetsMake(2, 2, 2, 2);
        //边框
        UIView *borderView = [[UIView alloc] initWithFrame:self.bounds];
        borderView.layer.cornerRadius = self.bounds.size.height * 0.5;
        borderView.layer.masksToBounds = YES;
        borderView.backgroundColor = [UIColor whiteColor];
        borderView.layer.borderColor = [ProgressBorderColor CGColor];
        borderView.layer.borderWidth = self.borderWidth;
        [self addSubview:borderView];
        self.borderView = borderView;
        
        //进度
        UIView *tView = [[UIView alloc] init];
        tView.backgroundColor = ProgressFillColor;
        tView.layer.cornerRadius = (self.bounds.size.height - (self.borderWidth + self.padding.top + self.padding.bottom) * 2) * 0.5;
        tView.layer.masksToBounds = YES;
        [self addSubview:tView];
        self.pView = tView;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    if (progress > 1) {
        if ([self.delegate respondsToSelector:@selector(normalProgressDidDone:)]) {
            [self.delegate normalProgressDidDone:self];
        }
        return;
    }
    CGFloat w = self.bounds.size.width - self.padding.left - self.padding.right - self.borderWidth * 2;
    CGFloat x = self.padding.left + self.borderWidth;
    CGFloat y = self.padding.top + self.borderWidth;
    CGFloat h = self.bounds.size.height - self.padding.top - self.padding.bottom - self.borderWidth * 2;
    self.pView.frame = CGRectMake(x, y, w * progress, h);
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    self.pView.backgroundColor = fillColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.borderView.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.borderView.layer.borderColor = [borderColor CGColor];
}

@end
