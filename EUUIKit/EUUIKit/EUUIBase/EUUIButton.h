//
//  EUUIButton.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/14.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger, EUUIButtonImagePosition){
    EUUIButtonImagePositionTop,   // imageView在titleLabel  上面
    EUUIButtonImagePositionLeft,  // imageView在titleLabel  左边
    EUUIButtonImagePositionBottom,// imageView在titleLabeld 下面
    EUUIButtonImagePositionRight, // imageView在titleLabel  右边
};

@interface EUUIButton : UIButton

/**
 快速创建一个EUUIButton

 @param buttonType EUUIButton 类型
 @return 一个EUUIButton
 */
+ (instancetype)buttonWithImagePositionType:(EUUIButtonImagePosition)buttonType;

/**
 快速设置 UIControlStateNormal 下的 image 和 title

 @param imageName 图片名字
 @param title 文本
 */
- (void)setImageName:(NSString *)imageName title:(NSString *)title;

/**
 设置按钮里图标和文字的相对位置，默认为EUUIButtonImagePositionLeft
 */
@property(nonatomic, assign) EUUIButtonImagePosition imagePosition;

/**
 设置按钮里图标和文字之间的间隔
 */
@property(nonatomic, assign) IBInspectable CGFloat spacingBetweenImageAndTitle;


@end

NS_ASSUME_NONNULL_END
