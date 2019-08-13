//
//  QRCoceScanTool.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/29.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "QRCodeScanTool.h"
#import <AVFoundation/AVFoundation.h>

@interface QRCodeScanTool () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession * session;

@property (nonatomic, strong) AVCaptureDeviceInput *input;

@property (nonatomic, strong) AVCaptureMetadataOutput *output;

@property (nonatomic, strong) AVCaptureDevice *device;

/**
 扫描中心识别区域范围
 */
@property (nonatomic, assign) CGRect scanFrame;

/**
 展示输出流的视图——即照相机镜头下的内容
 */
@property (nonatomic, strong) UIView *preview;

@end

@implementation QRCodeScanTool

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (instancetype)initWithPreView:(UIView *)preView scanFrame:(CGRect)frame
{
    if (self == [super init]) {
        self.preview = preView;
        self.scanFrame = frame;
        [self initialized];
    }
    return self;
}

- (void)initialized
{
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.preview.layer.bounds;
    [self.preview.layer insertSublayer:layer atIndex:0];
    [self.session startRunning];
}

- (void)setFlash:(BOOL)flash
{
    _flash = flash;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash]) {
        [device lockForConfiguration:nil];
        if (flash) {
            device.torchMode = AVCaptureTorchModeOn;
            device.flashMode = AVCaptureTorchModeOn;
        }else {
            device.torchMode = AVCaptureTorchModeOff;
            device.flashMode = AVCaptureTorchModeOff;
        }
        [device unlockForConfiguration];
    }
}

- (void)startScaning
{
    [self.session startRunning];
}

- (void)stopScaning
{
    [self.session stopRunning];
}

- (AVCaptureSession *)session
{
    if (_session == nil) {
        //获取摄像设备
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        //创建输入流
        _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
        //创建二维码扫描输出流
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //设置采集扫描区域的比例 默认全屏是（0，0，1，1）
        //rectOfInterest 填写的是一个比例，输出流视图preview.frame为 x , y, w, h, 要设置的矩形快的scanFrame 为 x1, y1, w1, h1. 那么rectOfInterest 应该设置为 CGRectMake(y1/y, x1/x, h1/h, w1/w)。
        CGFloat x = CGRectGetMinX(self.scanFrame)/ CGRectGetWidth(self.preview.frame);
        CGFloat y = CGRectGetMinY(self.scanFrame)/ CGRectGetHeight(self.preview.frame);
        CGFloat width = CGRectGetWidth(self.scanFrame)/ CGRectGetWidth(self.preview.frame);
        CGFloat height = CGRectGetHeight(self.scanFrame)/ CGRectGetHeight(self.preview.frame);
        _output.rectOfInterest = CGRectMake(y, x, height, width);
        
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:_input] && [_session canAddOutput:_output]) {
            [_session addInput:_input];
            [_session addOutput:_output];
        }
        
        //设置扫码支持的编码格式(这里设置条形码和二维码兼容)
        _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                       AVMetadataObjectTypeEAN13Code,
                                       AVMetadataObjectTypeEAN8Code,
                                       AVMetadataObjectTypeCode128Code];
    }
    return _session;
}

#pragma mark -- AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *meta = [metadataObjects firstObject];
        if (self.scanCompleted != nil) {
            self.scanCompleted(meta.stringValue);
            NSLog(@"%@",meta.stringValue);
        }
    }
}


@end
