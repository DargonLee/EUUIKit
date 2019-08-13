//
//  UINavigationBar+EUUI.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/23.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "UINavigationBar+EUUI.h"
#import <objc/runtime.h>

@implementation UINavigationBar (EUUI)

static char overlayKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
    
}

- (void)setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

- (UIView *)backgroundView {
    return [self valueForKey:@"_backgroundView"];
}

- (__kindof UIView *)backgroundContentView {
    if (@available(iOS 10, *)) {
        UIImageView *imageView = [self.backgroundView valueForKey:@"_backgroundImageView"];
        UIVisualEffectView *visualEffectView = [self.backgroundView valueForKey:@"_backgroundEffectView"];
        UIView *customView = [self.backgroundView valueForKey:@"_customBackgroundView"];
        UIView *result = customView && customView.superview ? customView : (imageView && imageView.superview ? imageView : visualEffectView);
        return result;
    } else {
        UIView *backdrop = [self.backgroundView valueForKey:@"_adaptiveBackdrop"];
        UIView *result = backdrop && backdrop.superview ? backdrop : self.backgroundView;
        return result;
    }
}

@end
