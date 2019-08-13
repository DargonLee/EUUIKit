//
//  EUHelper.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/10.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EUHelper : NSObject

+ (instancetype _Nonnull)sharedInstance;

@end


@interface EUHelper (Device)

+ (NSString *)deviceModel;

+ (BOOL)isIPad;
+ (BOOL)isIPhone;
+ (BOOL)isSimulator;
+ (BOOL)isIPhoneX_Series;

+ (BOOL)isIPhoneXS_Max;
+ (BOOL)isIPhoneXR;
+ (BOOL)isIPhoneX_Or_XS;
+ (BOOL)isIPhone8_Plus;
+ (BOOL)isIPhone8;
+ (BOOL)isIPhone5;
+ (BOOL)isIPhone4;

+ (CGSize)screenSizeForIPhoneXS_Max;
+ (CGSize)screenSizeForIPhoneXR;
+ (CGSize)screenSizeForIPhoneX_Or_XS;
+ (CGSize)screenSizeForIPhone8;
+ (CGSize)screenSizeForIPhone8_Plus;
+ (CGSize)screenSizeForIPhone5;
+ (CGSize)screenSizeForIPhone4;

@end

NS_ASSUME_NONNULL_END
