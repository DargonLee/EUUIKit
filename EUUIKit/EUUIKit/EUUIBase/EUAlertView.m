//
//  SSOAlertView.m
//  MOS
//
//  Created by Harlans on 2019/3/20.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUAlertView.h"

static UIAlertController *tempVC;

@implementation EUAlertView

+ (void)alertControllerWithTitle:(NSString *)title
                         message:(NSString *)message
                      cancelText:(NSString *)cancelText
                          okText:(NSString *)okText
                    cancelAction:(void (^ __nullable)(UIAlertAction *action))cancel
                        okAction:(void (^ __nullable)(UIAlertAction *action))ok
{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:cancelText style:UIAlertActionStyleDefault handler:cancel];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:okText style:UIAlertActionStyleDefault handler:ok];
    [vc addAction:action0];
    [vc addAction:action1];
    [[self getCurrentViewController] presentViewController:vc animated:YES completion:nil];
}

+ (void)alertControllerWithTitle:(NSString *)title
                         message:(NSString *)message
                          okText:(NSString *)okText
                        okAction:(void (^ __nullable)(UIAlertAction *action))ok
{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:okText style:UIAlertActionStyleDefault handler:ok];
    [vc addAction:action1];
    [[self getCurrentViewController] presentViewController:vc animated:YES completion:nil];
}

+ (void)sheetControllerWithTitle:(NSString *)title
                         message:(NSString *)message
                          sheets:(NSArray <NSString *>*)sheets
                      cancelText:(NSString *)cancelText
                    sheetsAction:(void (^ __nullable)(UIAlertAction *action))sheetsAction
                    cancelAction:(void (^ __nullable)(UIAlertAction *action))cancelAction
{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:cancelText style:UIAlertActionStyleCancel handler:cancelAction];
    [vc addAction:action1];
    if (sheets.count > 0) {
        for (NSString *str in sheets) {
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:sheetsAction];
            [vc addAction:action1];
        }
    }
    [[self getCurrentViewController] presentViewController:vc animated:YES completion:nil];
}

+ (void)showLoadingWithTitle:(NSString *)title
{
    tempVC = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [[self getCurrentViewController] presentViewController:tempVC animated:YES completion:nil];
}

+ (void)hideLoading
{
    [tempVC dismissViewControllerAnimated:YES completion:nil];
    tempVC = nil;
}

+ (UIViewController *)getRootViewController
{
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}


+ (UIViewController *)getCurrentViewController
{
    UIViewController* currentViewController = [self getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}

@end
