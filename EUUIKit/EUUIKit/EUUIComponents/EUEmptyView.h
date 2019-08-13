//
//  EUEmptyView.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/21.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EUEmptyView : UIView

/**
 主标题 字体颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *textLabelColor;

/**
 副标题 字体颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *detailLabelColor;

/**
 点击重新加载按钮的回调
 */
@property (nonatomic, copy) void(^didClcikReloadAction)(EUEmptyView *view, UIButton *clickButton);


/**
 显示或者隐藏Loading图标

 @param hidden 显示隐藏
 */
- (void)setLoadingViewHide:(BOOL)hidden;

/**
 设置显示的图片

 @param image 图片
 */
- (void)setImage:(UIImage *)image;

/**
 设置提示文本

 @param text 文本内容
 */
- (void)setTextLabelText:(NSString *)text;

/**
 设置详情提示文本

 @param text 文本内容
 */
- (void)setDetailTextLabelText:(NSString *)text;

/**
 设置按钮 文本

 @param title 文本 为 nil 的时候不显示 button
 */
- (void)setActionButtonTitle:(NSString *)title;



@end

NS_ASSUME_NONNULL_END
