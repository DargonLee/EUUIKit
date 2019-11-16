//
//  EUProxy.m
//  EUUIKit
//
//  Created by Harlan on 2019/11/16.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUProxy.h"

@implementation EUProxy

+ (instancetype)proxyWithTarget:(id)target
{
    // NSProxy 不需要init方法
    EUProxy *proxy = [EUProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}


@end
