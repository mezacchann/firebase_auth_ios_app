import UIKit
import Firebase

struct AppService {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        FirebaseApp.configure()
        
        applicationDidLaunch(application)
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
