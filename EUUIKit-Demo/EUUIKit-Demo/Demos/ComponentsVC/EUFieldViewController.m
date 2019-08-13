//
//  EUFieldViewController.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/13.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUFieldViewController.h"

@interface EUFieldViewController ()

@property (nonatomic, strong) EUTextFieldView *textView;

@property (nonatomic, strong) EUTextFieldView *textView1;

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation EUFieldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"EUTextFieldView";
    
    
    EUTextFieldView *textView = [[EUTextFieldView alloc]initWithFrame:
                                 CGRectMake(10, 150, self.view.bounds.size.width - 20, 30)
                                                        textFieldType:EUTextFieldViewTypeVerifiCode];
    textView.iconName = @"kugou";
    textView.focusIconName = @"hourse";
    textView.focusBottomLineColor = [UIColor redColor];
    [self.view addSubview:textView];
    self.textView = textView;
    
    
    EUTextFieldView *textView1 = [[EUTextFieldView alloc]initWithFrame:
                                  CGRectMake(10, 200, self.view.bounds.size.width - 20, 30)
                                                         textFieldType:EUTextFieldViewTypeUsername];
    textView1.iconName = @"kugou";
    textView1.regexFailureBottomLineColor = [UIColor redColor];
    textView1.regexSuccessBottomLineColor = [UIColor greenColor];
    [self.view addSubview:textView1];
    self.textView1 = textView1;
    
    [self.array addObject:textView];
    [self.array addObject:textView1];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    // 单个验证 不为nil的时候会返回正则报错信息
    NSString *msg =  [self.textView doValidateRegex];
    NSLog(@"%@",msg);
    
    
    // 多个验证 不为nil的时候会返回正则报错信息 一但有正则不通过就会立即返回 只有返回为nil的时候 才是通过所有的正则验证
    NSString *msg1 = [self.array doValidateFields];
    NSLog(@"%@",msg1);
    
}

- (NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array] ;
    }
    return _array;
}

@end
