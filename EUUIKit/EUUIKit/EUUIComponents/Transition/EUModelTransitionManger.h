//
//  EUModelTransitionManger.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/24.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM (NSUInteger, EUModalTransitionType){
    EUModalTransitionTypePop,
};


@interface EUModelTransitionManger : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) EUModalTransitionType transitionType;


@end

NS_ASSUME_NONNULL_END
