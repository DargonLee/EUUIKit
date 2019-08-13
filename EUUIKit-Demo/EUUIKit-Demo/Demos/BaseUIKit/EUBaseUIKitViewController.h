//
//  EUBaseUIKitViewController.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/10.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EUBaseUIKitViewController : UITableViewController

@end

@interface EUBaseUIKitItem : NSObject

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle viewController:(NSString *)vc;

@property (nonatomic, copy) NSString *viewController;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@end

NS_ASSUME_NONNULL_END
