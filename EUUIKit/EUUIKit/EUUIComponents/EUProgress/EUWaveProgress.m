//
//  EUWaveProgress.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/15.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUWaveProgress.h"
#import "EUUICore.h"

@interface EUWaveProgress ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat wave_amplitude;//振幅a（y = asin(wx+φ) + k）
@property (nonatomic, assign) CGFloat wave_cycle;//周期w
@property (nonatomic, assign) CGFloat wave_h_distance;//两个波水平之间偏移
@property (nonatomic, assign) CGFloat wave_v_distance;//两个波竖直之间偏移
@property (nonatomic, assign) CGFloat wave_scale;//水波速率
@property (nonatomic, assign) CGFloat wave_offsety;//波峰所在位置的y坐标
@property (nonatomic, assign) CGFloat wave_move_width;//移动的距离，配合速率设置
@property (nonatomic, assign) CGFloat wave_offsetx;//偏移
@property (nonatomic, assign) CGFloat offsety_scale;//上升的速度

@end

@implementation EUWaveProgress

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        //初始化信息
        [self initialized];
    }
    
    return self;
}

- (void)initialized
{
    //进度
    _progress = 0;
    //振幅
    _wave_amplitude = self.frame.size.height / 25;
    //周期
    _wave_cycle = 2 * M_PI / (self.frame.size.width * 0.9);
    //两个波水平之间偏移
    _wave_h_distance = 2 * M_PI / _wave_cycle * 0.6;
    //两个波竖直之间偏移
    _wave_v_distance = _wave_amplitude * 0.4;
    //移动的距离，配合速率设置
    _wave_move_width = 0.5;
    //水波速率
    _wave_scale = 0.4;
    //上升的速度
    _offsety_scale = 0.1;
    //波峰所在位置的y坐标，刚开始的时候_wave_offsety是最大值
    _wave_offsety = (1 - _progress) * (self.frame.size.height + 2 * _wave_amplitude);
    
    self.fillColor = [UIColor groupTableViewBackgroundColor];
    self.waveTopColor = ProgressWaveTopColor;
    self.waveBottomColor = ProgressWaveBottomColor;
    
    [self addDisplayLinkAction];
}

- (void)addDisplayLinkAction
{
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)displayLinkAction
{
    _wave_offsetx += _wave_move_width * _wave_scale;
    
    //完成
    if (_wave_offsety <= 0.01)  [self removeDisplayLinkAction];
    
    [self setNeedsDisplay];
}

- (void)removeDisplayLinkAction
{
    [_displayLink invalidate];
    _displayLink = nil;
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [self.fillColor setFill];
    [path fill];
    [path addClip];
    
    //绘制两个波形图
    [self drawWaveColor:self.waveTopColor offsetx:0 offsety:0];
    [self drawWaveColor:self.waveBottomColor offsetx:_wave_h_distance offsety:_wave_v_distance];
}

- (void)drawWaveColor:(UIColor *)color offsetx:(CGFloat)offsetx offsety:(CGFloat)offsety
{
    //波浪动画，进度的实际操作范围是，多加上两个振幅的高度，到达设置进度的位置y
    CGFloat end_offY = (1 - _progress) * (self.frame.size.height + 2 * _wave_amplitude);
    if (_wave_offsety != end_offY) {
        if (end_offY < _wave_offsety) {
            _wave_offsety = MAX(_wave_offsety -= (_wave_offsety - end_offY) * _offsety_scale, end_offY);
        }else {
            _wave_offsety = MIN(_wave_offsety += (end_offY - _wave_offsety) * _offsety_scale, end_offY);
        }
    }
    
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    for (float next_x = 0.f; next_x <= self.frame.size.width; next_x ++) {
        //正弦函数，绘制波形
        CGFloat next_y = _wave_amplitude * sin(_wave_cycle * next_x + _wave_offsetx + offsetx / self.bounds.size.width * 2 * M_PI) + _wave_offsety + offsety;
        if (next_x == 0) {
            [wavePath moveToPoint:CGPointMake(next_x, next_y - _wave_amplitude)];
        }else {
            [wavePath addLineToPoint:CGPointMake(next_x, next_y - _wave_amplitude)];
        }
    }
    
    [wavePath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [wavePath addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [color set];
    [wavePath fill];
}

@end
