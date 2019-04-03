import UIKit
import Firebase
import FBSDKCoreKit

struct AppService {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        FirebaseApp.configure()
        FBSDKApplicationDelegate.sharedInstance()?.application(application,
                                                               didFinishLaunchingWithOptions: launchOptions)
        applicationDidLaunch(application)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    
        return FBSDKApplicationDelegate
                .sharedInstance()?
                .application(app, open: url, options: options)
                ?? false
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
