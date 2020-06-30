import Emcee
import Foundation
import CiFoundation
import Bash
import SingletonHell
import Models
import RemoteFiles
import Destinations

public final class EmceeGrayBoxTestRunner: GrayBoxTestRunner {
    private let emceeProvider: EmceeProvider
    private let temporaryFileProvider: TemporaryFileProvider
    private let bashExecutor: BashExecutor
    private let queueServerRunConfigurationUrl: URL
    private let sharedQueueDeploymentDestinationsUrl: URL
    private let testArgFileJsonGenerator: TestArgFileJsonGenerator
    private let fileDownloader: FileDownloader
    private let environmentProvider: EnvironmentProvider
    
    public init(
        emceeProvider: EmceeProvider,
        temporaryFileProvider: TemporaryFileProvider,
        bashExecutor: BashExecutor,
        queueServerRunConfigurationUrl: URL,
        sharedQueueDeploymentDestinationsUrl: URL,
        testArgFileJsonGenerator: TestArgFileJsonGenerator,
        fileDownloader: FileDownloader,
        environmentProvider: EnvironmentProvider)
    {
        self.emceeProvider = emceeProvider
        self.temporaryFileProvider = temporaryFileProvider
        self.bashExecutor = bashExecutor
        self.queueServerRunConfigurationUrl = queueServerRunConfigurationUrl
        self.sharedQueueDeploymentDestinationsUrl = sharedQueueDeploymentDestinationsUrl
        self.testArgFileJsonGenerator = testArgFileJsonGenerator
        self.fileDownloader = fileDownloader
        self.environmentProvider = environmentProvider
    }
    
    public func runTests(
        xctestBundle: String,
        appPath: String,
        mixboxTestDestinationConfigurations: [MixboxTestDestinationConfiguration])
        throws
    {
        let emcee = try emceeProvider.emcee()
        
        let reportsPath = try environmentProvider.getOrThrow(env: Env.MIXBOX_CI_REPORTS_PATH)
        let junit = "\(reportsPath)/junit.xml"
        let trace = "\(reportsPath)/trace.json"
        
        try emcee.runTestsOnRemoteQueue(
            arguments: EmceeRunTestsOnRemoteQueueCommandArguments(
                jobId: UUID().uuidString,
                testArgFile: testArgFile(
                    mixboxTestDestinationConfigurations: mixboxTestDestinationConfigurations,
                    xctestBundle: xctestBundle,
                    appPath: appPath,
                    priority: 500
                ),
                queueServerDestination: fileDownloader.download(url: sharedQueueDeploymentDestinationsUrl),
                queueServerRunConfigurationLocation: queueServerRunConfigurationUrl.absoluteString,
                tempFolder: temporaryFileProvider.temporaryFilePath(),
                junit: junit,
                trace: trace
            )
        )
    }
    
    private func testArgFile(
        mixboxTestDestinationConfigurations: [MixboxTestDestinationConfiguration],
        xctestBundle: String,
        appPath: String,
        priority: UInt)
        throws
        -> String
    {
        return try testArgFileJsonGenerator.testArgFile(
            arguments: TestArgFileGeneratorArguments(
                runnerPath: nil,
                appPath: appPath,
                additionalAppPaths: [],
                xctestBundlePath: xctestBundle,
                mixboxTestDestinationConfigurations: mixboxTestDestinationConfigurations,
                environment: environment(),
                testType: .appTest,
                testDiscoveryMode: .parseFunctionSymbols,
                priority: priority
            )
        )
    }
    
    private func environment() -> [String: String] {
        return [
            Env.MIXBOX_IPC_STARTER_TYPE.rawValue: "graybox",
            Env.MIXBOX_CI_USES_FBXCTEST.rawValue: "true",
            Env.MIXBOX_CI_IS_CI_BUILD.rawValue: "true"
        ]
    }
}
