//
//  EUInstallProgressViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/15.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUInstallProgressViewController.h"

@interface EUInstallProgressViewController () <EUInstallProgressDelegate>

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) EUInstallProgress *progressView0;

@property (nonatomic, strong) EUInstallProgress *progressView;

@end

@implementation EUInstallProgressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    CGFloat x = (self.view.bounds.size.width - 200) * 0.5;
    
    EUInstallProgress *progressView0 = [[EUInstallProgress alloc]initWithFrame:CGRectMake(x , 120, 200, 44)];
    [self.view addSubview:progressView0];
    self.progressView0 = progressView0;
    
    EUInstallProgress *progressView = [[EUInstallProgress alloc]initWithFrame:CGRectMake(x , 200, 200, 44)];
    progressView.layer.cornerRadius = 21;
    progressView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    progressView.fillColor = [UIColor redColor];
    progressView.delegate = self;
    [self.view addSubview:progressView];
    self.progressView = progressView;
}

- (void)timerAction
{
    self.progressView.progress += 0.1;
    self.progressView0.progress += 0.1;
    if (self.progressView.progress >= 1) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark---------------------------EUInstallProgressDelegate处理--------------------------------
- (void)installProgressDidDone:(EUInstallProgress *)prgressView
{
    prgressView.backgroundColor = [UIColor greenColor];
}


@end
