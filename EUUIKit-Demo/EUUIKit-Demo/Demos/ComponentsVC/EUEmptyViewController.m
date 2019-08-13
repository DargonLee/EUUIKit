//
//  EUEmptyViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/21.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUEmptyViewController.h"

@interface EUEmptyViewController ()

@end

@implementation EUEmptyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Hide" style:UIBarButtonItemStylePlain target:self action:@selector(buttonClick4)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"显示loading" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightTextColor];
    [button setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 80, 200, 44);
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"显示提示语" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor lightTextColor];
    [button1 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonClick1) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 140, 200, 44);
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"显示提示语及操作按钮" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor lightTextColor];
    [button2 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonClick2) forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 200, 200, 44);
    [self.view addSubview:button2];
    
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"显示占位图及文字" forState:UIControlStateNormal];
    button3.backgroundColor = [UIColor lightTextColor];
    [button3 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(buttonClick3) forControlEvents:UIControlEventTouchUpInside];
    button3.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 260, 200, 44);
    [self.view addSubview:button3];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button5 setTitle:@"显示提示语及图片" forState:UIControlStateNormal];
    button5.backgroundColor = [UIColor lightTextColor];
    [button5 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(buttonClick5) forControlEvents:UIControlEventTouchUpInside];
    button5.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 320, 200, 44);
    [self.view addSubview:button5];
    
}


- (void)buttonClick
{
    [self showEmptyViewWithLoading];
}

- (void)buttonClick1
{
    [self showEmptyViewWithText:@"联系人为空" detailText:@"请到设置-隐私查看你的联系人权限设置"];
}

- (void)buttonClick2
{
    [self showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接 " buttonTitle:@"重试" buttonAction:^(UIButton * _Nonnull clickButton) {
        NSLog(@"点击了重试！！！");
    }];
}

- (void)buttonClick3
{
    [self showEmptyViewWithImage:[UIImage imageNamed:@"logo"] text:@"指掌易" detailText:@"移动安全专家" buttonTitle:@"重试" buttonAction:^(UIButton * _Nonnull clickButton) {
        NSLog(@"点击了重试！！！");
    }];
}

- (void)buttonClick4
{
    [self hideEmptyView];
}

- (void)buttonClick5
{
    [self showEmptyViewWithImage:[UIImage imageNamed:@"logo"] text:@"Hello" detailText:@"移动安全专家"];
}

@end
