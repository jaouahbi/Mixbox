import MixboxDi
import MixboxFoundation
import MixboxUiKit

public final class MixboxTestsFoundationDependencies: DependencyCollectionRegisterer {
    private let stepLogger: StepLogger
    private let enableXctActivityLogging: Bool
    
    public init(
        // You can attach your external logging by injecting `StepLoggerImpl` here.
        stepLogger: StepLogger,
        // If `true` is passed then you will see logs in Xcode IDE.
        // Note that it may break tests if you are using fbxctest for running tests.
        enableXctActivityLogging: Bool)
    {
        self.stepLogger = stepLogger
        self.enableXctActivityLogging = enableXctActivityLogging
    }
    
    // swiftlint:disable:next function_body_length
    public func register(dependencyRegisterer di: DependencyRegisterer) {
        di.register(type: ExtendedStackTraceProvider.self) { di in
            ExtendedStackTraceProviderImpl(
                stackTraceProvider: try di.resolve(),
                extendedStackTraceEntryFromCallStackSymbolsConverter: try di.resolve()
            )
        }
        di.register(type: StackTraceProvider.self) { _ in
            StackTraceProviderImpl()
        }
        di.register(type: ExtendedStackTraceEntryFromStackTraceEntryConverter.self) { _ in
            ExtendedStackTraceEntryFromStackTraceEntryConverterImpl()
        }
        di.register(type: NotificationsApplicationPermissionSetterFactory.self) { di in
            AlwaysFailingNotificationsApplicationPermissionSetterFactory(
                testFailureRecorder: try di.resolve()
            )
        }
        di.register(type: PhotoSaver.self) { di in
            PhotoSaverImpl(
                runLoopSpinnerLockFactory: try di.resolve(),
                iosVersionProvider: try di.resolve()
            )
        }
        di.register(type: ApplicationPermissionsSetterFactory.self) { di in
            ApplicationPermissionsSetterFactoryImpl(
                notificationsApplicationPermissionSetterFactory: try di.resolve(),
                tccDbApplicationPermissionSetterFactory: try di.resolve(),
                geolocationApplicationPermissionSetterFactory: try di.resolve()
            )
        }
        di.register(type: TccDbApplicationPermissionSetterFactory.self) { _ in
            TccDbApplicationPermissionSetterFactoryImpl()
        }
        di.register(type: RunLoopSpinnerLockFactory.self) { di in
            RunLoopSpinnerLockFactoryImpl(
                runLoopSpinnerFactory: try di.resolve()
            )
        }
        di.register(type: PhotoStubber.self) { di in
            PhotoStubberImpl(
                stubImagesProvider: try di.resolve(),
                tccDbApplicationPermissionSetterFactory: try di.resolve(),
                photoSaver: try di.resolve() ,
                testFailureRecorder: try di.resolve()
            )
        }
        di.register(type: RunLoopSpinnerFactory.self) { di in
            RunLoopSpinnerFactoryImpl(
                runLoopModesStackProvider: try di.resolve()
            )
        }
        di.register(type: RunLoopModesStackProvider.self) { _ in
            RunLoopModesStackProviderImpl()
        }
        di.register(type: RunLoopSpinningWaiter.self) { di in
            RunLoopSpinningWaiterImpl(
                runLoopSpinnerFactory: try di.resolve()
            )
        }
        di.register(type: Waiter.self) { di in
            try di.resolve() as RunLoopSpinningWaiter
        }
        // TODO: Inject just `XctActivityStepLogger`, because dependenciess can be overriden by user easily.
        di.register(type: StepLogger.self) { [stepLogger, enableXctActivityLogging] di in
            if enableXctActivityLogging {
                return XctActivityStepLogger(
                    originalStepLogger: stepLogger,
                    xctAttachmentsAdder: try di.resolve()
                )
            } else {
                return stepLogger
            }
        }
        di.register(type: TestFailureRecorder.self) { di in
            XcTestFailureRecorder(
                currentTestCaseProvider: try di.resolve(),
                shouldNeverContinueTestAfterFailure: false
            )
        }
        di.register(type: CurrentTestCaseProvider.self) { _ in
            AutomaticCurrentTestCaseProvider()
        }
        di.register(type: XctAttachmentsAdder.self) { _ in
            XctAttachmentsAdderImpl()
        }
        di.register(type: PerformanceLogger.self) { _ in
            NoopPerformanceLogger()
        }
        di.register(type: DateProvider.self) { _ in
            SystemClockDateProvider()
        }
        di.register(type: IosVersionProvider.self) { _ in
            UiDeviceIosVersionProvider(
                uiDevice: UIDevice.current
            )
        }
        di.register(type: CurrentSimulatorFileSystemRootProvider.self) { _ in
            CurrentApplicationCurrentSimulatorFileSystemRootProvider()
        }
        di.register(type: GeolocationApplicationPermissionSetterFactory.self) { di in
            GeolocationApplicationPermissionSetterFactoryImpl(
                testFailureRecorder: try di.resolve(),
                currentSimulatorFileSystemRootProvider: try di.resolve(),
                waiter: try di.resolve(),
                iosVersionProvider: try di.resolve()
            )
        }
        di.register(type: EnvironmentProvider.self) { _ in
            ProcessInfoEnvironmentProvider(
                processInfo: ProcessInfo.processInfo
            )
        }
    }
}