import UIKit
import Firebase
import FBSDKCoreKit
import LineSDK

struct AppService {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        FirebaseApp.configure()
        FBSDKApplicationDelegate.sharedInstance()?.application(application,
                                                               didFinishLaunchingWithOptions: launchOptions)
        
        LoginManager.shared.setup(channelID: "1561155096", universalLinkURL: nil)
        
        applicationDidLaunch(application)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("📬", url.absoluteString)
        
        let openFacebookUrl = FBSDKApplicationDelegate
                .sharedInstance()?
                .application(app, open: url, options: options)
                ?? false
        
        let openLineUrl = LoginManager.shared.application(app, open: url, options: options)
        
        return [openFacebookUrl, openLineUrl].reduce(false) { current, next -> Bool in
            if current == true || next == true {
                return true
            }
            return false
        }
    }
    
    private func applicationDidLaunch(_ application: UIApplication) {
        let window = application.windows[0]
        let mainTabBarController = UITabBarController()
        configureMainController(mainTabBarController)
        window.rootViewController = mainTabBarController
    }
    
    private func configureMainController(_ tabBarController: UITabBarController) {
        let dummyNavController = UINavigationController(rootViewController: ViewController())
        tabBarController.setViewControllers([dummyNavController], animated: false)
    }
}
