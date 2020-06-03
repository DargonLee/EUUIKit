//
//  NSTimer+EUFD.h
//  EUUIKit
//
//  Created by Harlans on 2020/6/3.
//  Copyright © 2020 Harlans. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (EUFD)

/**
 分类解决NSTimer在使用时造成的循环引用的问题

 @param interval 间隔时间
 @param block    回调
 @param repeats  用于设置定时器是否重复触发
 @return 返回NSTimer实体
 */
+ (NSTimer *)block_TimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)((void)))block repeats:(BOOL)repeats;

@end
/* 使用方式
 __weak typeof(self) weakSelf = self;    //避免 block 强引用 self
 self.timer = [NSTimer block_TimerWithTimeInterval:3 block:^{
 //    [weakSelf dosomething];
 } repeats:YES];
 */
NS_ASSUME_NONNULL_END
