#if MIXBOX_ENABLE_IN_APP_SERVICES

import MixboxIpc
import MixboxFoundation

public final class RunLoopSpinningSynchronousIpcClientFactory: SynchronousIpcClientFactory {
    private let runLoopSpinningWaiter: RunLoopSpinningWaiter
    private let defaultTimeout: TimeInterval
    
    public init(
        runLoopSpinningWaiter: RunLoopSpinningWaiter,
        defaultTimeout: TimeInterval)
    {
        self.runLoopSpinningWaiter = runLoopSpinningWaiter
        self.defaultTimeout = defaultTimeout
    }
    
    public func synchronousIpcClient(ipcClient: IpcClient) -> SynchronousIpcClient {
        return RunLoopSpinningSynchronousIpcClient(
            ipcClient: ipcClient,
            runLoopSpinningWaiter: runLoopSpinningWaiter,
            defaultTimeout: defaultTimeout
        )
    }
}

#endif
