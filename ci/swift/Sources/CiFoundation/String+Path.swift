import Foundation

// Note: Copypasted from Emcee
extension String {
    public var bridged: NSString {
        return self as NSString
    }
    
    public var pathComponents: [String] {
        return bridged.pathComponents
    }
    
    public func appending(pathComponent: String) -> String {
        return bridged.appendingPathComponent(pathComponent)
    }
    
    public func appending(pathComponents: [String]) -> String {
        var string = self
        for component in pathComponents {
            string = string.appending(pathComponent: component)
        }
        return string
    }
    
    public var pathExtension: String {
        return bridged.pathExtension
    }
    
    public var deletingPathExtension: String {
        return bridged.deletingPathExtension
    }
    
    public var lastPathComponent: String {
        return bridged.lastPathComponent
    }
    
    public var deletingLastPathComponent: String {
        return bridged.deletingLastPathComponent
    }
}
