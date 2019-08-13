//
//  EUModelViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/23.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUModelViewController.h"
#import "EUModelOneViewController.h"



@interface EUModelViewController ()

@property (nonatomic, strong) EUModelTransitionManger *transitionManger;

@end

@implementation EUModelViewController

- (EUModelTransitionManger *)transitionManger
{
    if (!_transitionManger) {
        _transitionManger = [[EUModelTransitionManger alloc]init];
    }
    return _transitionManger;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"底部弹出一个View" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightTextColor];
    [button setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 80, 200, 44);
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"中间弹出一个View" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor lightTextColor];
    [button1 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonClick1) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, CGRectGetMaxY(button.frame) + 20, 200, 44);
    [self.view addSubview:button1];
}

- (void)buttonClick
{
    EUModelOneViewController *toVC = [[EUModelOneViewController alloc]init];
    EUOverlayPresentationController *presentationC = [[EUOverlayPresentationController alloc] initWithPresentedViewController:toVC presentingViewController:self];
    toVC.transitioningDelegate = presentationC ;  // 指定自定义modal动画的代理
    [self presentViewController:toVC animated:YES completion:nil];
}

- (void)buttonClick1
{
    EUModelOneViewController *toVC = [[EUModelOneViewController alloc]init];
    self.transitionManger.transitionType = EUModalTransitionTypePop;
    toVC.transitioningDelegate =  self.transitionManger;
    toVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:toVC animated:YES completion:nil];
}


@end
