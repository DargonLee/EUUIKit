//
//  EUNormalProgressViewController.m
//  EUUIKit-Demo
//
//  Created by Harlans on 2019/5/15.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUNormalProgressViewController.h"

@interface EUNormalProgressViewController () <EUNormalProgressDelegate>

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) EUNormalProgress *progressView;

@property (nonatomic, strong) EUNormalProgress *progressView1;

@end

@implementation EUNormalProgressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    CGFloat x = (self.view.bounds.size.width - 200) * 0.5;
    
    EUNormalProgress *progressView = [[EUNormalProgress alloc]initWithFrame:CGRectMake(x , 120, 200, 20)];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    EUNormalProgress *progressView1 = [[EUNormalProgress alloc]initWithFrame:CGRectMake(x , 160, 200, 20)];
    progressView1.padding = UIEdgeInsetsMake(1, 1, 1, 1);
    progressView1.fillColor = [UIColor yellowColor];
    progressView1.borderColor = [UIColor redColor];
    progressView1.delegate = self;
    [self.view addSubview:progressView1];
    self.progressView1 = progressView1;
}

- (void)timerAction
{
    self.progressView.progress += 0.1;
    self.progressView1.progress += 0.1;
    if (self.progressView.progress >= 1) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark---------------------------EUNormalProgressDelegate处理--------------------------------
- (void)normalProgressDidDone:(EUNormalProgress *)progressView
{
    progressView.borderColor = [UIColor greenColor];
}


@end
