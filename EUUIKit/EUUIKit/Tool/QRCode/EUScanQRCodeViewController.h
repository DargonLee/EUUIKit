//
//  EUScanQRCodeViewController.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/29.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^QRCodeScanCompletedBlock)(NSString * _Nullable messageString);
typedef void (^QRCodeScanMultiCompletedBlock)(NSArray <NSString *>* _Nullable messages);
NS_ASSUME_NONNULL_BEGIN

@interface EUScanQRCodeViewController : UIViewController

/**
 边框的图片
 */
@property (nonatomic, strong) UIImage *borderImage;

/**
 做动画的图片
 */
@property (nonatomic, strong) UIImage *animateImage;

/**
 散光灯按钮图片
 */
@property (nonatomic, strong) UIImage *flashImage;

/**
 扫描成功的回调（默认调用一个）
 */
@property (nonatomic, copy) QRCodeScanCompletedBlock scanCompleted;

/**
 扫描成功的回调(多个二维码)
 */
@property (nonatomic, copy) QRCodeScanMultiCompletedBlock scanMultiCompleted;

/**
 是否显示相册按钮
 */
@property (nonatomic, assign) BOOL showPhotoLibaryItem;

/**
 是否开启闪光灯按钮
 */
@property (nonatomic, assign) BOOL showFlashButton;

/**
 设置是否需要描绘二维码边框(默认为NO 如果开启后 会自动扫描多个二维码 需要手动触发Done 才调用 scanMultiCompleted)
 */
@property (nonatomic, assign) BOOL isDrawQRCodeRect;


@end

NS_ASSUME_NONNULL_END
