//
//  EUAESViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/20.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUAESViewController.h"

@interface EUAESViewController ()

@property (nonatomic, strong) UILabel * label;

@end

@implementation EUAESViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 0.0f)];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    self.label = label;
    
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"AES给字典加解密" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightTextColor];
    [button setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, CGRectGetMaxY(label.frame) + 120, 200, 44);
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"AES给数组加解密" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor lightTextColor];
    [button1 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonClick1) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, CGRectGetMaxY(button.frame) + 20, 200, 44);
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"AES给字符串加解密" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor lightTextColor];
    [button2 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonClick2) forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, CGRectGetMaxY(button1.frame) + 20, 200, 44);
    [self.view addSubview:button2];
    
}

- (void)buttonClick
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"hello",@"world",@"Name", @"Lee", nil];
    NSData *data = [AESTool aesEncryptWithDictionary:dict];
    NSLog(@"%@",data);
    self.label.text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dict1 = [AESTool aesDecryptWithDictionary:data];
    NSLog(@"%@",dict1);
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict1 options:NSJSONWritingPrettyPrinted error:nil];
    self.label.text = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self.label sizeToFit];
}

- (void)buttonClick1
{
    NSData *data = [AESTool aesEncryptWithString:@"Hello World"];
    NSLog(@"%@", data);
    self.label.text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString * string = [AESTool aesDecryptWithString:data];
    NSLog(@"%@", string);
    self.label.text = string;
    [self.label sizeToFit];
}

- (void)buttonClick2
{
    NSData *data = [AESTool aesEncryptWithArray:@[@"xxx",@(3)]];
    NSLog(@"%@", data);
    self.label.text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray * array = [AESTool aesDecryptWithArray:data];
    NSLog(@"%@", array);
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    self.label.text = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self.label sizeToFit];
}

@end
