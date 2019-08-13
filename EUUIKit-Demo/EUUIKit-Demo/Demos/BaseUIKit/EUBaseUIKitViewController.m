//
//  EUBaseUIKitViewController.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/10.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUBaseUIKitViewController.h"

@interface EUBaseUIKitViewController ()

@property (nonatomic, strong) NSMutableArray <EUBaseUIKitItem *>*dataSource;

@end

static NSString *cellIdentifier = @"cellIdentifier";

@implementation EUBaseUIKitViewController

- (void)initDataSource
{
    self.dataSource = [NSMutableArray array];
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EUTextField"
                                                            subTitle:@"继承与UITextField，可以验证正则和控制文本长度，还可以提供文本输入的生命周期等"
                                                      viewController:@"EUTextFieldViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EUUIButton"
                                                            subTitle:@"封装了UIButton的image和title的位置排布，和点击区域的扩大方法"
                                                      viewController:@"EUUIButtonViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EUTextView"
                                                            subTitle:@"封装了UITextView的placeholder，支持更改颜色和设置最大字符长度"
                                                      viewController:@"EUTextViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EUAlertView"
                                                            subTitle:@"封装了系统IUIAlertViewController的简单调用方式"
                                                      viewController:@"EUAlertViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"HUD"
                                                            subTitle:@"封装了MBProgressHUD,调用方式更简单，跟控制器结偶"
                                                      viewController:@"EUHUDViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"AES加解密"
                                                            subTitle:@"封装了常用的AES加解密工具类"
                                                      viewController:@"EUAESViewController"]];
    
    [self.dataSource addObject:[[EUBaseUIKitItem alloc]initWithTitle:@"EULabel"
                                                            subTitle:@"集成UILabel 扩展长按复制 设置内边距 自适应高度"
                                                      viewController:@"EULabelViewController"]];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"BaseUIKit";
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


@implementation EUBaseUIKitItem

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle viewController:(NSString *)vc
{
    if (self == [super init]) {
        self.title = title;
        self.subTitle = subTitle;
        self.viewController = vc;
    }
    return self;
}

@end
