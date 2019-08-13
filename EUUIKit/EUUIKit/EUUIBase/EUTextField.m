//
//  EUTextField.m
//  TextFieldView
//
//  Created by Harlans on 2019/4/30.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUTextField.h"

@implementation EUTextField

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self configTextField];
        [self addNotification];
    }
    return self;
}

- (instancetype)init
{
    if (self == [super init]) {
        [self configTextField];
        [self addNotification];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        [self configTextField];
        [self addNotification];
    }
    return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

#pragma mark---------------------------Methods处理--------------------------------
- (void)configTextField
{
    self.maximumTextLength = ULONG_MAX;
    self.textInsets = UIEdgeInsetsMake(0, 7, 0, 7);
    self.placeholderColor = [UIColor colorWithRed:196/255.0 green:200/255.0 blue:208/255.0 alpha:1];
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidBeginEditingNotification:) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidEndEditingNotification:) name:UITextFieldTextDidEndEditingNotification object:self];
    
}

- (void)textFieldTextDidChangeNotification:(NSNotification *)noti
{
    if (self != noti.object) { return; }
    //获取文本
    UITextField *textField = noti.object;
    NSString *currentText = textField.text;
    NSInteger maxLength = self.maximumTextLength;
    
    // 文本改变
    if ([self.eudelegate respondsToSelector:@selector(textFieldTextDidChange:)]) {
        [self.eudelegate textFieldTextDidChange:textField];
    }

    if (textField.text.length > maxLength) {
        UITextRange *markedRange = [textField markedTextRange];
        if (markedRange) {return;}
        NSRange range = [textField.text rangeOfComposedCharacterSequenceAtIndex:maxLength];
        textField.text = [textField.text substringToIndex:range.location];
    }
    
    //正则验证
    if ([self validateRegex:currentText]) {//验证通过
        if ([self.eudelegate respondsToSelector:@selector(textFieldTextValidateRegexSuccess:)]) {
            [self.eudelegate textFieldTextValidateRegexSuccess:textField];
        }
    }else { //验证失败
        if ([self.eudelegate respondsToSelector:@selector(textFieldTextValidateRegexFailure:)]) {
            [self.eudelegate textFieldTextValidateRegexFailure:textField];
        }
    }
}

- (void)textFieldTextDidBeginEditingNotification:(NSNotification *)noti
{
    UITextField *textField = noti.object;
    if ([self.eudelegate respondsToSelector:@selector(textFieldTextDidBeginEditing:)]) {
        [self.eudelegate textFieldTextDidBeginEditing:textField];
    }
}

- (void)textFieldTextDidEndEditingNotification:(NSNotification *)noti
{
    UITextField *textField = noti.object;
    if ([self.eudelegate respondsToSelector:@selector(textFieldTextDidEndEditing:)]) {
        [self.eudelegate textFieldTextDidEndEditing:textField];
    }
}

- (BOOL)validateRegex:(NSString *)text
{
    if (text == nil || text.length == 0) {
        return YES;
    }
    NSString *passWordRegex = self.regexString;
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:text];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (BOOL)doValidateRegex
{
    if (self.text.length == 0) {
        return NO;
    }else {
        return  [self validateRegex:self.text];
    }
    return NO;
}

#pragma mark - Positioning Overrides
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect tempBounds = bounds;
    tempBounds.origin.x += self.textInsets.left;
    tempBounds.origin.y += self.textInsets.top;
    tempBounds.size.width -= (self.textInsets.left + self.textInsets.right);
    tempBounds.size.height -= (self.textInsets.top + self.textInsets.bottom);
    return [super textRectForBounds:tempBounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect tempBounds = bounds;
    tempBounds.origin.x += self.textInsets.left;
    tempBounds.origin.y += self.textInsets.top;
    tempBounds.size.width -= (self.textInsets.left + self.textInsets.right);
    tempBounds.size.height -= (self.textInsets.top + self.textInsets.bottom);
    return [super editingRectForBounds:tempBounds];
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    CGRect result = [super clearButtonRectForBounds:bounds];
    result = CGRectOffset(result, 7, 0);
    return result;
}


@end
