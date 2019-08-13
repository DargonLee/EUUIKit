//
//  EUTextField.h
//  TextFieldView
//
//  Created by Harlans on 2019/4/30.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+EUFD.h"

NS_ASSUME_NONNULL_BEGIN
@class EUTextField;
@protocol EUTextFieldDelegate <NSObject>

@optional

/**
 开始编辑的时候的代理方法（UITextField获取焦点）

 @param textfield UITextField
 */
- (void)textFieldTextDidBeginEditing:(UITextField *)textfield;

/**
 结束编辑的时候的代理方法（UITextField失去焦点）
 
 @param textfield UITextField
 */
- (void)textFieldTextDidEndEditing:(UITextField *)textfield;

/**
 文本改变的时候的代理方法
 
 @param textfield UITextField
 */
- (void)textFieldTextDidChange:(UITextField *)textfield;

/**
 正则验证成功的代理方法
 
 @param textfield UITextField
 */
- (void)textFieldTextValidateRegexSuccess:(UITextField *)textfield;

/**
 正则验证失败的代理方法
 
 @param textfield UITextField
 */
- (void)textFieldTextValidateRegexFailure:(UITextField *)textfield;

@end

@interface EUTextField : UITextField

/**
 代理属性
 */
@property (nonatomic, weak) id <EUTextFieldDelegate> eudelegate;

/**
 输入框最大字符限制
 */
@property (nonatomic, assign) IBInspectable NSUInteger maximumTextLength;

/**
 正则公式字符
 */
@property (nonatomic, copy) IBInspectable NSString *regexString;

/**
 placeholder颜色设置
 */
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

/**
 文字在输入框内的 padding
 */
@property (nonatomic, assign) UIEdgeInsets textInsets;

/**
 验证正则

 @return 返回 验证结果
 */
- (BOOL)doValidateRegex;


@end

NS_ASSUME_NONNULL_END
