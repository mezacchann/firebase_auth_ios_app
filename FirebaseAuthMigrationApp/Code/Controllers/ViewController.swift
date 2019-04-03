import UIKit
import Firebase
import RxSwift
import RxCocoa
import LineSDK

class ViewController: UIViewController {
    
    let lineSignInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.setTitle("Sign in with Line", for: .normal)
        return button
    }()
    
    let facebookSignInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.setTitle("Sign in with Facebook", for: .normal)
        return button
    }()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupSubviews()
        setupListeners()
        setupLogic()
    }
    
    private func setupSubviews() {
        let stackView = UIStackView(arrangedSubviews: [lineSignInButton, facebookSignInButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        view.addSubview(stackView)
        
        lineSignInButton.anchor(size: CGSize(width: 200, height: 50))
        facebookSignInButton.anchor(size: CGSize(width: 200, height: 50))
        stackView.anchorCenterSuperview()
    }
    
    private func setupListeners() {
        facebookSignInButton
            .rx
            .tap
            .subscribe { [weak self] _ in
                guard let strongSelf = self else { return }
                Services.auth.registerWithFacebookSDK(strongSelf) { result in
                    if case let Result.error(error) = result {
                        print("📬", error?.localizedDescription ?? "")
                    }
                }
            }
            .disposed(by: disposeBag)
        
        lineSignInButton
            .rx
            .tap
            .subscribe { [weak self] _ in
                guard let strongSelf = self else { return }
                Services.auth.registerWithLineSDK(strongSelf) { result in
                    switch result {
                    case .error(let error): print("📬", error?.localizedDescription ?? "")
                    case .success(let result): print("📬", result)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setupLogic() {
        
        
        //        Services.auth.isSignIn { isSignIn in
        //            if isSignIn {
        //                try? Auth.auth().signOut()
        //            }
        //        }
        
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
        
        Services.auth.signInWithLine { result in
            switch result {
            case .error(let error): print("📬:" , error?.localizedDescription ?? "")
            case .success(let result): print("📬:", result.user.uid)
            }
        }
    }
}
