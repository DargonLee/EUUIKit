//
//  UUViewController.h
//  Mos
//
//  Created by UUSafe on 2019/5/27.
//  Copyright © 2019年 UUSafe. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EUViewController : UIViewController
// 是否允许旋转，默认不允许旋转
@property (nonatomic) BOOL canAutorotate;
// 支持的屏幕方向，默认只支持竖屏
@property (nonatomic) UIInterfaceOrientationMask supportedOrientations;
// 状态栏风格，默认黑字
@property (nonatomic) UIStatusBarStyle statusBarStyle;
// 状态栏是否隐藏，默认不隐藏
@property (nonatomic) BOOL statusBarHidden;
// 配置参数
@property (strong, nonatomic) NSDictionary *params;

#pragma mark - EmptyData

// 空白页显示标题
@property (copy, nonatomic) NSAttributedString *emptyDataTitle;
// 空白页显示详细描述
@property (copy, nonatomic) NSAttributedString *emptyDataDescription;
// 空白页显示图片
@property (strong, nonatomic) UIImage *emptyDataImage;
// 空白页内容垂直offset
@property (nonatomic) CGFloat emptyDataVerticalOffset;
// 空白页是否允许滚动，默认不允许
@property (nonatomic) BOOL emptyDataAllowScroll;

// 以下两个方法在Controller生命周期中只执行一次
- (void)viewFirstWillAppear;
- (void)viewFirstDidAppear;

// 展现进度条
- (void)showActivityIndicatorView:(NSString *)message;
// 关闭进度条
- (void)hiddenActivityIndicatorView;

// alert
- (void)showAlert:(NSString*)title message:(NSString*)message okBtnTitle:(NSString*)okBtnTitle block:(UIAlertControllerCompletionBlock)block;
- (void)showConfim:(NSString*)title message:(NSString*)message okBtnTitle:(NSString*)okBtnTitle cancelBtnTitle:(NSString*)cancelBtnTitle block:(UIAlertControllerCompletionBlock)block;
@end
