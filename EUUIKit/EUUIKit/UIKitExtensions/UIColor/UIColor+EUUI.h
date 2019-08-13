//
//  UIColor+EUUI.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/22.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (EUUI)

/**
 *  导航条颜色
 */
+ (UIColor *)appNavigationBarColor;

/**
 *  app背景色
 */
+ (UIColor *)appBackGroundColor;
/**
 *  app主题颜色
 * */
+ (UIColor *)appMainColor;

/**
 *  app直线颜色
 */
+ (UIColor *)appLineColor;
//app导航栏文字颜色

+ (UIColor *)appNavTitleColor;
/**
 *  app标题颜色
 */
+ (UIColor *)appTitleColor;

/**
 *  app文字颜色
 */
+ (UIColor *)appTextColor;

/**
 *  app浅红色颜色
 */
+ (UIColor *)appLightRedColor;

/**
 *  app输入框颜色
 */
+ (UIColor *)appTextFieldColor;

/**
 *  app黑色颜色
 */
+ (UIColor *)appBlackColor;


/**
 *  app次分割线
 */
+ (UIColor *)appSecondLineColor;

/**
 *   用HexString 生成 UIColor
 *
 *  @param hexString   #RGB  #ARGB   #RRGGBB  #AARRGGBB 或者不带#
 */
+ (UIColor *)colorWithMacHexString:(NSString *)hexString;

/**
 *  当前UIColor用的HexString
 */
- (NSString *)HEXString;

/**
 *  当前UIColor用的RGB(255,255,255,1.0) 用纯数字
 */
+ (UIColor *)colorWithMacWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue
                            alpha:(CGFloat)alpha;

/**
 用RGB值获取颜色 RGB(255,255,255,1.0)

 @param red 红
 @param green 绿
 @param blue 兰
 @return UIColor
 */
+ (UIColor *)colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue;

/**
 *  @brief  随机颜色
 *
 *  @return UIColor
 */
+ (UIColor *)RandomColor;

/**
 *  @brief  渐变颜色
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param height 渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;


@end

NS_ASSUME_NONNULL_END
