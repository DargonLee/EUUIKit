//
//  EUTextFieldView.h
//  TextFieldView
//
//  Created by Harlans on 2019/4/30.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EUTextFieldViewType){
    /**
     密码类型
     */
    EUTextFieldViewTypePassWord,
    /**
     邮箱类型
     */
    EUTextFieldViewTypeEmail,
    /**
     用户名类型
     */
    EUTextFieldViewTypeUsername,
    /**
     手机号类型
     */
    EUTextFieldViewTypePhone,
    /**
     验证码类型
     */
    EUTextFieldViewTypeVerifiCode,
    /**
     正常类型
     */
    EUTextFieldViewTypeNormal
};


@class EUTextFieldView;
@protocol EUTextFieldViewDelegate <NSObject>

@optional
/**
 点击获取验证码按钮的代理方法

 @param textView EUTextFieldView
 */
- (void)textFieldViewVerificodeClick:(EUTextFieldView *)textView;

@end




@interface EUTextFieldView : UIView

- (instancetype)initWithTextFieldType:(EUTextFieldViewType)type;

- (instancetype)initWithFrame:(CGRect)frame textFieldType:(EUTextFieldViewType)type;

@property (nonatomic, weak) id <EUTextFieldViewDelegate> actionDelegate;

/** 输入框类型
 0 -> 密码
 1 -> 邮箱
 2 -> 用户名
 3 -> 电话
 4 -> 验证码
 5 -> None
 */
@property (nonatomic, assign) IBInspectable NSInteger fieldType;

/**
 候选文字颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

/**
 左边 icon 图片的名字
 */
@property (nonatomic, strong) IBInspectable NSString *iconName;

/**
 获取焦点时 左边 icon 图片名字
 */
@property (nonatomic, strong) IBInspectable NSString *focusIconName;

/**
 输入框底部线条颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *bottomLineColor;

/**
 获取焦点 输入框底部线条颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *focusBottomLineColor;

/**
 验证正则成功 输入框底部线条颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *regexSuccessBottomLineColor;

/**
 验证正则失败 输入框底部线条颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *regexFailureBottomLineColor;


/**
 验证输入内容的正则是否正确

 @return 返回验证失败的提示信息 为nil的时候 说明验证成功
 */
- (NSString *)doValidateRegex;

@end




@interface EUValidator : NSObject

- (instancetype)initWithTextFieldViewType:(EUTextFieldViewType)type;

@property (nonatomic, copy, readonly) NSString *regex;

@property (nonatomic, copy, readonly) NSString *msg;

@property (nonatomic, assign, readonly) NSUInteger maximumTextLength;

@property (nonatomic, assign, readonly) UIKeyboardType keyboardType;


@end


@interface NSMutableArray (ValidateFieldView)

- (NSString *)doValidateFields;

@end

NS_ASSUME_NONNULL_END
