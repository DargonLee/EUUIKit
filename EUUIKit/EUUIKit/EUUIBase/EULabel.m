//
//  EULabel.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/20.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EULabel.h"
#import "UIView+EUUI.h"
#import "EUUICore.h"

@interface EULabel ()

@property (nonatomic, strong) UIColor *originalBackgroundColor;

@property (nonatomic, strong) UILongPressGestureRecognizer *longGes;

@end

@implementation EULabel

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)lableWithString:(NSString *)string
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3.5; // 设置行间距
    paragraphStyle.alignment = NSTextAlignmentLeft; //设置两端对齐显示
    paragraphStyle.minimumLineHeight = 10;
    paragraphStyle.maximumLineHeight = 20;
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    EULabel *lineSpaceLabel = [[self alloc]init];
    lineSpaceLabel.numberOfLines = 0;
    lineSpaceLabel.attributedText = attributedString;
    return lineSpaceLabel;
}

- (void)setHighlightedBackgroundColor:(UIColor *)highlightedBackgroundColor
{
    _highlightedBackgroundColor = highlightedBackgroundColor;
    if (highlightedBackgroundColor) {
        self.originalBackgroundColor = self.backgroundColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (self.highlightedBackgroundColor) {
        self.backgroundColor = highlighted? self.highlightedBackgroundColor : self.originalBackgroundColor;
    }
}

- (void)setCanPerformCopyAction:(BOOL)canPerformCopyAction
{
    _canPerformCopyAction = canPerformCopyAction;
    if (_canPerformCopyAction) {
        self.userInteractionEnabled = YES;
        self.longGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPressGestureRecognizer:)];
        [self addGestureRecognizer:self.longGes];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMenuWillHideNotification:) name:UIMenuControllerWillHideMenuNotification object:nil];
        if (!self.highlightedBackgroundColor) {
            self.highlightedBackgroundColor = TableViewCellSelectedBackgroundColor;
        }
    }else {
        [self removeGestureRecognizer:self.longGes];
        self.longGes = nil;
        self.userInteractionEnabled = NO;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return self.canPerformCopyAction;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([self canBecomeFirstResponder]) {
        return  action == @selector(copyString:);
    }
    return NO;
}

- (void)handleLongPressGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (!self.canPerformCopyAction) { return; }
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        UIMenuController *menuVC = [UIMenuController sharedMenuController];
        UIMenuItem *copyItem = [[UIMenuItem alloc]initWithTitle:self.titleForCopyAction?: @"复制" action:@selector(copyString:)];
        [[UIMenuController sharedMenuController] setMenuItems:@[copyItem]];
        [menuVC setTargetRect:self.frame inView:self.superview];
        [menuVC setMenuVisible:YES animated:YES];
        [self setHighlighted:YES];
    }else if (gestureRecognizer.state == UIGestureRecognizerStatePossible) {
        [self setHighlighted:NO];
    }
}

- (void)handleMenuWillHideNotification:(NSNotification *)notification {
    if (!self.canPerformCopyAction) {
        return;
    }
    [self setHighlighted:NO];
}

- (void)copyString:(id)sender
{
    if (self.canPerformCopyAction) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        NSString *stringToCopy = self.text;
        if (stringToCopy) {
            pasteboard.string = stringToCopy;
            if (self.didCopyBlock) {
                self.didCopyBlock(self, stringToCopy);
            }
        }
    }
}

#pragma mark---------------------------Public--------------------------------

- (CGRect)labelTextRect
{
    NSDictionary *dic = @{
                           NSFontAttributeName : self.font
                           };
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect;
}

- (CGFloat)labelTextHeight
{
    return [self labelTextRect].size.height + 3;
}

- (void)sizeToFitLabel
{
    self.height = [self sizeThatFits:CGSizeMake(self.width, MAXFLOAT)].height;
}

@end
