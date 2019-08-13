//
//  EUHelper.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/10.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUHelper.h"
#import <sys/utsname.h>
#import "EUUICore.h"


@implementation EUHelper

+ (instancetype _Nonnull)sharedInstance
{
    static EUHelper *_helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _helper = [[super allocWithZone:NULL]init];
    });
    return _helper;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

@end


@implementation EUHelper (Device)
+ (NSString *)deviceModel
{
    if ([EUHelper isSimulator]) {
        return [NSString stringWithFormat:@"%s", getenv("SIMULATOR_MODEL_IDENTIFIER")];
    }
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (BOOL)isIPhoneX_Series
{
    if ([EUHelper isIPhoneX_Or_XS] || [EUHelper isIPhoneXR] || [EUHelper isIPhoneXS_Max]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPad
{
    NSInteger isIPad = -1;
    if (isIPad < 0) {
        isIPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 1 : 0;
    }
    return isIPad > 0;
}

+ (BOOL)isIPhone
{
    NSInteger isIPhone = -1;
    if (isIPhone < 0) {
        NSString *string = [[UIDevice currentDevice] model];
        isIPhone = [string rangeOfString:@"iPhone"].location != NSNotFound ? 1 : 0;
    }
    return isIPhone > 0;
}

static NSInteger isSimulator = -1;
+ (BOOL)isSimulator {
    if (isSimulator < 0) {
#if TARGET_OS_SIMULATOR
        isSimulator = 1;
#else
        isSimulator = 0;
#endif
    }
    return isSimulator > 0;
}

+ (BOOL)isIPhoneXS_Max
{
    return DEVICE_WIDTH == [self screenSizeForIPhoneXS_Max].width ? 1 : 0;
}

+ (BOOL)isIPhoneXR
{
    return DEVICE_WIDTH == [self screenSizeForIPhoneXR].width ? 1 : 0;
}

+ (BOOL)isIPhoneX_Or_XS
{
    return DEVICE_WIDTH == [self screenSizeForIPhoneX_Or_XS].width ? 1 : 0;
}

+ (BOOL)isIPhone8_Plus
{
    return DEVICE_WIDTH == [self screenSizeForIPhone8_Plus].width ? 1 : 0;
}

+ (BOOL)isIPhone8
{
    return DEVICE_WIDTH == [self screenSizeForIPhone8].width ? 1 : 0;
}

+ (BOOL)isIPhone5
{
    return DEVICE_WIDTH == [self screenSizeForIPhone5].width ? 1 : 0;
}

+ (BOOL)isIPhone4
{
    return DEVICE_WIDTH == [self screenSizeForIPhone4].width ? 1 : 0;
}

+ (CGSize)screenSizeForIPhoneXS_Max
{
     return CGSizeMake(414, 896);
}
+ (CGSize)screenSizeForIPhoneXR
{
    return CGSizeMake(414, 896);
}
+ (CGSize)screenSizeForIPhoneX_Or_XS
{
    return CGSizeMake(375, 812);
}
+ (CGSize)screenSizeForIPhone8_Plus
{
    return CGSizeMake(414, 736);
}
+ (CGSize)screenSizeForIPhone8
{
    return CGSizeMake(375, 667);
}
+ (CGSize)screenSizeForIPhone5
{
    return CGSizeMake(320, 568);
}
+ (CGSize)screenSizeForIPhone4
{
    return CGSizeMake(320, 480);
}

@end
