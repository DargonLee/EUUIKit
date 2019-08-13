//
//  EUCircleProgressViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/15.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUCircleProgressViewController.h"

@interface EUCircleProgressViewController () <EUCircleProgressDelegate>

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) EUCircleProgress *progressView;

@end

@implementation EUCircleProgressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    CGFloat x = (self.view.bounds.size.width - 100) * 0.5;
    EUCircleProgress *progressView = [[EUCircleProgress alloc]initWithFrame:CGRectMake(x , 80, 100, 100)];
    progressView.delegate = self;
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)timerAction
{
    self.progressView.progress += 0.1;
    if (self.progressView.progress >= 1) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark---------------------------EUCircleProgressDelegate处理--------------------------------
- (void)circleProgressDidDone:(EUCircleProgress *)prgressView
{
    prgressView.valueString = @"Done";
    prgressView.tintColor = [UIColor greenColor];
    prgressView.textColor = [UIColor greenColor];
}



@end
