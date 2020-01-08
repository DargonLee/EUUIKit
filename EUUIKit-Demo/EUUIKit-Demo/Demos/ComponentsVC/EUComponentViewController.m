//
//  EUComponentViewController.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/10.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUComponentViewController.h"
#import "EUBaseUIKitViewController.h"

@interface EUComponentViewController ()

@property (nonatomic, strong) NSMutableArray <EUBaseUIKitItem *>*dataSource;

@end

static NSString *cellIdentifier = @"comcellIdentifier";

@implementation EUComponentViewController

- (void)initDataSource
{
    self.dataSource = [NSMutableArray array];
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EUTextFieldView"
                                                            subTitle:@"封装EUTextField适用于项目登陆输入框或者验证码等，提供了不同类型的输入框，通过枚举自动配置正则和文本最大长度"
                                                      viewController:@"EUFieldViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EUUIFillButton"
                                                            subTitle:@"可以快速创建一个带填充色的Button，并且可以设置填充色和字体色，也可以设置圆角"
                                                      viewController:@"EUUIFillButtonViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EUUIStrokeButton"
                                                            subTitle:@"可以快速创建一个带镂空色的Button，并且可以设置填充色和字体色，也可以设置圆角"
                                                      viewController:@"EUUIStrokeButtonViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EUCircleProgress"
                                                            subTitle:@"一个下载进度条，可以设置颜色，和线条宽度等"
                                                      viewController:@"EUCircleProgressViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EUWaveProgress"
                                                            subTitle:@"水波纹的下载进度条"
                                                      viewController:@"EUWaveProgressViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EUInstallProgress"
                                                            subTitle:@"应用安装进度条1"
                                                      viewController:@"EUInstallProgressViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EUNormalProgress"
                                                            subTitle:@"应用安装进度条2"
                                                      viewController:@"EUNormalProgressViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EUEmptyView"
                                                            subTitle:@"控制的view的空状态view"
                                                      viewController:@"EUEmptyViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EUFeatureGuideView"
                                                            subTitle:@"新特性文件"
                                                      viewController:@"EUFeatureGuideViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EUOverlayPresentationController"
                                                            subTitle:@"从底部Model出一个带动画的控制器"
                                                      viewController:@"EUModelViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"QRCodeTool"
                                                            subTitle:@"二维码生成器"
                                                      viewController:@"EUQRCodeGeneratorViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EULockView"
                                                            subTitle:@"手势解锁View"
                                                      viewController:@"EUGesLockViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EULockView"
          subTitle:@"PageMenu子控制器"
    viewController:@"EUPageMenuViewController"]];
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Component";
    [self initDataSource];
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EUBaseUIKitItem *item = self.dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = item.subTitle;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EUBaseUIKitItem *item = self.dataSource[indexPath.row];
    UIViewController *vc = [[NSClassFromString(item.viewController) alloc]init];
    vc.title = item.title;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
