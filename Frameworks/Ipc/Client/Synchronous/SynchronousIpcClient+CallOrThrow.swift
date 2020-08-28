#if MIXBOX_ENABLE_IN_APP_SERVICES

import MixboxFoundation

extension SynchronousIpcClient {
    // Synchronous throwing version
    public func callOrThrow<Method: IpcMethod>(
        method: Method,
        arguments: Method.Arguments,
        timeout: CustomizableTimeInterval = .default)
        throws
        -> Method.ReturnValue
    {
        let result = call(
            method: method,
            arguments: arguments,
            timeout: timeout
        )
        
        switch result {
        case .data(let data):
            return data
        case .error(let error):
            throw ErrorString(
                "Failed calling method \(method) with arguments \(arguments) by IpcClient: \(error)"
            )
        }
    }
    
    // Synchronous throwing version for methods without Arguments
    public func callOrThrow<Method: IpcMethod>(
        method: Method,
        timeout: CustomizableTimeInterval = .default)
        throws
        -> Method.ReturnValue
        where Method.Arguments == IpcVoid
    {
        return try callOrThrow(
            method: method,
            arguments: IpcVoid(),
            timeout: timeout
        )
    }
    
    // Synchronous throwing version for methods without ReturnValue
    public func callOrThrow<Method: IpcMethod>(
        method: Method,
        arguments: Method.Arguments,
        timeout: CustomizableTimeInterval = .default)
        throws
        where Method.ReturnValue == IpcVoid
    {
        let _: IpcVoid = try callOrThrow(
            method: method,
            arguments: arguments,
            timeout: timeout
        )
    }
    
    // Synchronous throwing version for methods without Arguments & ReturnValue
    public func callOrThrow<Method: IpcMethod>(
        method: Method,
        timeout: CustomizableTimeInterval = .default)
        throws
        where
        Method.ReturnValue == IpcVoid,
        Method.Arguments == IpcVoid
    {
        let _: IpcVoid = try callOrThrow(
            method: method,
            arguments: IpcVoid(),
            timeout: timeout
        )
    }
}

#endif
