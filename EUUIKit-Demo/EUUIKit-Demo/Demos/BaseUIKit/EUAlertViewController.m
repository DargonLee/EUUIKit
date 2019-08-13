//
//  EUAlertViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/16.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUAlertViewController.h"

@interface EUAlertViewController ()

@end

@implementation EUAlertViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"常规Alert" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 80, 200, 44);
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"带有取消和确定Alert" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor grayColor];
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonClick1) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, CGRectGetMaxY(button.frame) + 10, 200, 44);
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"常规Aheet" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor grayColor];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonClick2) forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, CGRectGetMaxY(button1.frame) + 10, 200, 44);
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"Loading" forState:UIControlStateNormal];
    button3.backgroundColor = [UIColor grayColor];
    [button3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(buttonClick3) forControlEvents:UIControlEventTouchUpInside];
    button3.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, CGRectGetMaxY(button2.frame) + 10, 200, 44);
    [self.view addSubview:button3];
    
}

- (void)buttonClick
{
    [EUAlertView alertControllerWithTitle:@"这是一个标题" message:@"这里是详细信息"
                                   okText:@"OK" okAction:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了ok");
    }];
}

- (void)buttonClick1
{
    [EUAlertView alertControllerWithTitle:@"这是一个标题" message:@"这里是详细信息"
                               cancelText:@"取消" okText:@"确定" cancelAction:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    } okAction:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了ok");
    }];
}

- (void)buttonClick2
{
    [EUAlertView sheetControllerWithTitle:@"这是一个标题" message:@"这里是详细信息" sheets:@[@"选项一", @"选项二", @"选项三", @"选项四", @"选项五"] cancelText:@"取消" sheetsAction:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了sheet%@", action);
    } cancelAction:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
}

- (void)buttonClick3
{
    [EUAlertView showLoadingWithTitle:@"Loading..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EUAlertView hideLoading];
    });
}

@end
