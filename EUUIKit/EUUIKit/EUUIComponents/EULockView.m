//
//  EULockView.m
//  EUUIKit
//
//  Created by Harlans on 2019/6/3.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EULockView.h"
#import "UIView+EUUI.h"


@interface EULockView ()

@property (nonatomic,strong) NSMutableArray *selectedButtons;

@property (nonatomic,assign) CGPoint currentPoint;

@end

@implementation EULockView


- (NSMutableArray *)selectedButtons
{
    if (_selectedButtons == nil) {
        _selectedButtons = [NSMutableArray array];
    }
    return _selectedButtons;
}

- (instancetype)initWithNormalImage:(NSString *)normal selectedImage:(NSString *)selected
{
    if (self == [super init]) {
        [self setupUIWithNormalImageName:normal selectedImageName:selected];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        [self setupUIWithNormalImageName:self.normalImageName selectedImageName:self.selectedImageName];
    }
    return self;
}

- (void)setupUIWithNormalImageName:(NSString *)normal selectedImageName:(NSString *)selected
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGes:)];
    [self addGestureRecognizer:pan];
    self.lineColor = [UIColor orangeColor];
    for (int i = 0; i < 9; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.userInteractionEnabled = NO;
        [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
        [self addSubview:button];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int cols = 3;
    CGFloat width = 80;
    CGFloat height = 80;
    CGFloat margin = (self.bounds.size.width - cols * width)/(cols + 1);
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat col = 0;
    CGFloat row = 0;
    for (int i = 0; i < self.subviews.count; i++) {
        col = i % cols;
        row = i / cols;
        UIButton *button = self.subviews[i];
        x = margin + col * (margin + width);
        y = row * (margin + width);
        button.frame = CGRectMake(x, y, width, height);
    }
    CGFloat h = margin * 2 + 3 * width;
    if (self.height < h) {
        self.height = h;
    }
    
}

- (void)panGes:(UIPanGestureRecognizer *)sender
{
    // 判断触摸点在不在当前view上
    _currentPoint = [sender locationInView:self];
    for (UIButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, _currentPoint) && button.selected == NO) {
            button.selected = YES;
            [self.selectedButtons addObject:button];
        }
    }
    [self setNeedsDisplay];
    if (sender.state == UIGestureRecognizerStateEnded) {
        NSMutableString *pwd = [NSMutableString string];
        //        [self.selectedButtons makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
        for (UIButton *button in self.selectedButtons) {
            [pwd appendString:[NSString stringWithFormat:@"%ld",(long)button.tag]];
            button.selected = NO;
        }
        !self.getGesturePwd ? : self.getGesturePwd(pwd);
        [self.selectedButtons removeAllObjects];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.backgroundColor = [UIColor clearColor];
    if (self.selectedButtons.count == 0) { return ;}
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < self.selectedButtons.count; i++) {
        UIButton *button = self.selectedButtons[i];
        if (i == 0) {
            [path moveToPoint:button.center];
        }else {
            [path addLineToPoint:button.center];
        }
    }
    // 连线到手指的触摸点
    [path addLineToPoint:_currentPoint];
    [self.lineColor set];
    path.lineWidth = self.lineWidth == 0? 10 : self.lineWidth;
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
    
}

@end
