//
//  SSOAlertView.h
//  MOS
//
//  Created by Harlans on 2019/3/20.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EUAlertView : NSObject

+ (void)alertControllerWithTitle:(NSString *)title
                         message:(NSString *)message
                          cancelText:(NSString *)cancelText
                          okText:(NSString *)okText
                    cancelAction:(void (^ __nullable)(UIAlertAction *action))cancel
                        okAction:(void (^ __nullable)(UIAlertAction *action))ok;

+ (void)alertControllerWithTitle:(NSString *)title
                         message:(NSString *)message
                          okText:(NSString *)okText
                        okAction:(void (^ __nullable)(UIAlertAction *action))ok;

+ (void)sheetControllerWithTitle:(NSString *)title
                         message:(NSString *)message
                          sheets:(NSArray <NSString *>*)sheets
                      cancelText:(NSString *)cancelText
                    sheetsAction:(void (^ __nullable)(UIAlertAction *action))sheetsAction
                    cancelAction:(void (^ __nullable)(UIAlertAction *action))cancelAction;


+ (void)showLoadingWithTitle:(NSString *)title;

+ (void)hideLoading;

@end

NS_ASSUME_NONNULL_END
