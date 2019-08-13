//
//  UITextField+EUUI.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/22.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "UITextField+EUUI.h"

@implementation UITextField (EUUI)

@end


@implementation UITextField (EU_Shake)

- (void)shake {
    [self shake:10 withDelta:5 completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta {
    [self shake:times withDelta:delta completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta completion:(void(^)(void))handler {
    [self shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:EUShakedDirectionHorizontal completion:handler];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self shake:times withDelta:delta speed:interval completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)(void))handler {
    [self shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:EUShakedDirectionHorizontal completion:handler];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(EUShakedDirection)shakeDirection {
    [self shake:times withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(EUShakedDirection)shakeDirection completion:(void(^)(void))handler {
    [self shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:handler];
}

- (void)shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(EUShakedDirection)shakeDirection completion:(void(^)(void))handler {
    [UIView animateWithDuration:interval animations:^{
        self.transform = (shakeDirection == EUShakedDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (handler) {
                    handler();
                }
            }];
            return;
        }
        [self shake:(times - 1)
              direction:direction * -1
           currentTimes:current + 1
              withDelta:delta
                  speed:interval
         shakeDirection:shakeDirection
             completion:handler];
    }];
}

@end
