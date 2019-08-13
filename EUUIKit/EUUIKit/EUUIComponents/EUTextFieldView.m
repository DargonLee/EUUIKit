//
//  EUTextFieldView.m
//  TextFieldView
//
//  Created by Harlans on 2019/4/30.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUTextFieldView.h"
#import "EUTextField.h"
#import "UIView+EUUI.h"
#import "NSString+EUFD.h"

#define kLineHeight 1
#define kPadding 5

@interface EUTextFieldView()<EUTextFieldDelegate>

@property (nonatomic, weak) UIView *lineView;

@property (nonatomic, weak) UIImageView *icon;

@property (nonatomic, weak) EUTextField *textField;

@property (nonatomic, assign) CGFloat lineViewMargin;

@property (nonatomic, strong) EUValidator *validator;

@property (nonatomic, weak) UIButton *verifiCodeButton;

@property (nonatomic) NSInteger timeCount;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation EUTextFieldView

- (instancetype)initWithTextFieldType:(EUTextFieldViewType)type
{
    if (self == [super init]) {
        [self setupUI:type];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame textFieldType:(EUTextFieldViewType)type
{
    if (self == [super initWithFrame:frame]) {
        [self setupUI:type];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        [self setupUI:self.fieldType];
    }
    return  self;
}

- (void)setupUI:(EUTextFieldViewType)type
{

    self.lineViewMargin = 5;
    UIColor *defaultColor = [UIColor colorWithRed:222/255.0 green:224/255.0 blue:226/255.0 alpha:1];
    self.focusBottomLineColor = defaultColor;
    self.bottomLineColor = defaultColor;
    self.regexSuccessBottomLineColor = defaultColor;
    self.regexFailureBottomLineColor = defaultColor;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = defaultColor;
    [self addSubview:lineView];
    self.lineView = lineView;
    
    UIImageView *icon = [[UIImageView alloc]init];
    icon.backgroundColor = [UIColor redColor];
    [self addSubview:icon];
    self.icon = icon;
    
    EUTextField *textField = [[EUTextField alloc]init];
    textField.tintColor = [UIColor orangeColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    EUValidator *validator = [[EUValidator alloc]initWithTextFieldViewType:type];
    textField.keyboardType = validator.keyboardType;
    textField.maximumTextLength = validator.maximumTextLength;
    textField.regexString = validator.regex;
    textField.eudelegate = self;
    [self addSubview:textField];
    self.textField = textField;
    self.validator = validator;
    
    if (type == EUTextFieldViewTypeVerifiCode) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(codeBtnVerification:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"点击获取" forState:UIControlStateNormal];
        [self addSubview:btn];
        self.verifiCodeButton = btn;
    }

}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.icon.image = [UIImage imageNamed:self.iconName];
}

- (void)setIconName:(NSString *)iconName
{
    _iconName = iconName;
    self.icon.image = [UIImage imageNamed:self.iconName];
}

- (void)setFocusIconName:(NSString *)focusIconName
{
    _focusIconName = focusIconName;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat iconHeight = self.height - self.lineViewMargin;
    self.icon.frame = CGRectMake(kPadding, 0, iconHeight, iconHeight);
    self.textField.frame = CGRectMake(self.icon.right+kPadding, 0, self.width - self.icon.width - 3*kPadding, iconHeight);
    self.lineView.frame = CGRectMake(0, self.height - kLineHeight, self.width, kLineHeight);
    self.verifiCodeButton.frame = CGRectMake(self.width - 85, 0, 80, iconHeight);
}


- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.textField.placeholderColor = placeholderColor;
}

#pragma mark---------------------------Method处理--------------------------------
- (void)codeBtnVerification:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    self.timeCount = 59;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    if ([self.actionDelegate respondsToSelector:@selector(textFieldViewVerificodeClick:)]) {
        [self.actionDelegate textFieldViewVerificodeClick:self];
    }
}

- (void)timeFireMethod
{
    if (self.timeCount <= 0) {
        self.verifiCodeButton.userInteractionEnabled = YES;
        [self.verifiCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
    } else {
        self.verifiCodeButton.userInteractionEnabled = NO;
        [self.verifiCodeButton setTitle:[NSString stringWithFormat:@"%ld秒后重发",self.timeCount] forState:UIControlStateNormal];
    }
    
    self.timeCount--;
}

- (NSString *)doValidateRegex
{
    if ([self.textField doValidateRegex]) {
        return nil;
    }
    return self.validator.msg;
}

#pragma mark---------------------------EUTextFieldDelegate处理--------------------------------
- (void)textFieldTextValidateRegexSuccess:(UITextField *)textfield
{
    self.lineView.backgroundColor = self.regexSuccessBottomLineColor;
}

- (void)textFieldTextValidateRegexFailure:(UITextField *)textfield
{
    self.lineView.backgroundColor = self.regexFailureBottomLineColor;
}

- (void)textFieldTextDidBeginEditing:(UITextField *)textfield
{
    self.lineView.backgroundColor = self.focusBottomLineColor;
    self.icon.image = [UIImage imageNamed:self.focusIconName?:self.iconName];
}

- (void)textFieldTextDidEndEditing:(UITextField *)textfield
{
    self.lineView.backgroundColor = self.bottomLineColor;
    self.icon.image = [UIImage imageNamed:self.iconName];
}


@end


@interface EUValidator()

@property (nonatomic, copy) NSString *regex;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSUInteger maximumTextLength;

@property (nonatomic, assign) UIKeyboardType keyboardType;

@end

@implementation EUValidator

- (instancetype)initWithTextFieldViewType:(EUTextFieldViewType)type
{
    if (self == [super init]) {
        [self buildValidatorWithType:type];
    }
    return self;
}

- (void)buildValidatorWithType:(EUTextFieldViewType)fieldType
{
    switch (fieldType) {
        case EUTextFieldViewTypeEmail:
        {
            self.regex = [NSString emailRegex];
            self.maximumTextLength = 100;
            self.keyboardType = UIKeyboardTypeEmailAddress;
            self.msg = @"Invalid email address";
        }
            break;
        case EUTextFieldViewTypePhone:
        {
            self.regex = [NSString phoneRegex];
            self.maximumTextLength = 11;
            self.keyboardType = UIKeyboardTypeNamePhonePad;
            self.msg = @"手机号不正确";
        }
            break;
        case EUTextFieldViewTypePassWord:
        {
            self.regex = [NSString passwordRegex];
            self.maximumTextLength = 16;
            self.keyboardType = UIKeyboardTypeEmailAddress;
            self.msg = @"密码为8-16位的数字和字母组合";
        }
            break;
        case EUTextFieldViewTypeUsername:
        {
            self.regex = [NSString usernameRegex];
            self.maximumTextLength = 20;
            self.keyboardType = UIKeyboardTypeEmailAddress;
            self.msg = @"请输入正确的姓名";
        }
            break;
        case EUTextFieldViewTypeVerifiCode:
        {
            self.regex = [NSString verificationCodeRegex];
            self.maximumTextLength = 6;
            self.keyboardType = UIKeyboardTypeNumberPad;
            self.msg = @"验证码错误";
        }
            break;
        default:
            break;
    }
}

@end

@implementation NSMutableArray (ValidateFieldView)

- (NSString *)doValidateFields
{
    for (EUTextFieldView *textField in self) {
        if ([textField isKindOfClass:[EUTextFieldView class]]) {
            NSString *msg =  [textField doValidateRegex];
            if (msg != nil) {
                return msg;
            }
        }
    }
    return nil;
}

@end
