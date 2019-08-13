//
//  EULabel.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/20.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EULabel : UILabel

/**
 快速创建一个带有行间距的Label

 @param string 文本内容
 @return EULabel
 */
+ (instancetype)lableWithString:(NSString *)string;

/**
 是否打开拷贝按钮
 */
@property (nonatomic, assign) IBInspectable BOOL canPerformCopyAction;

/**
 拷贝按钮的文本
 */
@property (nonatomic, copy) IBInspectable NSString *titleForCopyAction;

/**
 长按时 label的背景颜色
 */
@property (nonatomic,strong) IBInspectable UIColor *highlightedBackgroundColor;

/**
 点击了复制的block
 */
@property (nonatomic, copy) void (^didCopyBlock)(EULabel *label, NSString *copiedString);


@end

NS_ASSUME_NONNULL_END
