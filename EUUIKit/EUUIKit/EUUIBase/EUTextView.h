//
//  EUTextView.h
//  TextFieldView
//
//  Created by Harlans on 2019/4/30.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EUTextView : UITextView

/**
 placeholder
 */
@property (nonatomic, copy) NSString * placeholder;

/**
 placeholder颜色 默认是灰色的
 */
@property (nonatomic, strong) UIColor * placeholderColor;

/**
 显示允许输入的最大文字长度 默认为 NSUIntegerMax
 */
@property(nonatomic, assign) IBInspectable NSUInteger maximumTextLength;


@end

NS_ASSUME_NONNULL_END
