import CiFoundation
import Git

public final class MixboxTestDestinationConfigurationsProviderImpl: MixboxTestDestinationConfigurationsProvider {
    private let decodableFromJsonFileLoader: DecodableFromJsonFileLoader
    private let destinationFileBaseName: String
    private let repoRootProvider: RepoRootProvider
    
    public init(
        decodableFromJsonFileLoader: DecodableFromJsonFileLoader,
        destinationFileBaseName: String,
        repoRootProvider: RepoRootProvider)
    {
        self.decodableFromJsonFileLoader = decodableFromJsonFileLoader
        self.destinationFileBaseName = destinationFileBaseName
        self.repoRootProvider = repoRootProvider
    }
    
    public func mixboxTestDestinationConfigurations() throws -> [MixboxTestDestinationConfiguration] {
        let fullPath = try repoRootProvider.repoRootPath().mb_appending(
            pathComponents: ["ci", "destinations", destinationFileBaseName]
        )
        
        return try decodableFromJsonFileLoader.load(path: fullPath)
    }
}
