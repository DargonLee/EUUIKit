//
//  EUFeatureItem.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/22.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUFeatureItem.h"

@implementation EUFeatureItem


- (instancetype)initWithFocusView:(UIView *)focusView focusCornerRadius:(CGFloat) focusCornerRadius  focusInsets:(UIEdgeInsets) focusInsets
{
    self = [super init];
    if (self) {
        _focusView = focusView;
        self.focusCornerRadius = focusCornerRadius;
        self.focusInsets = focusInsets;
    }
    
    return self;
}

- (instancetype)initWithFocusRect:(CGRect)rect focusCornerRadius:(CGFloat) focusCornerRadius  focusInsets:(UIEdgeInsets) focusInsets
{
    self = [super init];
    if (self) {
        _focusRect = rect;
        self.focusCornerRadius = focusCornerRadius;
        self.focusInsets = focusInsets;
    }
    return self;
}

@end
