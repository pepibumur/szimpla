import UIKit
import Szimpla

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Setting up the server
        try! Szimpla.Server.instance.tearUp()
        return true
    }
    
}

