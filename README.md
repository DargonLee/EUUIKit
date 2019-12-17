# EUUIKit
一些iOS开发常用UI组件
```

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
