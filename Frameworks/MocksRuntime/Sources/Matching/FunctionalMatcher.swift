import Foundation

public final class FunctionalMatcher<T>: Matcher {
    public typealias MatchingType = T
    
    private let matchingFunction: (T) -> Bool
    
    public init(matchingFunction: @escaping (T) -> Bool) {
        self.matchingFunction = matchingFunction
    }
    
    public init<U: Matcher>(matcher: U) where U.MatchingType == T {
        self.matchingFunction = matcher.valueIsMatching
    }
    
    public func valueIsMatching(_ value: MatchingType) -> Bool {
        return matchingFunction(value)
    }
}

extension FunctionalMatcher {
    public func byErasingType() -> FunctionalMatcher<Any> {
        return FunctionalMatcher<Any>(
            matchingFunction: { arguments in
                if let argumentsAsT = arguments as? MatchingType {
                    return self.valueIsMatching(argumentsAsT)
                } else {
                    return false
                }
            }
        )
    }
}

public func any<T>() -> FunctionalMatcher<T> {
    return FunctionalMatcher<T> { _ in true }
}

public func none<T>() -> FunctionalMatcher<T> {
    return FunctionalMatcher<T> { _ in false }
}

public func equals<T>(_ value: T) -> FunctionalMatcher<T> where T: Equatable {
    return FunctionalMatcher<T> { other in value == other }
}

public func isSame<T>(_ value: T) -> FunctionalMatcher<T> where T: AnyObject {
    return FunctionalMatcher<T> { other in value === other }
}

public func isSame(_ value: AnyObject.Type) -> FunctionalMatcher<AnyObject.Type> {
    return FunctionalMatcher<AnyObject.Type> { other in value === other }
}

public func isSame(_ value: NSObject.Type) -> FunctionalMatcher<NSObject.Type> {
    return FunctionalMatcher<NSObject.Type> { other in value === other }
}

public func atLeast<T>(_ atLeast: T) -> FunctionalMatcher<T> where T: Comparable {
    return FunctionalMatcher<T> { given in given >= atLeast }
}

public func atMost<T>(_ atLeast: T) -> FunctionalMatcher<T> where T: Comparable {
    return FunctionalMatcher<T> { given in given <= atLeast }
}
