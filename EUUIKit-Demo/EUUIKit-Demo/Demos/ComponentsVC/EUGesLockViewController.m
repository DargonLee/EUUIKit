//
//  EUGesLockViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/6/3.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUGesLockViewController.h"

@interface EUGesLockViewController ()

@end

@implementation EUGesLockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"Home_refresh_bg"];
    [self.view addSubview:bgImageView];
    
    EULockView *lockView = [[EULockView alloc]initWithNormalImage:@"gesture_node_normal" selectedImage:@"gesture_node_selected"];
    lockView.frame = CGRectMake(0, 100, self.view.width, 300);
    [lockView setGetGesturePwd:^(NSString * _Nonnull pwd) {
        NSLog(@"密码为：%@",pwd);
    }];
    [self.view addSubview:lockView];
}

@end
