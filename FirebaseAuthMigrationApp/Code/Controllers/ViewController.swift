import UIKit
import Firebase
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let facebookSignInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in with Facebook", for: .normal)
        return button
    }()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupSubviews()
        setupLogic()
    }
    
    private func setupSubviews() {
        view.addSubview(facebookSignInButton)
        facebookSignInButton.anchorCenterSuperview()
        facebookSignInButton.anchor(size: CGSize(width: 0, height: 100))
        facebookSignInButton
            .rx
            .tap
            .subscribe { [weak self] _ in
                guard let strongSelf = self else { return }
                Services.auth.signInWithFacebook(strongSelf) { result in
                    switch result {
                    case .success(let result): print("📬", result.user.uid)
                    case .error(let error): print("📬", error?.localizedDescription ?? "")
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setupLogic() {
        
        
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
        
        //        Services.auth.linkWithProvider { result in
        //            switch result {
        //            case .error(let error): print("📬:" , error.localizedDescription)
        //            case .success(let result): print("📬:", result.user.uid)
        //            }
        //        }
    }
    
    private func setupListeners() {
        
    }
}



