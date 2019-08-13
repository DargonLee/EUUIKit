//
//  QRCodeTool.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/28.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "QRCodeTool.h"
#import <CoreImage/CoreImage.h>


@implementation QRCodeTool

+ (UIImage *)generatorQRCodeWithString:(NSString *)string
{
    return [self generatorQRCodeWithString:string r:0 g:0 b:0 alpha:1.0];
}

+ (UIImage *)generatorQRCodeWithString:(NSString *)string r:(NSUInteger)r g:(NSUInteger)g b:(NSUInteger)b alpha:(CGFloat)alpha
{
    UIImage *resultImage = nil;

    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];
    CIImage *ciImage = [filter outputImage];
    //5.设置二维码的前景色和背景颜色
    CIFilter *colorFilter=[CIFilter filterWithName:@"CIFalseColor"];
    //5.1设置默认值
    [colorFilter setDefaults];
    [colorFilter setValue:ciImage forKey:@"inputImage"];
    //当前颜色
    [colorFilter setValue:[CIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha] forKey:@"inputColor0"];
    //[colorFilter setValue:[CIColor colorWithCGColor:[UIColor yellowColor].CGColor] forKey:@"inputColor0"];
    //背景颜色
    [colorFilter setValue:[CIColor colorWithRed:1.0f green:1.0 blue:1.0f alpha:1.0] forKey:@"inputColor1"];
    //5.3获取生存的图片
    ciImage = colorFilter.outputImage;
    
    ciImage = [ciImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    resultImage = [UIImage imageWithCIImage:ciImage];
    
    return resultImage;
}

+ (UIImage *)generatorQRCodeWithString:(NSString *)string centerImage:(UIImage *)image
{
    UIImage *resultImage = nil;
    UIImage *sourceImage = [self generatorQRCodeWithString:string];
    resultImage = [self getNewImageWithSourceImage:sourceImage centerImage:image];
    return resultImage;
}

+ (UIImage *)generatorQRCodeWithString:(NSString *)string centerImage:(UIImage *)image r:(NSUInteger)r g:(NSUInteger)g b:(NSUInteger)b alpha:(CGFloat)alpha;
{
    UIImage *resultImage = nil;
    UIImage *sourceImage = [self generatorQRCodeWithString:string r:r g:g b:b alpha:alpha];
    resultImage = [self getNewImageWithSourceImage:sourceImage centerImage:image];
    return resultImage;
}

+ (UIImage *)getNewImageWithSourceImage:(UIImage *)source centerImage:(UIImage *)center
{
    UIImage *resultImage = nil;
    CGSize size = source.size;
    UIGraphicsBeginImageContext(size);
    [source drawInRect:CGRectMake(0, 0, size.width, size.height)];
    CGFloat wh = 80;
    CGFloat x = (size.width - wh) * 0.5;
    CGFloat y = (size.height - wh) * 0.5;
    [center drawInRect:CGRectMake(x, y, wh, wh)];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (CIImage *)changCIImageColorWithR:(NSUInteger)r g:(NSUInteger)g b:(NSUInteger)b
{
    CIImage *ciImage = nil;
    //5.设置二维码的前景色和背景颜色
    CIFilter *colorFilter=[CIFilter filterWithName:@"CIFalseColor"];
    //5.1设置默认值
    [colorFilter setDefaults];
    [colorFilter setValue:ciImage forKey:@"inputImage"];
    //当前颜色
    [colorFilter setValue:[CIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1] forKey:@"inputColor0"];
    //背景颜色
    [colorFilter setValue:[CIColor colorWithRed:1.0f green:1.0 blue:1.0f alpha:1.0] forKey:@"inputColor1"];
    //5.3获取生存的图片
    ciImage = colorFilter.outputImage;
    return ciImage;
}


+ (NSMutableArray *)changeUIColorToRGB:(UIColor *)color
{
    @autoreleasepool {
        NSMutableArray *RGBStrValueArr = [[NSMutableArray alloc] init];
        NSString *RGBStr = nil;
        //获得RGB值描述
        NSString *RGBValue = [NSString stringWithFormat:@"%@",color];
        //将RGB值描述分隔成字符串
        NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
        //获取红色值
        NSUInteger r = [[RGBArr objectAtIndex:0] integerValue] * 255;
        RGBStr = [NSString stringWithFormat:@"%lu",(unsigned long)r];
        [RGBStrValueArr addObject:RGBStr];
        //获取绿色值
        NSUInteger g = [[RGBArr objectAtIndex:1] integerValue] * 255;
        RGBStr = [NSString stringWithFormat:@"%lu",(unsigned long)g];
        [RGBStrValueArr addObject:RGBStr];
        //获取蓝色值
        NSUInteger b = [[RGBArr objectAtIndex:2] integerValue] * 255;
        RGBStr = [NSString stringWithFormat:@"%lu",(unsigned long)b];
        [RGBStrValueArr addObject:RGBStr];
        //返回保存RGB值的数组
        return RGBStrValueArr;
    }
}

+ (NSArray <NSString *>*)detectorQRCodeWithQRCodeImage:(UIImage *)sourceImage
{
    NSMutableArray *resultArray = [NSMutableArray array];
    CIImage *ciImage = [[CIImage alloc]initWithImage:sourceImage];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:ciImage];
    for (CIQRCodeFeature *feature in features) {
        [resultArray addObject:feature.messageString];
    }
    return resultArray;
}

+ (NSString *)detectorQRCodeWithSingleQRCodeImage:(UIImage *)sourceImage
{
    return [[self detectorQRCodeWithQRCodeImage:sourceImage] firstObject];
}

@end
