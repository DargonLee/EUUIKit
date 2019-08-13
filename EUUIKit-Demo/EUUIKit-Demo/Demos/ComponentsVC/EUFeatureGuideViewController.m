//
//  EUFeatureGuideViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/22.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUFeatureGuideViewController.h"

@interface EUFeatureGuideViewController ()

@end

@implementation EUFeatureGuideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"item2(null)"];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.frame = CGRectMake(10, 80, 100, 40);
    firstBtn.backgroundColor = self.view.tintColor;
    [self.view addSubview:firstBtn];
    
    UIButton * secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.frame = CGRectMake(200, 380, 100, 40);
    secondBtn.backgroundColor = self.view.tintColor;
    [self.view addSubview:secondBtn];
    
    EUFeatureItem *itemLeft = [[EUFeatureItem alloc] initWithFocusView:firstBtn focusCornerRadius:0 focusInsets:UIEdgeInsetsMake(-10, -10, 10, 10)];
    itemLeft.introduce = @"左上部的提示";
    itemLeft.buttonBackgroundImageName=@"logo";
    EUFeatureItem *itemMid = [[EUFeatureItem alloc] initWithFocusView:secondBtn focusCornerRadius:0 focusInsets:UIEdgeInsetsZero];
    itemMid.introduce = @"右中部的提示";
    itemMid.buttonBackgroundImageName=@"logo";
    
    
    [self.navigationController.view showWithFeatureItems:@[itemLeft, itemMid] saveKeyName:@"item2" inVersion:nil];
    
}

@end
