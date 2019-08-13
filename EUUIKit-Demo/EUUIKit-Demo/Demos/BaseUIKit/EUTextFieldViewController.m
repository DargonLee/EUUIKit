//
//  EUTextFieldViewController.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/10.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUTextFieldViewController.h"


@interface EUTextFieldViewController ()<EUTextFieldDelegate>


@end

@implementation EUTextFieldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    EUTextField *textField = [[EUTextField alloc]initWithFrame:CGRectMake(10, 80, self.view.bounds.size.width - 20, 30)];
    textField.regexString = [NSString passwordRegex];
    textField.maximumTextLength = 10;
    textField.eudelegate = self;
    textField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kugou"]];
    textField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:textField];
}

/**
 开始编辑的时候的代理方法（UITextField获取焦点）
 
 @param textfield UITextField
 */
- (void)textFieldTextDidBeginEditing:(UITextField *)textfield
{
    
}

/**
 结束编辑的时候的代理方法（UITextField失去焦点）
 
 @param textfield UITextField
 */
- (void)textFieldTextDidEndEditing:(UITextField *)textfield
{
    
}

/**
 文本改变的时候的代理方法
 
 @param textfield UITextField
 */
- (void)textFieldTextDidChange:(UITextField *)textfield
{
    
}

/**
 正则验证成功的代理方法
 
 @param textfield UITextField
 */
- (void)textFieldTextValidateRegexSuccess:(UITextField *)textfield
{
    
}

/**
 正则验证失败的代理方法
 
 @param textfield UITextField
 */
- (void)textFieldTextValidateRegexFailure:(UITextField *)textfield
{
    
}

/**
 self.tipsLabel.attributedText = [[NSAttributedString alloc] initWithString:@"支持：\n1. 自定义 placeholder 颜色；\n2. 修改 clearButton 的图片和布局位置；\n3. 调整输入框与文字之间的间距；\n4. 限制可输入的最大文字长度（可试试输入 emoji、从中文输入法候选词输入等）；\n5. 计算文字长度时区分中英文。" attributes:@{NSFontAttributeName: UIFontMake(12), NSForegroundColorAttributeName: UIColorGray6, NSParagraphStyleAttributeName: [NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:20]}];
 self.tipsLabel.numberOfLines = 0;
 */
@end
