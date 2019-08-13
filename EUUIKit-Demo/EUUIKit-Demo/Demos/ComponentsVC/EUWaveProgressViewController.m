//
//  EUWaveProgressViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/15.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUWaveProgressViewController.h"

@interface EUWaveProgressViewController ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) EUWaveProgress *progressView;

@end

@implementation EUWaveProgressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    CGFloat x = (self.view.bounds.size.width - 100) * 0.5;
    EUWaveProgress *progressView = [[EUWaveProgress alloc]initWithFrame:CGRectMake(x , 80, 100, 100)];
    [self.view addSubview:progressView];
    self.progressView = progressView;
}

- (void)timerAction
{
    self.progressView.progress += 0.1;
    if (self.progressView.progress >= 1) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


@end
