//
//  EULoadingView.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/17.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EULoadingView : UIView

/**
 CGColor 数组
 */
@property (nonatomic, strong) NSArray *colors;

/**
 线宽。默认值为2
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 Loading 图片的名字
 */
@property (nonatomic, copy) NSString *logoImageName;


@end

NS_ASSUME_NONNULL_END
