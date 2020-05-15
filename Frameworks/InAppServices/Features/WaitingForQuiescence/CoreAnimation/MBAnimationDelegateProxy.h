#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "MBBlockAnimationDelegate.h"

// The proxy is used to track state of CAAnimation.
// Implementing it purely in Swift using only two methods is risky, some implementations
// may use downcasts and use additional methods (also it just didn't work).
// This proxy is implemented in Objective-C, because there is no trivial way (possibly no way) to implement it in Swift.
@interface MBAnimationDelegateProxy: NSProxy<CAAnimationDelegate>

- (_Nonnull instancetype)initWithOriginalDelegate:(_Nullable id<CAAnimationDelegate>)originalDelegate
                              onAnimationDidStart:(_Nonnull MBAnimationDelegateProxyOnAnimationDidStart)onAnimationDidStart
                               onAnimationDidStop:(_Nonnull MBAnimationDelegateProxyOnAnimationDidStop)onAnimationDidStop;

+ (_Nullable id<CAAnimationDelegate>)unwrapDelegate:(_Nullable id<CAAnimationDelegate>)delegate;

@end
