//
//  EUQRCodeGeneratorViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/28.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUQRCodeGeneratorViewController.h"

@interface EUQRCodeGeneratorViewController ()

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, weak) UIImageView *qrCodeImageView;

@end

@implementation EUQRCodeGeneratorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UITextField *textField = [[UITextField alloc]init];
    CGFloat centerX = (self.view.bounds.size.width - 200) * 0.5;
    textField.frame = CGRectMake(centerX, 74, 200, 30);
    textField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:textField];
    self.textField = textField;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"生成普通二维码" forState:UIControlStateNormal];
    [button setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    button.frame = CGRectMake(centerX, CGRectGetMaxY(textField.frame) + 20, 200, 30);
    [button addTarget:self action:@selector(generatorButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"生成自定义二维码" forState:UIControlStateNormal];
    [button1 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    button1.frame = CGRectMake(centerX, CGRectGetMaxY(button.frame) + 20, 200, 30);
    [button1 addTarget:self action:@selector(generatorButton1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"生成带颜色二维码" forState:UIControlStateNormal];
    [button2 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    button2.frame = CGRectMake(centerX, CGRectGetMaxY(button1.frame) + 20, 200, 30);
    [button2 addTarget:self action:@selector(generatorButton2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [button3 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    button3.frame = CGRectMake(centerX, CGRectGetMaxY(button2.frame) + 20, 200, 30);
    [button3 addTarget:self action:@selector(generatorButton3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIImageView *qrCodeImageView = [[UIImageView alloc]init];
    qrCodeImageView.frame = CGRectMake(centerX, CGRectGetMaxY(button3.frame) + 50, 200, 200);
    [self.view addSubview:qrCodeImageView];
    self.qrCodeImageView = qrCodeImageView;
}

- (void)generatorButton
{
    if (self.textField.text.length == 0 || self.textField.text == nil) {
        [self showHint:@"输入文本内容"];
        return;
    }
    // 生成二维码代码
    self.qrCodeImageView.image = [QRCodeTool generatorQRCodeWithString:self.textField.text];
}

- (void)generatorButton1
{
    if (self.textField.text.length == 0 || self.textField.text == nil) {
        [self showHint:@"输入文本内容"];
        return;
    }
    // 生成二维码代码
    self.qrCodeImageView.image = [QRCodeTool generatorQRCodeWithString:self.textField.text centerImage:[UIImage imageNamed:@"logo"]];
}

- (void)generatorButton2
{
    if (self.textField.text.length == 0 || self.textField.text == nil) {
        [self showHint:@"输入文本内容"];
        return;
    }
    // 生成二维码代码
    self.qrCodeImageView.image = [QRCodeTool generatorQRCodeWithString:self.textField.text centerImage:[UIImage imageNamed:@"logo"] r:255 g:215 b:0 alpha:1.0];
}

- (void)generatorButton3
{
    EUScanQRCodeViewController *vc = [[EUScanQRCodeViewController alloc]init];
    vc.borderImage = [UIImage imageNamed:@"qrcode_border"];
    vc.animateImage = [UIImage imageNamed:@"qrcode_scanline_qrcode"];
    vc.flashImage = [UIImage imageNamed:@"scanFlashlight"];
    vc.showPhotoLibaryItem = YES;
    vc.isDrawQRCodeRect = NO;
    [vc setScanCompleted:^(NSString * _Nonnull messageString) {
        NSLog(@"%@", messageString);
        self.textField.text = messageString;
    }];
    [vc setScanMultiCompleted:^(NSArray<NSString *> * _Nullable messages) {
        NSLog(@"%@",messages);
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
