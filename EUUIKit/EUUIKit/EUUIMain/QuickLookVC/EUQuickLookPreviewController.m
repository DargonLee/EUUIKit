//
//  EUQuickLookPreviewController.m
//  EUUIKit
//
//  Created by Harlan on 2019/11/3.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUQuickLookPreviewController.h"
#import "UIViewController+EUUI.h"

#import <QuickLook/QuickLook.h>

@interface EUQuickLookPreviewController ()<QLPreviewControllerDataSource>
// 预览VC
@property (strong, nonatomic) QLPreviewController *previewController;

@end

@implementation EUQuickLookPreviewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 创建预览
    self.previewController = [[QLPreviewController alloc]init];
    self.previewController.dataSource = self;
    self.previewController.currentPreviewItemIndex = 0;
    [self.view addSubview:self.previewController.view];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    CGRect frame = CGRectZero;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (statusBarHeight == 44)
    {
        statusBarHeight = 12;
    }
    
    frame.origin.y = self.navigationController.navigationBar.frame.size.height + statusBarHeight;
    // iPhone X 横屏
    if (bounds.size.width * bounds.size.height == 375 * 812 && bounds.size.width == 812)
    {
        frame.origin.x = 44;
        frame.size.width = bounds.size.width - 88;
    }
    else
    {
        frame.size.width = bounds.size.width;
    }
    
    frame.size.height = bounds.size.height - frame.origin.y;
    self.previewController.view.frame = frame;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden = NO;
    //self.navigationController.navigationBar.hidden = NO;
    [self.previewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.previewController viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.previewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.previewController viewDidDisappear:animated];
}

#pragma mark - QLPreviewControllerDataSource

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    return self.previewItemURL;
}



- (void)openFile:(NSString*)filePath
{
    EUQuickLookPreviewController *previewController = [[EUQuickLookPreviewController alloc]init];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    previewController.previewItemURL = url;
    UIViewController* vc = [self findViewController];
    [vc.navigationController pushViewController:previewController animated:YES];
}

- (void)openFile:(NSString*)filePath title:(NSString*)title
{
    EUQuickLookPreviewController *previewController = [[EUQuickLookPreviewController alloc]init];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    previewController.previewItemURL = url;
    UIViewController* vc = [self findViewController];
    previewController.titleString = title;
    [vc.navigationController pushViewController:previewController animated:YES];
}

@end
