final class CAAnimationDelegateWrapper {
    static func wrappedDelegate(
        originalDelegate: CAAnimationDelegate?,
        onAnimationDidStart: @escaping MBAnimationDelegateProxyOnAnimationDidStart,
        onAnimationDidStop: @escaping MBAnimationDelegateProxyOnAnimationDidStop)
        -> CAAnimationDelegate?
    {
        return MBAnimationDelegateProxy(
            originalDelegate: MBAnimationDelegateProxy.unwrapDelegate(originalDelegate),
            onAnimationDidStart: onAnimationDidStart,
            onAnimationDidStop: onAnimationDidStop
        )
    }
}
