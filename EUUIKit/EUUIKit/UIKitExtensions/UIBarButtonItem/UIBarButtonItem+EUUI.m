//
//  UIBarButtonItem+EUUI.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/23.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "UIBarButtonItem+EUUI.h"
#import "EUUICore.h"

@implementation UIBarButtonItem (EUUI)

+ (instancetype)itemWithImage:(NSString *)image target:(id)target action:(SEL)action
{
    return [self itemWithImage:image highImage:nil target:target action:action];
}

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    // 创建UIButton
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    
    // 把UIButton包装成UIBarButtonItem 有会按钮点击范围过大的问题
    // 解决这个问题
    UIView *containView = [[UIView alloc] initWithFrame:button.bounds];
    [containView addSubview:button];
    
    // 监听
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 返回
    return [[self alloc] initWithCustomView:containView];
}

+ (instancetype)itemWithText:(NSString *)text textColor:(UIColor *)color font:(CGFloat)font target:(id)target action:(SEL)action
{
    // 创建UIButton
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button sizeToFit];
    // 把UIButton包装成UIBarButtonItem 有会按钮点击范围过大的问题
    // 解决这个问题
    UIView *containView = [[UIView alloc] initWithFrame:button.bounds];
    [containView addSubview:button];
    // 监听
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 返回
    return [[self alloc] initWithCustomView:containView];
}

+ (instancetype)itemWithText:(NSString *)text target:(id)target action:(SEL)action
{
    return [self itemWithText:text textColor:FillButtonColorBlue font:15 target:target action:action];
}

@end
