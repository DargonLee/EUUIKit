//
//  EUUIButton.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/14.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUUIButton.h"
#import "UIView+EUUI.h"
#import "EUUICore.h"


@implementation EUUIButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self configInitialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        [self configInitialize];
    }
    return self;
}

+ (instancetype)buttonWithImagePositionType:(EUUIButtonImagePosition)buttonType
{
    EUUIButton *button = [[EUUIButton alloc]initWithFrame:CGRectZero];
    button.imagePosition = buttonType;
    return button;
}

- (void)configInitialize
{
    self.imagePosition = EUUIButtonImagePositionLeft;
    self.spacingBetweenImageAndTitle = 5;
}

- (void)setImageName:(NSString *)imageName title:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)setImagePosition:(EUUIButtonImagePosition)imagePosition
{
    _imagePosition = imagePosition;
    [self setNeedsLayout];
}

- (void)setSpacingBetweenImageAndTitle:(CGFloat)spacingBetweenImageAndTitle
{
    _spacingBetweenImageAndTitle = spacingBetweenImageAndTitle;
    [self setNeedsLayout];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.alpha = 0.5f;
    }else{
        self.alpha = 1.0f;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (CGRectIsEmpty(self.bounds)) { return; }
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    switch (self.imagePosition) {
        case EUUIButtonImagePositionLeft:
        {
            self.imageView.x = self.width * 0.5 - (self.titleLabel.width + self.spacingBetweenImageAndTitle + self.imageView.width) * 0.5;
            self.imageView.y = (self.height - self.imageView.height) * 0.5;
            self.titleLabel.x = self.spacingBetweenImageAndTitle + self.imageView.right;
            self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
        }
            break;
        case EUUIButtonImagePositionTop:
        {
            self.imageView.y = self.height * 0.5 - (self.imageView.height + self.titleLabel.height + self.spacingBetweenImageAndTitle) * 0.5;
            self.imageView.centerX = self.width * 0.5;
            self.titleLabel.y = self.imageView.bottom + self.spacingBetweenImageAndTitle;
            self.titleLabel.centerX = self.width * 0.5;
            CGFloat height = self.height - self.spacingBetweenImageAndTitle;
            self.imageView.height = self.imageView.width = height * 0.6;
            self.titleLabel.height = height * 0.4;
        }
            break;
        case EUUIButtonImagePositionBottom:
        {
            self.titleLabel.y = self.height * 0.5 - (self.imageView.height + self.titleLabel.height + self.spacingBetweenImageAndTitle) * 0.5;
            self.titleLabel.centerX = self.width * 0.5;
            self.imageView.y = self.titleLabel.bottom + self.spacingBetweenImageAndTitle;
            self.imageView.centerX = self.width * 0.5;
            CGFloat height = self.height - self.spacingBetweenImageAndTitle;
            self.imageView.height = self.imageView.width = height * 0.6;
            self.titleLabel.height = height * 0.4;
        }
            break;
        case EUUIButtonImagePositionRight:
        {
            self.titleLabel.x = self.width * 0.5 - (self.titleLabel.width + self.spacingBetweenImageAndTitle + self.imageView.width) * 0.5;
            self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
            self.imageView.x = self.titleLabel.x + self.titleLabel.width + self.spacingBetweenImageAndTitle;
            self.imageView.y = (self.height - self.imageView.height) * 0.5;
        }
            break;
            
        default:
            break;
    }

}

@end
