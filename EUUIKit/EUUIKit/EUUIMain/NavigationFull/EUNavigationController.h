//
//  EUNavigationController.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/10.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EUNavigationController : UINavigationController

@property(strong,nonatomic) UIScreenEdgePanGestureRecognizer *panGestureRec;

@property (nonatomic,strong) UIColor *navTintColor;

@property (nonatomic,strong) UIFont *navTintFont;

@property (nonatomic,strong) UIColor *itemTintColor;

@property (nonatomic,strong) UIFont *itemTintFont;

@property (nonatomic,strong) NSString *backImageName;

@end

NS_ASSUME_NONNULL_END
