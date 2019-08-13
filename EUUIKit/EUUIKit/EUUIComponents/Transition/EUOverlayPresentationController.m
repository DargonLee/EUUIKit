//
//  EUOverlayPresentationController.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/23.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUOverlayPresentationController.h"

@interface EUOverlayPresentationController()

@property (nonatomic, weak) UIView *dimmingView;

@end


@implementation EUOverlayPresentationController


- (UIPresentationController* )presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return self;
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)presentationTransitionWillBegin
{
    CGFloat dimmingViewInitailWidth = self.containerView.frame.size.width;
    CGFloat dimmingViewInitailHeight = self.containerView.frame.size.height;
    UIView *view = [[UIView alloc]init];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.f;
    view.center = self.containerView.center;
    view.bounds = CGRectMake(0, 0, dimmingViewInitailWidth, dimmingViewInitailHeight);
    [self.containerView addSubview:view];
    self.dimmingView = view;
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.6f;
    } completion:nil];
}

- (void)dismissalTransitionWillBegin
{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.f;
    } completion:nil];
}


- (void)containerViewWillLayoutSubviews
{
    self.dimmingView.center = self.containerView.center;
    self.dimmingView.bounds = self.containerView.bounds;
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    // 在取消动画的情况下，可能为NO，这种情况下，应该取消视图的引用，防止视图没有释放
    if (!completed) {
        self.dimmingView = nil;
    }
}

// 消失过渡完成之后调用，此时应该将视图移除，防止强引用
- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed == YES)
    {
        [self.dimmingView removeFromSuperview];
        self.dimmingView = nil;
    }
}


//| --------以下四个方法，是按照苹果官方Demo里的，都是为了计算目标控制器View的frame的----------------
//  当 presentation controller 接收到
//  -viewWillTransitionToSize:withTransitionCoordinator: message it calls this
//  method to retrieve the new size for the presentedViewController's view.
//  The presentation controller then sends a
//  -viewWillTransitionToSize:withTransitionCoordinator: message to the
//  presentedViewController with this size as the first argument.
//
//  Note that it is up to the presentation controller to adjust the frame
//  of the presented view controller's view to match this promised size.
//  We do this in -containerViewWillLayoutSubviews.
//
- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    if (container == self.presentedViewController)
        return ((UIViewController*)container).preferredContentSize;
    else
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
}

//在我们的自定义呈现中，被呈现的 view 并没有完全完全填充整个屏幕，
//被呈现的 view 的过渡动画之后的最终位置，是由 UIPresentationViewController 来负责定义的。
//我们重载 frameOfPresentedViewInContainerView 方法来定义这个最终位置
- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    
    // The presented view extends presentedViewContentSize.height points from
    // the bottom edge of the screen.
    CGRect presentedViewControllerFrame = containerViewBounds;
    presentedViewControllerFrame.size.height = presentedViewContentSize.height;
    presentedViewControllerFrame.origin.y = CGRectGetMaxY(containerViewBounds) - presentedViewContentSize.height;
    return presentedViewControllerFrame;
}


//  This method is invoked whenever the presentedViewController's
//  preferredContentSize property changes.  It is also invoked just before the
//  presentation transition begins (prior to -presentationTransitionWillBegin).
//  建议就这样重写就行，这个应该是控制器内容大小变化时，就会调用这个方法， 比如适配横竖屏幕时，翻转屏幕时
//  可以使用UIContentContainer的方法来调整任何子视图控制器的大小或位置。
- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container
{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    
    if (container == self.presentedViewController)
        [self.containerView setNeedsLayout];
}

#pragma mark 点击了背景遮罩view
- (void)dimmingViewTapped:(UITapGestureRecognizer*)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
