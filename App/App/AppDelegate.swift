import UIKit
import Szimpla

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        try! Szimpla.Server.instance.tearUp()
        return true
    }
    
}

