//
//  EUNavigationSysController.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/10.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUNavigationSysController.h"
#import "EUUICore.h"

@interface EUNavigationSysController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation EUNavigationSysController

+ (void)initialize
{
    //appearance方法返回一个导航栏的外观对象
    //修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    //设置导航栏背景颜色     
    [navigationBar setBarTintColor:ThemeColor];
    //设置标题栏颜色
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:18]};
    //设置NavigationBarItem文字的颜色
    [navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 重写了leftbarItem之后,需要添加如下方法才能重新启用右滑返回
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

/*
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}
 */

/*
- (void)viewWillDisappear:(BOOL)animated
{
    //如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
 */

- (void)addFullScreenPopPanGesture
{
    
    self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
    self.pan.delegate = self;
    [self.view addGestureRecognizer:self.pan];
    [self.interactivePopGestureRecognizer requireGestureRecognizerToFail:self.pan];
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isEqual:self.pan]) {
        //获取手指移动后的相对偏移量
        CGPoint translationPoint = [self.pan translationInView:self.view];
        //向右滑动 && 不是跟视图控制器
        if (translationPoint.x > 0 && self.childViewControllers.count > 1) {
            return YES;
        }
        return NO;
    }
    return YES;
    
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //全部修改返回按钮,但是会失去右滑返回的手势
    if (viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count >= 1) {
        self.topViewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
