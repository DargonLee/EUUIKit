//
//  UIImageView+EUUI.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/22.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "UIImageView+EUUI.h"

@implementation UIImageView (EUUI)

+ (instancetype)imageViewWithImageArray:(NSArray *)imageArray duration:(NSTimeInterval)duration
{
    if (imageArray && !([imageArray count]>0))
    {
        return nil;
    }
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[imageArray firstObject]];
    NSMutableArray *images = [NSMutableArray array];
    for (NSInteger i = 0; i < imageArray.count; i++)
    {
        UIImage *image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [images addObject:image];
    }
    [imageView setImage:[images objectAtIndex:0]];
    [imageView setAnimationImages:images];
    [imageView setAnimationDuration:duration];
    [imageView setAnimationRepeatCount:0];
    return imageView;
}

- (void)maskCornerRadius:(CGFloat)radius
{
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    CGContextAddPath(currnetContext, [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius].CGPath);
    CGContextClip(currnetContext);
    [self.layer renderInContext:currnetContext];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = image;
}

- (void)drawOrignImageWithString:(NSString *)string atPoint:(CGPoint)point
{
    UIImage *newImage = [self drawOrignImage:self.image waterMaskString:string atPoint:point textColor:[UIColor blackColor] textFont:[UIFont systemFontOfSize:15]];
    self.image = newImage;
}

- (UIImage *)drawOrignImage:(UIImage *)image waterMaskString:(NSString *)string atPoint:(CGPoint)point textColor:(UIColor *)color textFont:(UIFont *)font
{
    return [self drawOrignImage:image waterMaskString:string atPoint:point attributedString:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color}];
}

- (UIImage *)drawOrignImage:(UIImage *)image waterMaskString:(NSString *)string atPoint:(CGPoint)point attributedString:(nullable NSDictionary<NSString *,id> *)attributed
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
    {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
    //原图
    [image drawInRect:self.bounds];
    if ([string respondsToSelector:@selector(drawAtPoint:withAttributes:)])
    {
        [string drawAtPoint:point withAttributes:attributed];
    }
    else
    {
        // pre-iOS7.0
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [string drawAtPoint:point withFont:attributed[NSFontAttributeName]];
#pragma clang diagnostic pop
    }
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}

- (void)drawWaterMark:(UIImage *)waterMark inRect:(CGRect)rect
{
    UIImage *newImage = [self drawOrignImage:self.image waterMark:waterMark inRect:rect];
    self.image = newImage;
}

- (UIImage *)drawOrignImage:(UIImage *)image waterMark:(UIImage *)waterMark inRect:(CGRect)rect
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [waterMark drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
