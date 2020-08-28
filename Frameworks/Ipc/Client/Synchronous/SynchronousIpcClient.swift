#if MIXBOX_ENABLE_IN_APP_SERVICES

import MixboxFoundation

public protocol SynchronousIpcClient {
    func call<Method: IpcMethod>(
        method: Method,
        arguments: Method.Arguments,
        timeout: CustomizableTimeInterval)
        -> DataResult<Method.ReturnValue, Error>
}

extension SynchronousIpcClient {
    public func call<Method: IpcMethod>(
        method: Method,
        arguments: Method.Arguments)
        -> DataResult<Method.ReturnValue, Error>
    {
        return call(
            method: method,
            arguments: arguments,
            timeout: .default
        )
    }
    
    // Synchronous version for methods without arguments
    public func call<Method: IpcMethod>(
        method: Method,
        timeout: CustomizableTimeInterval = .default)
        -> DataResult<Method.ReturnValue, Error>
        where Method.Arguments == IpcVoid
    {
        return call(
            method: method,
            arguments: IpcVoid(),
            timeout: timeout
        )
    }
}

#endif
