//
//  EULockView.h
//  EUUIKit
//
//  Created by Harlans on 2019/6/3.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EULockView : UIView

/**
 快速创建EULockView对象方法

 @param normal 手势按钮正常图片
 @param selected 手势按钮选中图片
 @return EULockView对象
 */
- (instancetype)initWithNormalImage:(NSString *)normal selectedImage:(NSString *)selected;

/**
 手势按钮未选中的按钮图片名
 */
@property (nonatomic, copy) IBInspectable NSString *normalImageName;

/**
 手势按钮选中的按钮图片名
 */
@property (nonatomic, copy) IBInspectable NSString *selectedImageName;

/**
 线宽
 */
@property (nonatomic, assign) IBInspectable CGFloat lineWidth;

/**
 线颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *lineColor;

/**
 获取手势密码
 */
@property (nonatomic, copy) void(^getGesturePwd)(NSString *pwd);


@end

NS_ASSUME_NONNULL_END
