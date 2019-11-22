import XCTest
import MixboxBlack
import MixboxTestsFoundation
import MixboxUiTestsFoundation

class TestCase: XCTestCase {
    var lazilyInitializedIpcClient: LazilyInitializedIpcClient {
       return dependencies.resolve()
    }
    
    var launchableApplicationProvider: LaunchableApplicationProvider {
        return dependencies.resolve()
    }
    
    var pageObjects: PageObjects {
       return dependencies.resolve()
    }
    
    private(set) lazy var dependencies: TestCaseDependenciesResolver = makeDependencies()
    
    private var bundleResourcePathProviderForTestsTarget: BundleResourcePathProvider {
        return BundleResourcePathProviderImpl(
            bundle: Bundle(for: TestCase.self)
        )
    }
    
    private func makeDependencies() -> TestCaseDependenciesResolver {
        TestCaseDependenciesResolver(
            registerer: BlackBoxTestCaseDependencies(
                bundleResourcePathProviderForTestsTarget: bundleResourcePathProviderForTestsTarget
            )
        )
    }
    
    func launch(environment: [String: String] = [:]) {
        let commonEnvironment: [String: String] = [:] // insert your default envs here
        
        var mergedEnvironment = commonEnvironment
        
        for (key, value) in environment {
            mergedEnvironment[key] = value
        }
        
        let launchedApplication = launchableApplicationProvider
            .launchableApplication
            .launch(arguments: [], environment: mergedEnvironment)
        
        lazilyInitializedIpcClient.ipcClient = launchedApplication.ipcClient
    }
}
