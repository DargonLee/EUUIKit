//
//  EUTextView.m
//  TextFieldView
//
//  Created by Harlans on 2019/4/30.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUTextView.h"
#import "EUUICore.h"


@interface EUTextView ()

@property(nonatomic, weak)UILabel *placeHolderLabel;

@end

@implementation EUTextView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.alwaysBounceVertical = YES;
        self.font = [UIFont systemFontOfSize:15];
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1;
        self.maximumTextLength = NSUIntegerMax;
        
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIColorPlaceholder;
        [self addSubview:label];
        self.placeHolderLabel = label;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textDidChange
{
    self.placeHolderLabel.hidden = self.hasText;
    
    if (self.text.length > self.maximumTextLength) {
        UITextRange *markedRange = [self markedTextRange];
        if (markedRange) {return;}
        NSRange range = [self.text rangeOfComposedCharacterSequenceAtIndex:self.maximumTextLength];
        self.text = [self.text substringToIndex:range.location];
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeHolderLabel.text = placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeHolderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHolderLabel.font = font;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:self.placeholder];
    [attribute addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, self.placeholder.length)];
    CGRect rect = [attribute boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    self.placeHolderLabel.frame = CGRectMake(5, 7, self.bounds.size.width, rect.size.height);
}

@end
