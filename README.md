# EUUIKit
一些iOS开发常用UI组件
```Objective-C

#import "TestViewController.h"

@interface TestViewController ()

@property (nonatomic, strong) UIButton *doneButton;

@end

@implementation TestViewController

#pragma mark - 控制器的声明周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
    [self layoutViews];
}

#pragma mark - 构建UI
- (void)setupViews
{
    /// do somethings
}

- (void)layoutViews
{
    /// do somethings
}


#pragma mark - 导航跳转
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - UITableViewDelegate

/// methods....

#pragma mark - CustomDelegate

/// methods.....

#pragma mark - 事件响应
- (void)didTappedDoneButton:(UIButton *)doneButton
{
    
}

#pragma mark - 私有方法
/// methods


#pragma mark - 懒加载
- (UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _doneButton;
}

@end

```
/// 简要描述.
/** 简要描述.
 *
 * 详细描述或其他.
 */
/// 文档A.
@interface DocA : NSObject
/** 文档B.
 *
 * 文档B的详细描述.
 */
@interface DocB : NSObject
/// 数值属性.
@property (nonatomic,assign) NSInteger num;
/**
 * @brief 字符串属性.
 *
 * 属性的详细描述.
 */
@property (nonatomic,strong) NSString* str;
/// 简单方法.
- (void)someMethod;
/**
 * @brief 带整数参数的方法.
 *
 * @param  value 值.
 *
 * @return 返回value.
 */
- (int)someMethodByInt:(int)value;
/**
 * @brief 带字符串参数的方法.
 *
 * @param  value 值.
 *
 * @return 返回value.
 *
 * @exception NSException 可能抛出的异常.
 *
 * @see someMethod
 * @see someMethodByInt:
 * @warning 警告: appledoc中显示为蓝色背景, Doxygen中显示为红色竖条.
 * @bug 缺陷: appledoc中显示为黄色背景, Doxygen中显示为绿色竖条.
 */
- (NSString*)someMethodByStr:(NSString*)value;
