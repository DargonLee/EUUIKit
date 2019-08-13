//
//  EULabelViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/21.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EULabelViewController.h"

@interface EULabelViewController ()

@end

@implementation EULabelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    EULabel * label0 = [[EULabel alloc]initWithFrame:CGRectMake(0, 75, 300, 44)];
    label0.font = [UIFont systemFontOfSize:15];
    label0.textColor = self.view.tintColor;
    label0.backgroundColor = [UIColor greenColor];
    label0.numberOfLines = 0;
    label0.text = @"函数是Python内建支持的一种封装，我们通过把大段代码拆成函数，通过一层一层的函数调用，就可以把复杂任务分解成简单的任务，这种分解可以称之为面向过程的程序设计。函数就是面向过程的程序设计的基本单元。";
    label0.centerX = self.view.centerX;
    [self.view addSubview:label0];
    
    EULabel * label = [[EULabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label0.frame) + 20, 300, 44)];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = self.view.tintColor;
    label.backgroundColor = [UIColor orangeColor];
    label.numberOfLines = 0;
    label.text = @"函数是Python内建支持的一种封装，我们通过把大段代码拆成函数，通过一层一层的函数调用，就可以把复杂任务分解成简单的任务，这种分解可以称之为面向过程的程序设计。函数就是面向过程的程序设计的基本单元。";
    label.centerX = self.view.centerX;
    [self.view addSubview:label];
    
    //让文本自适应高度
    [label sizeToFitLabel];
    
    
    EULabel * label1 = [[EULabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame) + 20, 300, 44)];
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = self.view.tintColor;
    label1.text = @"长按可复制";
    label1.centerX = self.view.centerX;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    label1.layer.borderWidth = 1.0f;
    [self.view addSubview:label1];
    
    label1.canPerformCopyAction = YES;
    label1.highlightedBackgroundColor = [UIColor lightGrayColor];
    [label1 setDidCopyBlock:^(EULabel * _Nonnull label, NSString * _Nonnull copiedString) {
        NSLog(@"%@",copiedString);
    }];
    
    EULabel *label2 = [EULabel lableWithString:@"函数是Python内建支持的一种封装，我们通过把大段代码拆成函数，通过一层一层的函数调用，就可以把复杂任务分解成简单的任务，这种分解可以称之为面向过程的程序设计。函数就是面向过程的程序设计的基本单元。"];
    label2.frame = CGRectMake(0, CGRectGetMaxY(label1.frame) + 20, 300, 44);
    label2.backgroundColor = [UIColor yellowColor];
    label2.textColor = [UIColor lightGrayColor];
    label2.font = [UIFont systemFontOfSize:15];
    label2.centerX = self.view.centerX;
    [self.view addSubview:label2];
    //让文本自适应高度
    [label2 sizeToFitLabel];
    
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame) + 20, 300, 44)];
    label3.numberOfLines = 0;
    label3.backgroundColor = [UIColor cyanColor];
    label3.textColor = [UIColor redColor];
    [label3 setText:@"函数是Python内建支持的一种封装，我们通过把大段代码拆成函数，通过一层一层的函数调用，就可以把复杂任务分解成简单的任务，这种分解可以称之为面向过程的程序设计。函数就是面向过程的程序设计的基本单元。" lineSpacing:5.0f];
    label3.centerX = self.view.centerX;
    [self.view addSubview:label3];
    //让文本自适应高度
    [label3 sizeToFitLabel];
    
    
}

@end
