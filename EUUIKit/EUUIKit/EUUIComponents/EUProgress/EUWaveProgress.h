//
//  EUWaveProgress.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/15.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EUWaveProgress : UIView

/**
 进度值
 */
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) IBInspectable UIColor *fillColor;

@property (nonatomic, strong) UIColor *waveTopColor;

@property (nonatomic, strong) UIColor *waveBottomColor;

@end

NS_ASSUME_NONNULL_END
