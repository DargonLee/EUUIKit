//
//  EUTextViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/15.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUTextViewController.h"

@interface EUTextViewController ()

@end

@implementation EUTextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    EUTextView *textView = [[EUTextView alloc]initWithFrame:CGRectMake(30, 80, self.view.bounds.size.width - 60, 150)];
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth = 1.0f;
    textView.placeholder = @"这是一个placeholder";
    textView.placeholderColor = [UIColor orangeColor];
    textView.maximumTextLength = 100;
    [self.view addSubview:textView];
    
}

@end
