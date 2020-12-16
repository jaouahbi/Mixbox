// Note: some worthy reading about difference between Any.Type and Any.Protocol:
// https://stackoverflow.com/questions/45234233/why-cant-i-pass-a-protocol-type-to-a-generic-t-type-parameter
//
public final class MockInfo {
    public let mockedType: Any.Type
    
    public init(
        mockedType: Any.Type)
    {
        self.mockedType = mockedType
    }
}
