//
//  EUInstallProgress.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/15.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class EUInstallProgress;
@protocol EUInstallProgressDelegate <NSObject>

@optional
- (void)installProgressDidDone:(EUInstallProgress *)progressView;

@end

@interface EUInstallProgress : UIButton

/**
 填充颜色 默认值RGBA(33, 178, 123, 1)）注意：在下载完成的代理方法中 设置该属性无效
 */
@property (strong, nonatomic) IBInspectable UIColor *fillColor;

/**
 进度值
 */
@property (assign, nonatomic) CGFloat progress;

/**
 事件代理
 */
@property (nonatomic, weak) id <EUInstallProgressDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
