#import "MBBlockAnimationDelegate.h"

@implementation MBBlockAnimationDelegate {
    MBAnimationDelegateProxyOnAnimationDidStart onAnimationDidStart;
    MBAnimationDelegateProxyOnAnimationDidStop onAnimationDidStop;
}

#pragma mark - Init

- (_Nonnull instancetype)initWithOnAnimationDidStart:(_Nonnull MBAnimationDelegateProxyOnAnimationDidStart)onAnimationDidStart
                                  onAnimationDidStop:(_Nonnull MBAnimationDelegateProxyOnAnimationDidStop)onAnimationDidStop
{
    self->onAnimationDidStart = [onAnimationDidStart copy];
    self->onAnimationDidStop = [onAnimationDidStop copy];
    
    return self;
}

- (void)animationDidStart:(CAAnimation * _Nullable)animation {
    onAnimationDidStart(animation);
}

- (void)animationDidStop:(CAAnimation * _Nullable)animation finished:(BOOL)finished {
    onAnimationDidStop(animation, finished);
}

@end
