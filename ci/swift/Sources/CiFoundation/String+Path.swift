import Foundation

// Note: Copypasted from Emcee
extension String {
    public var mb_bridged: NSString {
        return self as NSString
    }
    
    public var mb_pathComponents: [String] {
        return mb_bridged.pathComponents
    }
    
    public func mb_appending(pathComponent: String) -> String {
        return mb_bridged.appendingPathComponent(pathComponent)
    }
    
    public func mb_appending(pathComponents: [String]) -> String {
        return pathComponents.reduce(self) {
            $0.mb_appending(pathComponent: $1)
        }
    }
    
    public var mb_pathExtension: String {
        return mb_bridged.pathExtension
    }
    
    public var mb_deletingPathExtension: String {
        return mb_bridged.deletingPathExtension
    }
    
    public var mb_lastPathComponent: String {
        return mb_bridged.lastPathComponent
    }
    
    public var mb_deletingLastPathComponent: String {
        return mb_bridged.deletingLastPathComponent
    }
}
