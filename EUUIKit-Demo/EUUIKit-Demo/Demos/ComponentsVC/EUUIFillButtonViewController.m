//
//  EUUIFillButtonViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/14.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUUIFillButtonViewController.h"

@interface EUUIFillButtonViewController ()

@end

@implementation EUUIFillButtonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    EUUIFillButton *button = [[EUUIFillButton alloc]initWitFillType:EUUIFillButtonColorTypeBlue];
    [button setTitle:@"EUUIFillButtonColorTypeBlue" forState:UIControlStateNormal];
    button.frame = CGRectMake(30, 70, self.view.bounds.size.width - 60, 44);
    [self.view addSubview:button];
    
    EUUIFillButton *button1 = [[EUUIFillButton alloc]initWithFillColor:[UIColor yellowColor] titleTextColor:[UIColor brownColor]];
    [button1 setTitle:@"EUUIFillButtonColorTypeYellow" forState:UIControlStateNormal];
    button1.frame = CGRectMake(30, 140, self.view.bounds.size.width - 60, 44);
    [self.view addSubview:button1];
    
    EUUIFillButton *button2 = [EUUIFillButton fillButtonType:EUUIFillButtonColorTypeGreen];
    [button2 setTitle:@"EUUIFillButtonColorTypeGreen" forState:UIControlStateNormal];
    button2.frame = CGRectMake(30, 210, self.view.bounds.size.width - 60, 44);
    [button2 addTarget:self action:@selector(handleFillButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
}

- (void)handleFillButtonEvent:(EUUIFillButton *)sender
{
    sender.fillColor = [UIColor orangeColor];
}

@end
