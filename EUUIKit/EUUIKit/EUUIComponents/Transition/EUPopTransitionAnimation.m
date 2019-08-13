//
//  EUPopTransitionAnimation.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/23.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUPopTransitionAnimation.h"

@implementation EUPopTransitionAnimation


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //处理的特殊性.在UIModalPresentationCustom模式下，presentingView 并不受 containerView 管理，fromView(presentingView) 未被移出视图结构。所以presentation 转场中，不要手动将 fromView(presentingView) 移出其父视图。在 dismissal 转场中不要将 toView(presentingView) 加入 containerView
    // For a Presentation:
    //      fromView = The presenting view.
    //      toView   = The presented view.
    // For a Dismissal:
    //      fromView = The presented view.
    //      toView   = The presenting view.
    
    // 1.获取源控制器、目标控制器、动画容器View
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGFloat duration = [self transitionDuration:transitionContext];
    UIView *containerView = transitionContext.containerView;
    
    // 2. 获取源控制器、目标控制器 的View，但是注意二者在开始动画，消失动画，身份是不一样的：
    // 也可以直接通过上面获取控制器获取，比如：toViewController.view
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    // 3.设置动画具体细节，使用[UIView animate...]动画，或者其他方式呈现动画。
    if (toVC.isBeingPresented) {
        [containerView addSubview:toView];  //必须添加到动画容器View上。
        CGSize size = toVC.preferredContentSize;
        toView.center = containerView.center;
        toView.bounds = CGRectMake(0, 0, size.width, size.height);
        toView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView animateWithDuration:duration animations:^{
            toView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
    
    //Dismissal 转场中不要将 toView 添加到 containerView
    if (fromVC.isBeingDismissed) {
        [UIView animateWithDuration:duration animations:^{
            fromView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
    
}

@end
