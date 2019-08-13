//
//  EUScanQRCodeViewController.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/29.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUScanQRCodeViewController.h"
#import "QRCodeScanTool.h"
#import "UIView+EUUI.h"
#import "EUHelper.h"
#import <AVFoundation/AVFoundation.h>
#import "QRCodeTool.h"
#import "UIView+EUUI.h"
#import "EUUICore.h"



@interface EUScanQRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) UIImageView *borderImageView;

@property (nonatomic, weak) UIImageView *animateImageView;

@property (nonatomic, weak) UIButton *flashButton;

@property (nonatomic, weak) UIButton *doneButton;

@property (nonatomic, strong) AVCaptureSession * session;

@property (nonatomic, weak) AVCaptureMetadataOutput *output;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) NSMutableArray *deleteTempLayers;

@property (nonatomic, strong) NSMutableArray *resultStrs;

@end

@implementation EUScanQRCodeViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__func__);
}

- (NSMutableArray *)resultStrs
{
    if (!_resultStrs) {
        _resultStrs = [NSMutableArray array];
    }
    return _resultStrs;
}

- (NSMutableArray *)deleteTempLayers
{
    if (!_deleteTempLayers) {
        _deleteTempLayers = [NSMutableArray array];
    }
    return _deleteTempLayers;
}

- (void)setShowPhotoLibaryItem:(BOOL)showPhotoLibaryItem
{
    _showPhotoLibaryItem = showPhotoLibaryItem;
    if (showPhotoLibaryItem) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(openPhotoLibary)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self setupUI];
    
    if ([EUHelper isIPad]) {
        [self addNotification];
    }
    [self startAnimate];
    
    [self beginScan];
}

#pragma mark -- Config
- (void)setupUI
{
    UIImageView *borderImageView = [[UIImageView alloc]init];
    borderImageView.clipsToBounds = YES;
    borderImageView.image = self.borderImage;
    borderImageView.frame = CGRectMake((self.view.bounds.size.width - 250) * 0.5, (self.view.bounds.size.height - 250) * 0.5 - 50, 250, 250);
    [self.view addSubview:borderImageView];
    self.borderImageView = borderImageView;
    
    UIImageView *animateImageView = [[UIImageView alloc]init];
    animateImageView.frame = borderImageView.bounds;
    animateImageView.image = self.animateImage;
    [self.borderImageView addSubview:animateImageView];
    self.animateImageView = animateImageView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(openFalsh:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:self.flashImage forState:UIControlStateNormal];
    [self.view addSubview:button];
    self.flashButton = button;
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.hidden = !self.isDrawQRCodeRect;
    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [doneButton sizeToFit];
    [self.view addSubview:doneButton];
    self.doneButton = doneButton;
}

- (void)openFalsh:(UIButton *)sender
{
    sender.selected = !sender.selected;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash]) {
        [device lockForConfiguration:nil];
        if (sender.selected) {
            device.torchMode = AVCaptureTorchModeOn;
            device.flashMode = AVCaptureTorchModeOn;
        }else {
            device.torchMode = AVCaptureTorchModeOff;
            device.flashMode = AVCaptureTorchModeOff;
        }
        [device unlockForConfiguration];
    }
}

- (void)doneButton:(UIButton *)sender
{
    if (self.isDrawQRCodeRect) {
        [self.session stopRunning];
        !self.scanMultiCompleted? : self.scanMultiCompleted(self.resultStrs);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setShowFlashButton:(BOOL)showFlashButton
{
    _showFlashButton = showFlashButton;
    self.flashButton.hidden = showFlashButton;
}

- (void)openPhotoLibary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
        NSLog(@"不支持访问相册");
    }
}

- (void)beginScan
{
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    [self.session startRunning];
}

- (void)startAnimate
{
    self.animateImageView.y = -160;
    [UIView animateWithDuration:3 animations:^{
        [UIView setAnimationRepeatAutoreverses:YES];
        [UIView setAnimationRepeatCount:MAXFLOAT];
        self.animateImageView.y = 100;
    }];
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange:)
                                                name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.borderImageView.frame = CGRectMake((self.view.bounds.size.width - 250) * 0.5, (self.view.bounds.size.height - 250) * 0.5 - 50, 250, 250);
    self.animateImageView.frame = self.borderImageView.bounds;
    self.flashButton.frame = CGRectMake(CGRectGetMidX(self.borderImageView.frame)-30, CGRectGetMaxY(self.borderImageView.frame) + 10, 60, 60);
    self.doneButton.frame = CGRectMake(CGRectGetMinX(self.flashButton.frame), CGRectGetMaxY(self.flashButton.frame) + 10, 60, 30);
}

- (BOOL)shouldAutorotate
{
    return NO;
}


#pragma mark -- Methods
- (void)handleDeviceOrientationChange:(NSNotification *)notification
{
    [self.previewLayer setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [UIView animateWithDuration:0.35 animations:^{
        [self.view layoutIfNeeded];
    }];
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) {
        self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        [self.output setRectOfInterest:CGRectMake(self.borderImageView.x/SCREEN_WIDTH,
                                                  self.borderImageView.y/SCREEN_HEIGHT,
                                                  self.borderImageView.width/SCREEN_WIDTH,
                                                  self.borderImageView.height/SCREEN_HEIGHT)];
    }
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
        [self.output setRectOfInterest:CGRectMake(self.borderImageView.x/SCREEN_WIDTH,
                                                  (self.view.height - self.borderImageView.y - self.borderImageView.height)/SCREEN_HEIGHT,
                                                  self.borderImageView.width/SCREEN_WIDTH,
                                                  self.borderImageView.height/SCREEN_HEIGHT)];
    }else if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
        self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeRight;
        [self.output setRectOfInterest:CGRectMake(self.borderImageView.x/SCREEN_WIDTH,
                                                  self.borderImageView.y/SCREEN_HEIGHT,
                                                  self.borderImageView.width/SCREEN_WIDTH,
                                                  self.borderImageView.height/SCREEN_HEIGHT)];
    }else{
        self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        [self.output setRectOfInterest:CGRectMake(self.borderImageView.y/SCREEN_HEIGHT,
                                                  self.borderImageView.x/SCREEN_WIDTH,
                                                  self.borderImageView.height/SCREEN_HEIGHT,
                                                  self.borderImageView.width/SCREEN_WIDTH)];
    }

}

- (void)addShowLayer:(AVMetadataMachineReadableCodeObject *)qrCodeObj
{
    // 绘制边框
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.lineWidth = 6;
    layer.fillColor = [UIColor clearColor].CGColor;
    // 创建一个贝塞尔曲线
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    int index = 0;
    for (NSDictionary *pointDic in qrCodeObj.corners)
    {
        CFDictionaryRef dic = (__bridge CFDictionaryRef)(pointDic);
        CGPoint point = CGPointZero;
        CGPointMakeWithDictionaryRepresentation(dic, &point);
        if (index == 0) {
            [path moveToPoint:point];
        }else
        {
            [path addLineToPoint:point];
        }
        index ++;
        
    }
    [path closePath];
    layer.path = path.CGPath;
    [self.previewLayer addSublayer:layer];
    [self.deleteTempLayers addObject:layer];
}

#pragma mark -- AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count == 0) { return; }
    if (self.isDrawQRCodeRect) {
        [self removeFrameLayer];
        for (AVMetadataMachineReadableCodeObject *obj in metadataObjects) {
            if (![self.resultStrs containsObject:obj.stringValue]) {
                [self.resultStrs addObject:obj.stringValue];
            }
            AVMetadataObject *resultObj = [self.previewLayer transformedMetadataObjectForMetadataObject:obj];
            AVMetadataMachineReadableCodeObject *qrCodeObj = (AVMetadataMachineReadableCodeObject *)resultObj;
            [self addShowLayer:qrCodeObj];
        }
        
    }else {
        AVMetadataMachineReadableCodeObject *meta = [metadataObjects lastObject];
        [self closeCurrentVc:meta.stringValue];
    }
}

- (void)removeFrameLayer
{
    for (CALayer *layer in self.deleteTempLayers) {
        [layer removeFromSuperlayer];
    }
    
    [self.deleteTempLayers removeAllObjects];
}

- (void)closeCurrentVc:(NSString *)stringValue
{
    if (self.scanCompleted != nil) {
        self.scanCompleted(stringValue);
        [self.session stopRunning];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (image != nil) {
        NSString *string = [QRCodeTool detectorQRCodeWithSingleQRCodeImage:image];
        [self closeCurrentVc:string];
    }
}

#pragma mark -- Getter
- (AVCaptureSession *)session
{
    if (_session == nil) {
        //获取摄像设备
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        //创建输入流
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        //创建二维码扫描输出流
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //设置采集扫描区域的比例 默认全屏是（0，0，1，1）
        //rectOfInterest 填写的是一个比例，输出流视图preview.frame为 x , y, w, h, 要设置的矩形快的scanFrame 为 x1, y1, w1, h1. 那么rectOfInterest 应该设置为 CGRectMake(y1/y, x1/x, h1/h, w1/w)。
        CGFloat x = CGRectGetMinX(self.borderImageView.frame)/ CGRectGetWidth(self.view.frame);
        CGFloat y = CGRectGetMinY(self.borderImageView.frame)/ CGRectGetHeight(self.view.frame);
        CGFloat width = CGRectGetWidth(self.borderImageView.frame)/ CGRectGetWidth(self.view.frame);
        CGFloat height = CGRectGetHeight(self.borderImageView.frame)/ CGRectGetHeight(self.view.frame);
        output.rectOfInterest = CGRectMake(y, x, height, width);
        
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:input] && [_session canAddOutput:output]) {
            [_session addInput:input];
            [_session addOutput:output];
        }
        
        //设置扫码支持的编码格式(这里设置条形码和二维码兼容)
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                       AVMetadataObjectTypeEAN13Code,
                                       AVMetadataObjectTypeEAN8Code,
                                       AVMetadataObjectTypeCode128Code];
        self.output = output;
    }
    return _session;
}

@end
