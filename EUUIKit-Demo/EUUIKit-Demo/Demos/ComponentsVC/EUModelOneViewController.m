//
//  EUModelOneViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/23.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUModelOneViewController.h"

@interface EUModelOneViewController ()

@end

@implementation EUModelOneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    // 设置当情控制器view的宽高
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
}

- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection
{
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 270 : 420);
}

@end
