import Git
import Foundation

public final class GemfileLocationProviderImpl: GemfileLocationProvider {
    private let repoRootProvider: RepoRootProvider
    private let gemfileBasename: String
    
    public init(
        repoRootProvider: RepoRootProvider,
        gemfileBasename: String)
    {
        self.repoRootProvider = repoRootProvider
        self.gemfileBasename = gemfileBasename
    }
    
    public func gemfileLocation() throws -> String {
        return try repoRootProvider
            .repoRootPath()
            .mb_appending(pathComponents: ["ci", "gemfiles", gemfileBasename])
    }
}
