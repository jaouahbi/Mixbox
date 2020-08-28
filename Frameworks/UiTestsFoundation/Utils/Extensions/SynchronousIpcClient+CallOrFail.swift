import MixboxIpc
import MixboxTestsFoundation
import MixboxFoundation

extension SynchronousIpcClient {
    public func callOrFail<Method: IpcMethod>(
        method: Method,
        arguments: Method.Arguments,
        timeout: CustomizableTimeInterval = .default,
        file: StaticString = #file,
        line: UInt = #line)
        -> Method.ReturnValue
    {
        return UnavoidableFailure.doOrFail(file: file, line: line) {
            try callOrThrow(
                method: method,
                arguments: arguments,
                timeout: timeout
            )
        }
    }
    
    // Synchronous version for methods without arguments
    public func callOrFail<Method: IpcMethod>(
        method: Method,
        timeout: CustomizableTimeInterval = .default,
        file: StaticString = #file,
        line: UInt = #line)
        -> Method.ReturnValue
        where Method.Arguments == IpcVoid
    {
        return UnavoidableFailure.doOrFail(file: file, line: line) {
            try callOrThrow(
                method: method,
                arguments: IpcVoid(),
                timeout: timeout
            )
        }
    }
    
    // Synchronous version for methods without arguments and return value
    public func callOrFail<Method: IpcMethod>(
        method: Method,
        timeout: CustomizableTimeInterval = .default,
        file: StaticString = #file,
        line: UInt = #line)
        where
        Method.Arguments == IpcVoid,
        Method.ReturnValue == IpcVoid
    {
        _ = UnavoidableFailure.doOrFail(file: file, line: line) {
            try callOrThrow(
                method: method,
                arguments: IpcVoid(),
                timeout: timeout
            )
        }
    }
    
    // Synchronous version for methods without return value
    public func callOrFail<Method: IpcMethod>(
        method: Method,
        arguments: Method.Arguments,
        timeout: CustomizableTimeInterval = .default,
        file: StaticString = #file,
        line: UInt = #line)
        where
        Method.ReturnValue == IpcVoid
    {
        _ = UnavoidableFailure.doOrFail(file: file, line: line) {
            try callOrThrow(
                method: method,
                arguments: arguments,
                timeout: timeout
            )
        }
    }
}
