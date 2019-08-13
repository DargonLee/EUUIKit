//
//  EUUIButtonViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/14.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUUIButtonViewController.h"

@interface EUUIButtonViewController ()

@end

@implementation EUUIButtonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    EUUIButton *button = [EUUIButton buttonWithImagePositionType:EUUIButtonImagePositionLeft];
    [button setTitle:@"Hello Worldf" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"food-pecan"] forState:UIControlStateNormal];
    button.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 84, 200, 44);
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.view addSubview:button];
    
    
    
    EUUIButton *button1 = [[EUUIButton alloc]init];
    button1.imagePosition = EUUIButtonImagePositionRight;
    button1.spacingBetweenImageAndTitle = 10;
    [button1 setTitle:@"Hello Worldf" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"food-pecan"] forState:UIControlStateNormal];
    button1.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 150, 200, 44);
    button1.layer.borderWidth = 1.0f;
    button1.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.view addSubview:button1];
    
    
    EUUIButton *button2 = [EUUIButton buttonWithImagePositionType:EUUIButtonImagePositionTop]; 
    [button2 setTitle:@"Hello Worldf" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"food-pecan"] forState:UIControlStateNormal];
    button2.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 220, 200, 44);
    button2.layer.borderWidth = 1.0f;
    button2.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.view addSubview:button2];
    
    
    EUUIButton *button3 = [EUUIButton buttonWithImagePositionType:EUUIButtonImagePositionBottom];
    button3.spacingBetweenImageAndTitle = 10;
    [button3 setTitle:@"Hello Worldf" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"food-pecan"] forState:UIControlStateNormal];
    button3.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 290, 200, 60);
    button3.layer.borderWidth = 1.0f;
    button3.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.view addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setTitle:@"Hello Worldf" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button4 setImage:[UIImage imageNamed:@"food-pecan"] forState:UIControlStateNormal];
    button4.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 100, 370, 200, 60);
    button4.layer.borderWidth = 1.0f;
    button4.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.view addSubview:button4];
    // 建议用法
    [button4 setImagePosition:EUImagePositionTop spacing:5.0];
}


@end
