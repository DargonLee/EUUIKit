//
//  EUTimer.m
//  EUUIKit
//
//  Created by Harlan on 2019/11/17.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUTimer.h"

static NSMutableDictionary *__timers;
dispatch_semaphore_t __semaphore;
@implementation EUTimer

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __timers = [NSMutableDictionary dictionary];
        __semaphore = dispatch_semaphore_create(1);
    });
}

+ (NSString *)exexTask:(void(^)(void))task
           start:(NSTimeInterval)start
        interval:(NSTimeInterval)interval
         repeats:(BOOL)repeats
           async:(BOOL)async
{
    if (!task || start < 0 || (interval <= 0 && repeats)) { return nil; }
    //队列
    dispatch_queue_t queue = async ? dispatch_queue_create("timer", DISPATCH_QUEUE_SERIAL) : dispatch_get_main_queue();
    //创建一个定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //第一个参数 DISPATCH_TIME_NOW 什么时候开始执行
    //第二个参数 1.0 * NSEC_PER_SEC 设置时间间隔
    //第三个参数 设置误差 一般设置为0
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    
    // 加锁
    dispatch_semaphore_wait(__semaphore, DISPATCH_TIME_FOREVER);
    //定时器的唯一标识
    NSString *name = [NSString stringWithFormat:@"%zd",__timers.count];
    //保存定时器
    __timers[name] = timer;
    //解锁
    dispatch_semaphore_signal(__semaphore);
    
    //设置回调
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) {
            [self cancelTask:name];
        }
    });
    
    //启动定时器
    dispatch_resume(timer);
    
    return name;
}

+ (NSString *)exexTask:(id)target selector:(SEL)selector start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async
{
    if (!target || !selector) return nil;
    return [self exexTask:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if ([target respondsToSelector:selector]) {
            [target performSelector:selector];
        }
#pragma clang diagnostic pop
    } start:start interval:interval repeats:repeats async:async];
}

+ (void)cancelTask:(NSString *)name
{
    if (name.length == 0) return;
    dispatch_semaphore_wait(__semaphore, DISPATCH_TIME_FOREVER);
    dispatch_source_t timer = __timers[name];
    if (timer) {
        dispatch_source_cancel(timer);
        [__timers removeObjectForKey:name];
    }
    dispatch_semaphore_signal(__semaphore);
}

@end
