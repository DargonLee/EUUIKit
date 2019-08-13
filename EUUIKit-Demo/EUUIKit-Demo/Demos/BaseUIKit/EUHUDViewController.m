//
//  EUHUDViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/17.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUHUDViewController.h"

@interface EUHUDViewController ()
{
    float value;
}
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation EUHUDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"中间的HUD" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightTextColor];
    [button setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 80, 200, 44);
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"带有文字Loading" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor lightTextColor];
    [button1 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonClick1) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 160, 200, 44);
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"带有图片和文字的HUD" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor lightTextColor];
    [button2 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonClick2) forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 240, 200, 44);
    [self.view addSubview:button2];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Hide" style:UIBarButtonItemStylePlain target:self action:@selector(buttonClick4)];
    
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"下载进度的HUD" forState:UIControlStateNormal];
    button3.backgroundColor = [UIColor lightTextColor];
    [button3 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(buttonClick3) forControlEvents:UIControlEventTouchUpInside];
    button3.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 320, 200, 44);
    [self.view addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setTitle:@"底部的文字HUD" forState:UIControlStateNormal];
    button4.backgroundColor = [UIColor lightTextColor];
    [button4 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(buttonClick5) forControlEvents:UIControlEventTouchUpInside];
    button4.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 400, 200, 44);
    [self.view addSubview:button4];
    
    
    UIButton *button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button6 setTitle:@"自定义HUD" forState:UIControlStateNormal];
    button6.backgroundColor = [UIColor lightTextColor];
    [button6 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button6 addTarget:self action:@selector(buttonClick6) forControlEvents:UIControlEventTouchUpInside];
    button6.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 480, 200, 44);
    [self.view addSubview:button6];
}

- (void)buttonClick
{
    [self showHint:@"Hello,World!!!"];
}

- (void)buttonClick1
{
    [self showLoadingWithText:@"Loading"];
}

- (void)buttonClick2
{
    [self showHudWithImageName:@"kugou" hint:@"HelloKuGou"];
}

- (void)buttonClick3
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)buttonClick4
{
    [self hideHud];
}

- (void)buttonClick5
{
    [self showHintBottom:@"Hello Bottom"];
}

- (void)timerAction
{
    if (value > 1) {
        [self.timer invalidate];
        self.timer = nil;
    }
    value += 0.1;
    [self showDeterminateWithProgress:value hint:@"下载中..."];
}

- (void)buttonClick6
{
    [self showAnimationLoadingViewWithImageName:@"logo" hint:@"Loading..."];
}

@end
