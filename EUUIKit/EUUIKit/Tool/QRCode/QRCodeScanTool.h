//
//  QRCoceScanTool.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/29.
//  Copyright © 2019 Harlans. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^QRCodeScanCompletedBlock)(NSString * messageString);

@interface QRCodeScanTool : NSObject

/**
 扫描完成的回调
 */
@property (nonatomic, copy) QRCodeScanCompletedBlock scanCompleted;

/**
 是否开启散光灯
 */
@property (nonatomic, assign) BOOL flash;

/**
 初始化方法

 @param preView 展示输出流的视图
 @param frame 扫描中心识别区域范围
 @return 实例对象
 */
- (instancetype)initWithPreView:(UIView *)preView scanFrame:(CGRect)frame;

/**
 开始扫描
 */
- (void)startScaning;

/**
 停止扫描
 */
- (void)stopScaning;

@end

NS_ASSUME_NONNULL_END
