//
//  EUCircleProgress.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/15.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class EUCircleProgress;
@protocol EUCircleProgressDelegate <NSObject>

/**
 下载完成后的代理通知
 */
@optional
- (void)circleProgressDidDone:(EUCircleProgress *)progressView;

@end

@interface EUCircleProgress : UIView

/**
 进度值
 */
@property (nonatomic, assign) CGFloat progress;

/**
 文字颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *textColor;

/**
 进度条颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *tintColor;

/**
 进度条底部圆圈颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *bottomTintColor;

/**
 进度条宽度
 */
@property (nonatomic, assign) IBInspectable CGFloat lineWidth;

/**
 改变文本内容 提示：只有在下载完成的时候更改才有效
 */
@property (nonatomic, copy) NSString *valueString;

/**
 事件代理
 */
@property (nonatomic, weak) id <EUCircleProgressDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
