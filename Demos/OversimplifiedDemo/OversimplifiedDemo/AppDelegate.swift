import UIKit

#if DEBUG
import MixboxInAppServices
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    #if DEBUG
    var mixboxInAppServices: MixboxInAppServices?
    #endif
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool
    {
        #if DEBUG
        let factoryOrNil = InAppServicesDependenciesFactoryImpl(
            environment: ProcessInfo.processInfo.environment
        )
        
        if let factory = factoryOrNil {
            mixboxInAppServices = MixboxInAppServices(
                inAppServicesDependenciesFactory: factory
            )
        } else {
            mixboxInAppServices = nil
        }
        
        _ = mixboxInAppServices?.start()
        
        #endif
        
        return true
    }
}
