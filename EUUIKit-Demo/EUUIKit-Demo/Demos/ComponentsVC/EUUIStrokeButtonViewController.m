//
//  EUUIStrokeButtonViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/15.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUUIStrokeButtonViewController.h"

@interface EUUIStrokeButtonViewController ()

@end

@implementation EUUIStrokeButtonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    EUUIStrokeButton *button = [[EUUIStrokeButton alloc]initWithStrokeType:EUUIStrokeButtonColorTypeBlue];
    [button setTitle:@"EUUIStrokeButtonColorTypeBlue" forState:UIControlStateNormal];
    button.frame = CGRectMake(30, 70, self.view.bounds.size.width - 60, 44);
    [self.view addSubview:button];
    
    EUUIStrokeButton *button1 = [[EUUIStrokeButton alloc]initWithStrokeColor:[UIColor orangeColor]];
    [button1 setTitle:@"EUUIStrokeButtonColorTypeOrange" forState:UIControlStateNormal];
    button1.frame = CGRectMake(30, 140, self.view.bounds.size.width - 60, 44);
    [self.view addSubview:button1];
    
    EUUIStrokeButton *button2 = [EUUIStrokeButton strokeTypeButton:EUUIStrokeButtonColorTypeGreen];
    [button2 setTitle:@"EUUIStrokeButtonColorTypeGreen" forState:UIControlStateNormal];
    button2.frame = CGRectMake(30, 210, self.view.bounds.size.width - 60, 44);
    [button2 addTarget:self action:@selector(handleFillButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)handleFillButtonEvent:(EUUIStrokeButton *)sender
{
    sender.strokeColor = [UIColor cyanColor];
}


@end
