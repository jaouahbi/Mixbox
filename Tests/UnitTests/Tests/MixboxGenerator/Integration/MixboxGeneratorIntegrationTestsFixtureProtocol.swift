import Foundation

protocol MixboxGeneratorIntegrationTestsFixtureBaseProtocolFromSameFile {
    var _mixboxGeneratorIntegrationTestsFixtureBaseProtocolFromSameFileProperty: Int { get }
    func mixboxGeneratorIntegrationTestsFixtureBaseProtocolFromSameFileFunction()
}

// swiftlint:disable syntactic_sugar
protocol MixboxGeneratorIntegrationTestsFixtureProtocol:
    MixboxGeneratorIntegrationTestsFixtureBaseProtocolFromSameFile,
    MixboxGeneratorIntegrationTestsFixtureBaseProtocolFromOtherFile
{
    // Number of arguments
    func function()
    func function(argument0: Int, argument1: Int)
    
    // Labels
    func function(_ noLabel: Int)
    func function(label: Int)
    
    // Throwing
    func throwingFunction() throws
    
    // Return value
    func function() -> Int
    func function() -> Int?
    func function() -> Int??
    func function() -> [Int]
    func function() -> [Int: Int]
    func function() -> () -> ()
    
    // Argument types
    func function(optional: Int?)
    func function(doubleOptional: Int??)
    func function(otherWayOfSpecifyingOptionality: Optional<Int>)
    
    // Closures
    
    // TODO: Fix non-escaping closures
    // func function(closure: () -> ())
    // func function(autoclosure: @autoclosure () -> Int)
    
    func function(escapingClosure: @escaping () -> ())
    
    func function(
        closureWithPoorlyWrittenAttributes: @escaping(Int?) -> ())
    
    func function(escapingAutoclosure: @escaping @autoclosure () -> Int)
    
    // Function attributes
    
    @inlinable
    func inlinableFunction()
    
    @available(iOS 10.0, *)
    func availableSince10Function()
    
    @available(iOS 999.0, *)
    func availableSince999Function()
    
    // Propertes
    
    var gettable: Int { get }
    var settable: Int { get set }
    
    var gettableClosure: () -> () { get }
    var gettableOptional: Int? { get }
    var gettableArray: [Int?]? { get }
}