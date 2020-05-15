#if MIXBOX_ENABLE_IN_APP_SERVICES

import MixboxFoundation
import UIKit
import MixboxUiKit

// Rewritten from Objective-C to Swift:
// https://github.com/google/EarlGrey/blob/91c27bb8a15e723df974f620f7f576a30a6a7484/EarlGrey/Additions/CAAnimation%2BGREYAdditions.m
//
final class CAAnimationIdlingSupport {
    private let assertingSwizzler: AssertingSwizzler
    
    init(assertingSwizzler: AssertingSwizzler) {
        self.assertingSwizzler = assertingSwizzler
    }
    
    func swizzle() {
        swizzle(
            originalSelector: #selector(setter: CAAnimation.delegate),
            swizzledSelector: #selector(CAAnimation.mbswizzled_setDelegate(_:))
        )
        
        swizzle(
            originalSelector: #selector(getter: CAAnimation.delegate),
            swizzledSelector: #selector(CAAnimation.mbswizzled_delegate)
        )
    }
    
    private func swizzle(
        class: NSObject.Type = CAAnimation.self,
        originalSelector: Selector,
        swizzledSelector: Selector
    ) {
        assertingSwizzler.swizzle(
            class: `class`,
            originalSelector: originalSelector,
            swizzledSelector: swizzledSelector,
            methodType: .instanceMethod,
            shouldAssertIfMethodIsSwizzledOnlyOneTime: true
        )
    }
}

extension CAAnimation {
    @objc fileprivate func mbswizzled_setDelegate(_ delegate: CAAnimationDelegate?) {
        let delegate = wrappedDelegate(
            originalDelegate: delegate
        )
        
        // It's safe to store delegate, because proxy holds original delegate weakly
        proxyDelegateHolder.value = delegate
        
        mbswizzled_setDelegate(delegate)
    }
    
    @objc fileprivate func mbswizzled_delegate() -> CAAnimationDelegate? {
        return wrappedDelegate(
            originalDelegate: mbswizzled_delegate()
        )
    }
    
    private func wrappedDelegate(originalDelegate: CAAnimationDelegate?) -> CAAnimationDelegate? {
        return CAAnimationDelegateWrapper.wrappedDelegate(
            originalDelegate: originalDelegate,
            onAnimationDidStart: { animation in
                animation?.mb_state = .started
            },
            onAnimationDidStop: { animation, _ in
                animation?.mb_state = .stopped
            }
        )
    }
    
    var mb_state: CAAnimationState {
        set {
            stateAssociatedValue.value = newValue
            
            switch newValue {
            case .started:
                mb_trackForDurationOfAnimation()
            case .stopped:
                mb_untrack()
            case .pendingStart:
                break
            }
        }
        get {
            return stateAssociatedValue.value
        }
    }
    
    @objc func mb_trackForDurationOfAnimation() {
        animationTrackedIdlingResource.value = IdlingResourceObjectTracker.instance.track(parent: self)

        var animRuntimeTime = duration + Double(repeatCount) * duration + repeatDuration
        
        // Add extra padding to the animation runtime just as a safeguard. This comes into play when
        // animatonDidStop delegate is not invoked before the expected end-time is reached.
        // The state is then automatically cleared for this animation as it should have finished by now.
        animRuntimeTime += min(animRuntimeTime, 1.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animRuntimeTime) {
            self.mb_untrack()
        }
    }
    
    func mb_untrack() {
        animationTrackedIdlingResource.value?.untrack()
    }
    
    private var proxyDelegateHolder: AssociatedObject<CAAnimationDelegate> {
        return AssociatedObject(container: self, key: #function)
    }
    
    private var animationTrackedIdlingResource: AssociatedObject<TrackedIdlingResource> {
        return AssociatedObject(container: self, key: #function)
    }
    
    private var stateAssociatedValue: AssociatedValue<CAAnimationState> {
        return AssociatedValue(container: self, key: #function, defaultValue: .pendingStart)
    }
}

#endif
