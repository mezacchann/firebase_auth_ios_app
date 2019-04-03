import UIKit
import Firebase


class ViewController: UIViewController {
    
    lazy var debugLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLogic()
    }
    
    private func setupLogic() {
        view.addSubview(debugLabel)
        
        Services.auth.isSignIn { isSignIn in
            if isSignIn {
                try? Auth.auth().signOut()
            }
        }
        
//        Services.auth.signInAnonymously { result in
//            switch result {
//            case .error(let error): print("📬", error.localizedDescription)
//            case .success(let result): print("📬", result.user.uid)
//            }
//        }
        
//        Services.auth.createUserWithEmail { result in
//            switch result {
//            case .error(let error): print("📬", error.localizedDescription)
//            case .success(let result): print("📬", result.user.uid)
//            }
//        }
        
//        Services.auth.signInWithEmail { result in
//            switch result {
//            case .error(let error): print("📬", error.localizedDescription)
//            case .success(let result): print("📬", result.user.uid)
//            }
//        }
    }
    
    private func setupListeners() {
        
    }
}

