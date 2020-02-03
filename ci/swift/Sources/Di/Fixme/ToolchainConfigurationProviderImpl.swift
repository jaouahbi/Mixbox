import Emcee
import Models

public final class ToolchainConfigurationProviderImpl: ToolchainConfigurationProvider {
    private let xcodeCFBundleShortVersionString: String
    
    public init(xcodeCFBundleShortVersionString: String) {
        self.xcodeCFBundleShortVersionString = xcodeCFBundleShortVersionString
    }
    
    public func toolchainConfiguration() throws -> ToolchainConfiguration {
        return ToolchainConfiguration(
            developerDir: .useXcode(CFBundleShortVersionString: xcodeCFBundleShortVersionString)
        )
    }
}
