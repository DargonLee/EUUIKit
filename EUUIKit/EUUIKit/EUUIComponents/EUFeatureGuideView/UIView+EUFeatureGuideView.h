//
//  UIView+EUFeatureGuideView.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/22.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUFeatureItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (EUFeatureGuideView)

/**
 *  展示提示页面
 *
 *  @param featureItems 需要展示的UI元素
 *  @param keyName 提示的标识
 *  @param version 提示应该在什么版本出现版本
 */
- (void)showWithFeatureItems:(NSArray<EUFeatureItem *> *)featureItems saveKeyName:(NSString *)keyName inVersion:(NSString *_Nullable)version;

/**
 *  是否已经展示过提示了
 *
 *  @param keyName 提示的标识
 *  @param version 提示应该在什么版本出现版本
 *
 *  @return BOOL
 */
+ (BOOL)hasShowFeatureGuideWithKey:(NSString *)keyName version:(NSString *)version;

/**
 *  关闭提示页面
 */
- (void)dismissFeatureGuideView;

@end

NS_ASSUME_NONNULL_END
