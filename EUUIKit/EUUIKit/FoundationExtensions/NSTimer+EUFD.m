//
//  NSTimer+EUFD.m
//  EUUIKit
//
//  Created by Harlans on 2020/6/3.
//  Copyright © 2020 Harlans. All rights reserved.
//

#import "NSTimer+EUFD.h"

@implementation NSTimer (EUFD)

+ (NSTimer *)block_TimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)(void))block repeats:(BOOL)reqeats
{
    return [self timerWithTimeInterval:interval target:self selector:@selector(blockSelector:) userInfo:[block copy] repeats:reqeats];
}

+ (void) blockSelector:(NSTimer *)timer
{
    void (^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}

@end
