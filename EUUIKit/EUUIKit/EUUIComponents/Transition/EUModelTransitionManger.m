//
//  EUModelTransitionManger.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/24.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUModelTransitionManger.h"
#import "EUOverlayPresentationController.h"
#import "EUPopTransitionAnimation.h"

@implementation EUModelTransitionManger

/**
 presented为要弹出的Controller
 presenting为当前的Controller
 source为源Contrller 对于present动作  presenting与source是一样的
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    id obj = nil;
    switch (self.transitionType) {
        case EUModalTransitionTypePop:
        {
            obj = [[EUPopTransitionAnimation alloc]init];
        }
            break;
            
        default:
            break;
    }
    return obj;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    id obj = nil;
    switch (self.transitionType) {
        case EUModalTransitionTypePop:
        {
            obj = [[EUPopTransitionAnimation alloc]init];
        }
            break;
            
        default:
            break;
    }
    return obj;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[EUOverlayPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
