import MixboxTestsFoundation
import MixboxUiTestsFoundation
import MixboxBlack
import SBTUITestTunnel

public final class LaunchableApplicationProvider {
    public var launchableApplication: LaunchableApplication {
        return reusedLaunchableApplication()
            ?? createLaunchableApplication()
    }
    
    private let applicationLifecycleObservable: ApplicationLifecycleObservable & ApplicationLifecycleObserver
    private let testFailureRecorder: TestFailureRecorder
    private let bundleResourcePathProvider: BundleResourcePathProvider
    private let waiter: RunLoopSpinningWaiter
    
    public init(
        applicationLifecycleObservable: ApplicationLifecycleObservable & ApplicationLifecycleObserver,
        testFailureRecorder: TestFailureRecorder,
        bundleResourcePathProvider: BundleResourcePathProvider,
        waiter: RunLoopSpinningWaiter)
    {
        self.applicationLifecycleObservable = applicationLifecycleObservable
        self.testFailureRecorder = testFailureRecorder
        self.bundleResourcePathProvider = bundleResourcePathProvider
        self.waiter = waiter
    }
    
    private var launchableApplicationWasCreatedWithBuiltinIpc = false
    private var launchableApplicationOrNil: LaunchableApplication?
    
    private func reusedLaunchableApplication() -> LaunchableApplication? {
        guard let launchableApplication = launchableApplicationOrNil else {
            return nil
        }
            
        return launchableApplication
    }
    
    private func createLaunchableApplication() -> LaunchableApplication {
        let launchableApplication = SbtuiLaunchableApplication(
            tunneledApplication: SBTUITunneledApplication(),
            applicationLifecycleObservable: applicationLifecycleObservable,
            testFailureRecorder: testFailureRecorder,
            bundleResourcePathProvider: bundleResourcePathProvider,
            waiter: waiter,
            networkReplayingObserver: DummyNetworkReplayingObserver()
        )
        
        launchableApplicationOrNil = launchableApplication
        
        return launchableApplication
    }
}
