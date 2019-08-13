//
//  UIView+EUUI.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/13.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "UIView+EUUI.h"
#import <objc/runtime.h>

static char jk_kActionHandlerTapBlockKey;
static char jk_kActionHandlerTapGestureKey;
static char jk_kActionHandlerLongPressBlockKey;
static char jk_kActionHandlerLongPressGestureKey;

@implementation UIView (EUUI)
+ (instancetype)loadNibView
{
    return  [[[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil]instantiateWithOwner:nil options:nil] objectAtIndex:0];
}

- (UIImage *)screenshot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

- (UIImage *)screenshot:(CGFloat)maxWidth
{
    CGAffineTransform oldTransform = self.transform;
    CGAffineTransform scaleTransform = CGAffineTransformIdentity;
    if (!isnan(maxWidth) && maxWidth>0) {
        CGFloat maxScale = maxWidth/CGRectGetWidth(self.frame);
        CGAffineTransform transformScale = CGAffineTransformMakeScale(maxScale, maxScale);
        scaleTransform = CGAffineTransformConcat(oldTransform, transformScale);
        
    }
    if(!CGAffineTransformEqualToTransform(scaleTransform, CGAffineTransformIdentity)){
        self.transform = scaleTransform;
    }
    
    CGRect actureFrame = self.frame; //已经变换过后的frame
    CGRect actureBounds= self.bounds;//CGRectApplyAffineTransform();
    
    //begin
    UIGraphicsBeginImageContextWithOptions(actureFrame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1, -1);
    CGContextTranslateCTM(context,actureFrame.size.width/2, actureFrame.size.height/2);
    CGContextConcatCTM(context, self.transform);
    CGPoint anchorPoint = self.layer.anchorPoint;
    CGContextTranslateCTM(context,
                          -actureBounds.size.width * anchorPoint.x,
                          -actureBounds.size.height * anchorPoint.y);
    if([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //end
    self.transform = oldTransform;
    
    return screenshot;
}

- (void)addTapActionWithBlock:(EUGestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &jk_kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &jk_kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &jk_kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        EUGestureActionBlock block = objc_getAssociatedObject(self, &jk_kActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
- (void)addLongPressActionWithBlock:(EUGestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &jk_kActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &jk_kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &jk_kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        EUGestureActionBlock block = objc_getAssociatedObject(self, &jk_kActionHandlerLongPressBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}

@end

#pragma mark---------------------------EUUI_Layout--------------------------------

@implementation UIView (EUUI_Layout)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    
    center.y = centerY;
    
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}
- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}


- (CGFloat)bottom
{
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (void)heightEqualToView:(UIView *)view
{
    self.height = view.height;
}

- (void)widthEqualToView:(UIView *)view
{
    self.width = view.height;
}

- (void)sizeEqualToView:(UIView *)view
{
    self.frame = CGRectMake(self.x, self.y, view.width, view.height);
}

- (void)centerXEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewPoint toView:self.superview];
    self.centerX = centerPoint.x;
}

- (void)centerYEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewPoint toView:self.superview];
    self.centerY = centerPoint.y;
}

- (void)centerEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewPoint toView:self.superview];
    self.centerX = centerPoint.x;
    self.centerY = centerPoint.y;
}

- (void)topEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    self.y = newOrigin.y;
}

- (void)bottomEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    self.y = newOrigin.y + view.height - self.height;
}

- (void)leftEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    self.x = newOrigin.x;
}

- (void)rightEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    self.x = newOrigin.x + view.width - self.width;
}

- (UIView *)topSuperView
{
    UIView *topSuperView = self.superview;
    
    if (topSuperView == nil) {
        topSuperView = self;
    } else {
        while (topSuperView.superview) {
            topSuperView = topSuperView.superview;
        }
    }
    
    return topSuperView;
}

#pragma mark---------------------------AutoLayout--------------------------------
- (void)configView
{
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
}
- (void)autoCenterInSuperview
{
    [self configView];
    UIView *superview = self.superview;
    [self.centerXAnchor constraintEqualToAnchor:superview.centerXAnchor].active = YES;
    [self.centerYAnchor constraintEqualToAnchor:superview.centerYAnchor].active = YES;
}

- (void)autoFillInSuperview
{
    [self configView];
    UIView *superview = self.superview;
    [self.leadingAnchor constraintEqualToAnchor:superview.leadingAnchor].active = YES;
    [self.rightAnchor constraintEqualToAnchor:superview.rightAnchor].active = YES;
    [self.topAnchor constraintEqualToAnchor:superview.topAnchor].active = YES;
    [self.bottomAnchor constraintEqualToAnchor:superview.bottomAnchor].active = YES;
}

- (void)autoSetDimensionsToSize:(CGSize)size
{
    [self configView];
    [self.widthAnchor constraintEqualToConstant:size.width].active = YES;
    [self.heightAnchor constraintEqualToConstant:size.height].active = YES;
}

- (void)autoPinEdgeLeftInSuperviewWithOffset:(CGFloat)offset
{
    [self configView];
    UIView *superview = self.superview;
    [self.leftAnchor constraintEqualToAnchor:superview.leftAnchor constant:offset];
}

- (void)autoPinEdgeRightInSuperviewWithOffset:(CGFloat)offset
{
    [self configView];
    UIView *superview = self.superview;
    [self.rightAnchor constraintEqualToAnchor:superview.rightAnchor constant:offset];
}

- (void)autoPinEdgeTopInSuperviewWithOffset:(CGFloat)offset
{
    [self configView];
    UIView *superview = self.superview;
    [self.topAnchor constraintEqualToAnchor:superview.topAnchor constant:offset];
}

- (void)autoPinEdgeBottomInSuperviewWithOffset:(CGFloat)offset
{
    [self configView];
    UIView *superview = self.superview;
    [self.bottomAnchor constraintEqualToAnchor:superview.bottomAnchor constant:offset];
}

@end
