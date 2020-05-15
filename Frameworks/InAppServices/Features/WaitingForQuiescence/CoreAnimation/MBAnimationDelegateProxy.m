#import "MBAnimationDelegateProxy.h"
#import <objc/runtime.h>

@implementation MBAnimationDelegateProxy {
    __weak id<CAAnimationDelegate> originalDelegate;
    MBBlockAnimationDelegate *blockAnimationDelegate;
}

#pragma mark - Init

- (_Nonnull instancetype)initWithOriginalDelegate:(_Nullable id<CAAnimationDelegate>)originalDelegate
                              onAnimationDidStart:(_Nonnull MBAnimationDelegateProxyOnAnimationDidStart)onAnimationDidStart
                               onAnimationDidStop:(_Nonnull MBAnimationDelegateProxyOnAnimationDidStop)onAnimationDidStop
{
    self->originalDelegate = originalDelegate;
    self->blockAnimationDelegate = [[MBBlockAnimationDelegate alloc] initWithOnAnimationDidStart:onAnimationDidStart
                                                                              onAnimationDidStop:onAnimationDidStop];
    
    return self;
}

#pragma mark -

+ (_Nullable id<CAAnimationDelegate>)unwrapDelegate:(_Nullable id<CAAnimationDelegate>)delegate {
    if ([delegate class] == [MBAnimationDelegateProxy self]) {
        MBAnimationDelegateProxy *proxy = (MBAnimationDelegateProxy *)delegate;
        
        return [MBAnimationDelegateProxy unwrapDelegate:proxy->originalDelegate];
    }
    
    return delegate;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)animation {
    [blockAnimationDelegate animationDidStart:animation];
    
    if ([originalDelegate respondsToSelector:@selector(animationDidStart:)]) {
        [originalDelegate animationDidStart:animation];
    }
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)finished {
    if ([originalDelegate respondsToSelector:@selector(animationDidStop:finished:)]) {
        [originalDelegate animationDidStop:animation finished:finished];
    }
    
    [blockAnimationDelegate animationDidStop:animation finished:finished];
}

#pragma mark - Proxy

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    if ([originalDelegate respondsToSelector:selector]) {
        return [[originalDelegate class] instanceMethodSignatureForSelector:selector];
    } else if ([blockAnimationDelegate respondsToSelector:selector]) {
        return [[blockAnimationDelegate class] instanceMethodSignatureForSelector:selector];
    }
    
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:originalDelegate];
}

- (BOOL)respondsToSelector:(SEL)selector {
    return [originalDelegate respondsToSelector:selector] || [blockAnimationDelegate respondsToSelector:selector];
}

@end
