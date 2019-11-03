//
//  UIViewController+EUUI.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/17.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "UIViewController+EUUI.h"
#import <objc/runtime.h>
#import "MBProgressHUD.h"
#import "EULoadingView.h"
#import "EUEmptyView.h"


static MBProgressHUD * instance_hud;

@implementation UIViewController (EUUI)

- (MBProgressHUD *)HUD
{
    if (instance_hud == nil) {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.removeFromSuperViewOnHide = YES;
        HUD.detailsLabel.font = [UIFont systemFontOfSize:16];
        HUD.label.font = [UIFont systemFontOfSize:16];
        HUD.completionBlock = ^{
            [self hideHud];
        };
        instance_hud = HUD;
    }
    return instance_hud;
}

- (void)setHUD:(MBProgressHUD *)HUD
{
    instance_hud = HUD;
}

- (void)showHint:(NSString *)hint
{
    [self HUD].mode = MBProgressHUDModeText;
    [self HUD].label.text = hint;
    [[self HUD] hideAnimated:YES afterDelay:2.0f];
}

- (void)showHintBottom:(NSString *)hint
{
    [self HUD].mode = MBProgressHUDModeText;
    [self HUD].label.text = hint;
    [self HUD].offset = CGPointMake(0.f, MBProgressMaxOffset);
    [[self HUD] hideAnimated:YES afterDelay:2.0f];
}

- (void)showLoadingWithText:(NSString *)hint
{
    [self HUD].mode = MBProgressHUDModeIndeterminate;
    [self HUD].label.text = hint;
    [[self HUD] showAnimated:YES];
}

- (void)showHudWithCustomView:(UIView *)view
{
    [self HUD].mode = MBProgressHUDModeCustomView;
    [self HUD].customView = view;
    [[self HUD] showAnimated:YES];
}

- (void)showHudWithImageName:(NSString *)imageName hint:(NSString *)hint
{
    [self HUD].mode = MBProgressHUDModeCustomView;
    [self HUD].square = YES;
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self HUD].customView = [[UIImageView alloc] initWithImage:image];
    [self HUD].label.text = hint;
    [[self HUD] showAnimated:YES];
}

- (void)showDeterminateWithProgress:(float)progress hint:(NSString *)hint
{
    [self HUD].mode = MBProgressHUDModeDeterminate;
    [self HUD].label.text = hint;
    [self HUD].progress = progress;
    [[self HUD] showAnimated:YES];
}

- (void)showAnimationLoadingViewWithImageName:(NSString *)imageName hint:(NSString *)hint
{
    [self HUD].mode = MBProgressHUDModeCustomView;
    EULoadingView *view = [[EULoadingView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.logoImageName = imageName;
    [self HUD].customView = view;
    [self HUD].square = YES;
    [self HUD].label.text = hint;
    [[self HUD] showAnimated:YES];
}

- (void)hideHud
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [instance_hud hideAnimated:YES];
        [instance_hud removeFromSuperViewOnHide];
        instance_hud = nil;
    });
}

@end

static EUEmptyView * instance_enptyView;
@implementation UIViewController (Empty)

- (EUEmptyView *)emptyView
{
    if (instance_enptyView == nil) {
        instance_enptyView = [[EUEmptyView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:instance_enptyView];
        [self.view bringSubviewToFront:instance_enptyView];
        [self animation];
    }
    return instance_enptyView;
}
- (void)animation
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.35;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromBottom;
    [self.view.layer addAnimation:transition forKey:nil];
}

- (void)showEmptyViewWithLoading
{
    [[self emptyView] setLoadingViewHide:NO];
}

- (void)showEmptyViewWithText:(NSString *)text detailText:(NSString *)detailText
{
    [self showEmptyViewWithText:text detailText:detailText buttonTitle:nil buttonAction:nil];
}

- (void)showEmptyViewWithImage:(UIImage *_Nullable)image text:(NSString *)text detailText:(NSString *)detailText
{
    [self showEmptyViewWithImage:image text:text detailText:detailText buttonTitle:nil buttonAction:nil];
}

- (void)showEmptyViewWithText:(NSString *)text detailText:(NSString *)detailText buttonTitle:(NSString *_Nullable)title buttonAction:(void(^)(UIButton *clickButton))action
{
    [self showEmptyViewWithImage:nil text:text detailText:detailText buttonTitle:title buttonAction:action];
}

- (void)showEmptyViewWithImage:(UIImage *_Nullable)image text:(NSString *)text detailText:(NSString *)detailText buttonTitle:(NSString *_Nullable)title buttonAction:(void(^)(UIButton *clickButton))action
{
    [[self emptyView] setLoadingViewHide:YES];
    [[self emptyView] setTextLabelText:text];
    [[self emptyView] setDetailTextLabelText:detailText];
    [[self emptyView] setActionButtonTitle:title];
    [[self emptyView] setImage:image];
    [[self emptyView] setDidClcikReloadAction:^(EUEmptyView * _Nonnull view, UIButton * _Nonnull clickButton) {
        action(clickButton);
    }];
}

- (void)hideEmptyView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view sendSubviewToBack:[self emptyView]];
        [[self emptyView] removeFromSuperview];
        instance_enptyView = nil;
    });
}


- (UIViewController*)findViewController
{
    return [self getCurrentViewControllerWithViewController:[self getCurrentWindow].rootViewController];
}
// 获取当前Window
- (UIWindow *)getCurrentWindow
{
    return [UIApplication sharedApplication].keyWindow;
}
- (UIViewController *)getCurrentViewControllerWithViewController:(UIViewController *)viewController
{
    UIViewController *currentVC = viewController;
    BOOL flag = NO;
    if ([currentVC isKindOfClass:[UITabBarController class]])
    {
        flag = YES;
        currentVC = [(UITabBarController *)currentVC selectedViewController];
    }
    else if ([currentVC isKindOfClass:[UINavigationController class]])
    {
        flag = YES;
        currentVC = [(UINavigationController *)currentVC visibleViewController];
    }
    else if (currentVC.presentedViewController)
    {
        flag = YES;
        currentVC = currentVC.presentedViewController;
    }
    if (flag)
    {
        return [self getCurrentViewControllerWithViewController:currentVC];
    }
    
    return currentVC;
}


- (void)showAlert:(UIViewController*)viewController title:(NSString*)title message:(NSString*)message okBtnTitle:(NSString*)okBtnTitle block:(UIAlertControllerCompletionBlock)block
{
    [UIAlertController showAlertInViewController:viewController
                                       withTitle:title
                                         message:message
                               cancelButtonTitle:okBtnTitle
                          destructiveButtonTitle:nil
                               otherButtonTitles:nil
                                        tapBlock:block];
}
- (void)showConfim:(UIViewController*)viewController title:(NSString*)title message:(NSString*)message okBtnTitle:(NSString*)okBtnTitle cancelBtnTitle:(NSString*)cancelBtnTitle block:(UIAlertControllerCompletionBlock)block
{
    [UIAlertController showAlertInViewController:viewController
                                       withTitle:title
                                         message:message
                               cancelButtonTitle:cancelBtnTitle
                          destructiveButtonTitle:nil
                               otherButtonTitles:@[okBtnTitle]
                                        tapBlock:block];
}

@end
