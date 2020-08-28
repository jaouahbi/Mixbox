#if MIXBOX_ENABLE_IN_APP_SERVICES

import MixboxIpc
import MixboxFoundation

public final class RunLoopSpinningSynchronousIpcClient: SynchronousIpcClient {
    private let ipcClient: IpcClient
    private let runLoopSpinningWaiter: RunLoopSpinningWaiter
    private let defaultTimeout: TimeInterval
    
    public init(
        ipcClient: IpcClient,
        runLoopSpinningWaiter: RunLoopSpinningWaiter,
        defaultTimeout: TimeInterval)
    {
        self.ipcClient = ipcClient
        self.runLoopSpinningWaiter = runLoopSpinningWaiter
        self.defaultTimeout = defaultTimeout
    }
    
    public func call<Method: IpcMethod>(
        method: Method,
        arguments: Method.Arguments,
        timeout: CustomizableTimeInterval)
        -> DataResult<Method.ReturnValue, Error>
    {
        var result: DataResult<Method.ReturnValue, Error>?
        
        ipcClient.call(method: method, arguments: arguments) { localResult in
            result = localResult
        }
        
        let timeoutValue: TimeInterval
        
        switch timeout {
        case .default:
            timeoutValue = defaultTimeout
        case .custom(let customTimeout):
            timeoutValue = customTimeout
        }
        
        runLoopSpinningWaiter.wait(timeout: timeoutValue, until: { result != nil })
        
        return result ?? .error(ErrorString("noResponse")) // TODO: Better error
    }
}

#endif
