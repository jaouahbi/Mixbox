#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef void(^MBAnimationDelegateProxyOnAnimationDidStart)(CAAnimation * _Nullable animation);
typedef void(^MBAnimationDelegateProxyOnAnimationDidStop)(CAAnimation * _Nullable animation, BOOL finished);

@interface MBBlockAnimationDelegate: NSObject<CAAnimationDelegate>

- (_Nonnull instancetype)initWithOnAnimationDidStart:(_Nonnull MBAnimationDelegateProxyOnAnimationDidStart)onAnimationDidStart
                                  onAnimationDidStop:(_Nonnull MBAnimationDelegateProxyOnAnimationDidStop)onAnimationDidStop;

- (void)animationDidStart:(CAAnimation * _Nullable)animation;
- (void)animationDidStop:(CAAnimation * _Nullable)animation finished:(BOOL)finished;

@end
