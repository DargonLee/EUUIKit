//
//  UIView+EUUI.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/13.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^EUGestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);
@interface UIView (EUUI)

/**
 快加载xib

 @return view对象
 */
+ (instancetype )loadNibView;

/**
 截图

 @return 截取好的图片
 */
- (UIImage *)screenshot;

/**
 截图

 @param maxWidth 图片最大宽度
 @return 截取好的图片
 */
- (UIImage *)screenshot:(CGFloat)maxWidth;

/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)addTapActionWithBlock:(EUGestureActionBlock)block;

/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)addLongPressActionWithBlock:(EUGestureActionBlock)block;

@end

/************************************** EUUI_Layout *************************************************/
@interface UIView (EUUI_Layout)


/**
 *  起点x坐标
 */
@property (nonatomic, assign) CGFloat x;
/**
 *  起点y坐标
 */
@property (nonatomic, assign) CGFloat y;
/**
 *  中心点x坐标
 */
@property (nonatomic, assign) CGFloat centerX;
/**
 *  中心点y坐标
 */
@property (nonatomic, assign) CGFloat centerY;
/**
 *  宽度
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  高度
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  顶部
 */
@property (nonatomic, assign) CGFloat top;
/**
 *  底部
 */
@property (nonatomic, assign) CGFloat bottom;
/**
 *  左边
 */
@property (nonatomic, assign) CGFloat left;
/**
 *  右边
 */
@property (nonatomic, assign) CGFloat right;
/**
 *  size
 */
@property (nonatomic, assign) CGSize size;
/**
 *  起点坐标
 */
@property (nonatomic, assign) CGPoint origin;


/**
 设置当前view的 高度 和传进来的view的高度一致

 @param view 传进来的view
 */
- (void)heightEqualToView:(UIView *)view;

/**
 设置当前view的 宽度 和传进来的view的高度一致
 
 @param view 传进来的view
 */
- (void)widthEqualToView:(UIView *)view;

/**
 设置当前view的 size 和传进来的view的高度一致
 
 @param view 传进来的view
 */
- (void)sizeEqualToView:(UIView *)view;

/**
 设置当前view的 centerX 和传进来的view的高度一致
 
 @param view 传进来的view
 */
- (void)centerXEqualToView:(UIView *)view;

/**
 设置当前view的 centerY和传进来的view的高度一致
 
 @param view 传进来的view
 */
- (void)centerYEqualToView:(UIView *)view;

/**
 设置当前view的 center 和传进来的view的高度一致
 
 @param view 传进来的view
 */
- (void)centerEqualToView:(UIView *)view;

/**
 设置当前view的 MinY 和传进来的view的高度一致
 
 @param view 传进来的view
 */
- (void)topEqualToView:(UIView *)view;

/**
 设置当前view的 MaxY 和传进来的view的高度一致
 
 @param view 传进来的view
 */
- (void)bottomEqualToView:(UIView *)view;

/**
 设置当前view的 MinX 和传进来的view的高度一致
 
 @param view 传进来的view
 */
- (void)leftEqualToView:(UIView *)view;

/**
 设置当前view的 MaxX 和传进来的view的高度一致
 
 @param view 传进来的view
 */
- (void)rightEqualToView:(UIView *)view;

/**
 跟父view中心一致
 */
- (void)autoCenterInSuperview;

/**
 设置跟父view大小位置一直
 */
- (void)autoFillInSuperview;

/**
 设置当前view的宽高

 @param size CGSize
 */
- (void)autoSetDimensionsToSize:(CGSize)size;

/**
 设置距离父View的左间距
 */
- (void)autoPinEdgeLeftInSuperviewWithOffset:(CGFloat)offset;

/**
 设置距离父View的右间距
 */
- (void)autoPinEdgeRightInSuperviewWithOffset:(CGFloat)offset;

/**
 设置距离父View的上间距
 */
- (void)autoPinEdgeTopInSuperviewWithOffset:(CGFloat)offset;

/**
 设置距离父View的下间距
 */
- (void)autoPinEdgeBottomInSuperviewWithOffset:(CGFloat)offset;


@end

// TODO
@interface UIView (EUUI_Badge)

@end

NS_ASSUME_NONNULL_END
