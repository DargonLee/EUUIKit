//
//  EUNormalProgress.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/15.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class EUNormalProgress;
@protocol EUNormalProgressDelegate <NSObject>

@optional
- (void)normalProgressDidDone:(EUNormalProgress *)progressView;

@end

@interface EUNormalProgress : UIView

/**
 边框宽度
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/**
 内边距
 */
@property (nonatomic, assign) IBInspectable UIEdgeInsets padding;

/**
 填充颜色 默认值RGBA(33, 178, 123, 1)）注意：在下载完成的代理方法中 设置该属性无效
 */
@property (strong, nonatomic) IBInspectable UIColor *fillColor;

/**
 边框颜色 默认值RGBA(33, 178, 123, 1)
 */
@property (nonatomic, strong) UIColor *borderColor;

/**
 进度值
 */
@property (assign, nonatomic) CGFloat progress;


@property (nonatomic, assign) id  delegate;


@end

NS_ASSUME_NONNULL_END
