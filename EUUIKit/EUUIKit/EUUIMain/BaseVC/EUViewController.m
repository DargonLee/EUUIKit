//
//  UUViewController.m
//  Mos
//
//  Created by UUSafe on 2019/5/27.
//  Copyright © 2019年 UUSafe. All rights reserved.
//

#import "EUViewController.h"
#import "UUNavigationConfig.h"
#import "UUUtils+UI.h"


@interface EUViewController ()

@property (nonatomic) dispatch_once_t onceTokenWill;

@property (nonatomic) dispatch_once_t onceTokenDid;

@property (weak, nonatomic) MBProgressHUD *activityIndicatorView;

@end

@implementation EUViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initialization];
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initialization];
    }
    
    return self;
}

- (void)initialization
{
    self.supportedOrientations = UIInterfaceOrientationMaskPortrait;
    _statusBarStyle = [UUNavigationConfig getInstance].statusBarStyle;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootVC isKindOfClass:[UITabBarController class]] && ((UITabBarController *)rootVC).viewControllers.count <= 1)
    {
        return;
    }
    [super setHidesBottomBarWhenPushed:hidesBottomBarWhenPushed];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    dispatch_once(&_onceTokenWill, ^{
        [self viewFirstWillAppear];
    });
}

// 此方法在Controller生命周期中只执行一次
- (void)viewFirstWillAppear
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_once(&_onceTokenDid, ^{
        [self viewFirstDidAppear];
    });
}

// 此方法在Controller生命周期中只执行一次
- (void)viewFirstDidAppear
{
    
}

// 显示默认加载视图
- (void)showDefaultLoadingView
{
    
}

// 隐藏默认加载视图
- (void)hiddenDefaultLoadingView
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 屏幕方向相关

- (BOOL)shouldAutorotate
{
    return self.canAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.supportedOrientations;
}

#pragma mark - 状态栏相关

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    if (_statusBarStyle == statusBarStyle)
    {
        return;
    }
    
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle;
}

- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHidden;
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyDataTitle;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyDataDescription;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyDataImage;
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return self.emptyDataAllowScroll;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyDataVerticalOffset;
}

- (void)showActivityIndicatorView:(NSString*)message
{
    if (self.activityIndicatorView)
        return;
    
    self.activityIndicatorView = [self showActivityIndicatorViewInView:self.view message:message];
}

- (void)hiddenActivityIndicatorView
{
    if (self.activityIndicatorView)
    {
        [self.activityIndicatorView hideAnimated:NO];
        self.activityIndicatorView = nil;
    }
}

-(MBProgressHUD*)showActivityIndicatorViewInView:(UIView*)view message:(NSString*)message
{
    return [UUUtils showActivityIndicatorViewInView:self.view message:message];   
}
-(void)showError:(NSInteger)code message:(NSString*)message
{
    //NSString* text = [NSString stringWithFormat:@"Error Code=%d,Message=%@",code,message != nil ? message : @""];
    [self showToast:message];
}

- (void)showToast:(NSString *)message completionBlock:(MBProgressHUDCompletionBlock)completionBlock
{
    [UUUtils showToastInView:self.view message:message duration:2.0 completionBlock:completionBlock];
}

-(void)showToast:(NSString*)message
{
    [self showToast:message completionBlock:nil];
}

-(void)showAlert:(NSString*)title message:(NSString*)message okBtnTitle:(NSString*)okBtnTitle block:(UIAlertControllerCompletionBlock)block
{
    [UUUtils showAlert:self title:title message:message okBtnTitle:okBtnTitle block:block];
}
-(void)showConfim:(NSString*)title message:(NSString*)message okBtnTitle:(NSString*)okBtnTitle cancelBtnTitle:(NSString*)cancelBtnTitle block:(UIAlertControllerCompletionBlock)block
{
    [UUUtils showConfim:self title:title message:message okBtnTitle:okBtnTitle cancelBtnTitle:cancelBtnTitle block:block];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
