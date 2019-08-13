//
//  EUEmptyView.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/21.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUEmptyView.h"
#import "UIView+EUUI.h"
#import "EUUICore.h"

@interface EUEmptyView ()

@property (nonatomic, weak) UIActivityIndicatorView * indicatorView;

@property (nonatomic, weak) UIImageView *loadingImageView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *detailLabel;

@property (nonatomic, weak) UIButton *button;

@end

@implementation EUEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self initialized];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        [self initialized];
    }
    return self;
}

- (void)initialized
{
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UIActivityIndicatorView * indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.hidden = YES;
    indicatorView.color = EmptyViewIndicatorViewColor;
    [self addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    UIImageView *loadingImageView = [[UIImageView alloc]init];
    loadingImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:loadingImageView];
    self.loadingImageView = loadingImageView;

    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = EmptyViewTitleLabelColor;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;

    UILabel *detailLabel = [[UILabel alloc]init];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.numberOfLines = 0;
    detailLabel.font = [UIFont systemFontOfSize:13];
    detailLabel.textColor = EmptyViewDetailLabelColor;
    [self addSubview:detailLabel];
    self.detailLabel = detailLabel;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:EmptyViewButtonTextColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(reloadClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    self.button = button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.indicatorView.centerX = self.centerX;
    self.indicatorView.centerY = self.centerY;
    
    self.titleLabel.width = self.width - 40;
    self.titleLabel.height = 30;
    self.titleLabel.centerX = self.centerX;
    self.titleLabel.centerY = self.centerY;
    if (self.loadingImageView.image == nil) {
        self.titleLabel.centerY = self.centerY - 50;
    }
    
    self.loadingImageView.width = 100;
    self.loadingImageView.height = 100;
    self.loadingImageView.centerX = self.centerX;
    self.loadingImageView.centerY = self.centerY - 60;
    
    self.detailLabel.width = self.titleLabel.width;
    [self.detailLabel sizeToFit];
    self.detailLabel.centerX = self.centerX;
    self.detailLabel.y = self.titleLabel.bottom + 5;
    
    self.button.y = self.detailLabel.bottom + 5;
    [self.button sizeToFit];
    self.button.centerX = self.centerX;

}

- (void)reloadClick:(UIButton *)button
{
    if (self.didClcikReloadAction) {
        self.didClcikReloadAction(self, button);
    }
}

#pragma mark---------------------------Public--------------------------------

- (void)setTextLabelColor:(UIColor *)textLabelColor
{
    _textLabelColor = textLabelColor;
    self.titleLabel.textColor = textLabelColor;
}

- (void)setDetailLabelColor:(UIColor *)detailLabelColor
{
    _detailLabelColor = detailLabelColor;
    self.detailLabel.textColor = detailLabelColor;
}

- (void)setLoadingViewHide:(BOOL)hidden
{
    if (hidden) {
        self.indicatorView.hidden = YES;
        [self.indicatorView stopAnimating];
        self.loadingImageView.hidden = NO;
        self.titleLabel.hidden = NO;
        self.detailLabel.hidden = NO;
        self.button.hidden = NO;
    }else {
        self.indicatorView.hidden = NO;
        [self.indicatorView startAnimating];
        self.loadingImageView.hidden = YES;
        self.titleLabel.hidden = YES;
        self.detailLabel.hidden = YES;
        self.button.hidden = YES;
    }
}
- (void)setImage:(UIImage *)image
{
    self.loadingImageView.image = image;
    [self setNeedsLayout];
}

- (void)setTextLabelText:(NSString *)text
{
    self.titleLabel.text = text;
    [self setNeedsLayout];
}

- (void)setDetailTextLabelText:(NSString *)text
{
    self.detailLabel.text = text;
    [self setNeedsLayout];
}

- (void)setActionButtonTitle:(NSString *)title
{
    [self.button setTitle:title forState:UIControlStateNormal];
    [self setNeedsLayout];
}

@end
