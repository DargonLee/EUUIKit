//
//  EUTabBarController.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/20.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUTabBarController.h"
#import "EUUICore.h"


@interface EUTabBarController ()

@end

@implementation EUTabBarController

+ (void)initialize
{
    UITabBar *tabBar = [UITabBar appearance];
    tabBar.tintColor = ThemeColor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
@end
