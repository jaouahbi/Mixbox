// These declaration duplicate interface of Cuckoo,
// they are not set in stone and are just for compatibility during migration period.

public func stub<M: Mock>(_ mock: M, block: (M.StubbingBuilder) -> ()) {
    block(mock.stub())
}

public func when<Arguments, ReturnType>(
    _ stubbingFunctionBuilder: StubbingFunctionBuilder<Arguments, ReturnType>)
    -> StubbingFunctionBuilder<Arguments, ReturnType>
{
    stubbingFunctionBuilder
}

extension Mock {
    public static func stub<M: Mock>(_ mock: M, block: (M.StubbingBuilder) -> ()) {
        stub(mock, block: block)
    }
}

public func anyClosure<MatchingType>() -> FunctionalMatcher<MatchingType> {
    return any()
}
