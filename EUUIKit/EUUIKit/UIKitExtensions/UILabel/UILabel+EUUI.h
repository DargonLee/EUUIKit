//
//  UILabel+EUUI.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/21.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (EUUI)

/**
 获取当前文本一定宽度下的高度
 
 @return 文本高度
 */
- (CGFloat)labelTextHeight;

/**
 获取当前文本下一定宽度下的rect
 
 @return 文本的rect
 */
- (CGRect)labelTextRect;

/**
 让label根据当前文本设置 自适应高度 注意：需要提前设定label的宽度
 */
- (void)sizeToFitLabel;

/**
 设置文本行间距

 @param text 文本
 @param lineSpacing 行间距
 */
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

@end

NS_ASSUME_NONNULL_END
