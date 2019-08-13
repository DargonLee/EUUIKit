//
//  NSMutableParagraphStyle+EUUI.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/13.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "NSMutableParagraphStyle+EUUI.h"

@implementation NSMutableParagraphStyle (EUUI)

+ (instancetype)paragraphStyleWithLineHeight:(CGFloat)lineHeight
{
    return [self paragraphStyleWithLineHeight:lineHeight lineBreakMode:NSLineBreakByWordWrapping textAlignment:NSTextAlignmentLeft];
}

+ (instancetype)paragraphStyleWithLineSpaceing:(CGFloat)lineSpaceing
{
    return [self paragraphStyleWithLineSpaceing:lineSpaceing paragraphSpacing:5];
}

+ (instancetype)paragraphStyleWithParagraphSpacing:(CGFloat)paragraphSpacing
{
    return [self paragraphStyleWithLineSpaceing:5 paragraphSpacing:paragraphSpacing];
}

+ (instancetype)paragraphStyleWithLineHeight:(CGFloat)lineHeight lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment)textAlign
{
    NSMutableParagraphStyle *s = [[NSMutableParagraphStyle alloc]init];
    s.minimumLineHeight = lineHeight;
    s.maximumLineHeight = lineHeight;
    s.lineBreakMode = lineBreakMode;
    s.alignment = textAlign;
    return s;
}

+ (instancetype)paragraphStyleWithLineSpaceing:(CGFloat)lineSpaceing paragraphSpacing:(CGFloat)paragraphSpacing
{
    NSMutableParagraphStyle *s = [[NSMutableParagraphStyle alloc]init];
    s.lineSpacing = lineSpaceing;
    s.paragraphSpacing = paragraphSpacing;
    return s;
}

@end
