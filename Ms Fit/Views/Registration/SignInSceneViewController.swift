//  
//  SignInSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 19.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AuthenticationServices

class SignInSceneViewController: BaseViewController<SignInSceneViewModel> {
    
    private let smileImage = UIImageView(image: UIImage(named: "smile_icon"))
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: mediumConfiguration)?
            .withTintColor(UIColor(named: "closeButton")!, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let topLabel = specify(UILabel(), {
        $0.text = "أهلا فيك"
        $0.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.168627451, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    })
    
    private let appleButton = specify(ASAuthorizationAppleIDButton(), {
        $0.layer.shadowColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.layer.shadowRadius = 4
        $0.layer.shadowOpacity = 0.6
        $0.layer.shadowOffset = CGSize(width: 0, height: 3)
        $0.circled = true
    })
    
    private let instagramButton = specify(UIButton(type: .roundedRect), {
        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 10)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 20)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.contentHorizontalAlignment = .right
        $0.setImage(UIImage(named: "instagram"), for: .normal)
        $0.customButton(text: "تسجيل الدخول بـ الانستقرام", font: 20, weight: .regular,
                        shadowColor: #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1), bgColor: #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1))
    })
    
    private let twitterButton = specify(UIButton(type: .roundedRect), {
        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 10)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 20)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.contentHorizontalAlignment = .right
        $0.setImage(UIImage(named: "twitter"), for: .normal)
        $0.customButton(text: "تسجيل الدخول بـ تويتر",font: 20, weight: .regular,
                        shadowColor: #colorLiteral(red: 0.1568627451, green: 0.6823529412, blue: 0.9568627451, alpha: 1), bgColor: #colorLiteral(red: 0.1568627451, green: 0.6823529412, blue: 0.9568627451, alpha: 1))
    })
    
    private let emailButton = specify(UIButton(type: .roundedRect), {
        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 10)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 20)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.contentHorizontalAlignment = .right
        $0.setImage(UIImage(named: "email"), for: .normal)
        $0.customButton(text: "تسجيل الدخول بـ البريد الإلكتروني", font: 20, weight: .regular,
                        shadowColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1),  bgColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1))
    })
    
    override func setupUI() {
        handleUI()
        setupAppleButton()
        addConstraints()
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
        
        emailButton.animateWhenPressed(disposeBag: disposeBag)
        emailButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel!.presentLoginScreenObserver.onNext(())
            }).disposed(by: disposeBag)
        
        instagramButton.animateWhenPressed(disposeBag: disposeBag)
        instagramButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel!.presentInstagramObserver.onNext(())
            }).disposed(by: disposeBag)
        
        twitterButton.animateWhenPressed(disposeBag: disposeBag)
        twitterButton.rx.tap
            .subscribe(onNext: { _ in
                //do something
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        
    }
    
    fileprivate func addConstraints() {
        instagramButton.heightAnchor.constraint(equalToConstant: Constants.sW / 5.5).isActive = true
        
        let verStackView = VStackView(arrangedSubviews: [
            instagramButton, twitterButton, emailButton, appleButton
        ], spacing: 35)
        verStackView.distribution = .fillEqually
        
        let horStackView = HStackView(arrangedSubviews: [smileImage, topLabel], spacing: 6)
        
        view.add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 51 : 20).leading(6).size(44)
        })
        view.add(verStackView, layoutBlock: { $0.centerX().centerY(15).leading(20).trailing(20) })
        view.add(horStackView, layoutBlock: { $0.centerX().bottomTop(-35, to: verStackView) })
    }
}

extension SignInSceneViewController {
    
    fileprivate func setupAppleButton() {
        appleButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButton), for: .touchUpInside)
    }
    
    @objc func handleAuthorizationAppleIDButton() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension SignInSceneViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        func authorizationController(controller: ASAuthorizationController,
                                     didCompleteWithAuthorization authorization: ASAuthorization) {
            switch authorization.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                
                let userIdentifier = appleIDCredential.user
                let fullName = appleIDCredential.fullName
                let email = appleIDCredential.email
                
//                self.saveUserInKeychain(userIdentifier)
//                self.showResultViewController(userIdentifier: userIdentifier,
//                                              fullName: fullName, email: email)
                
                viewModel?.presentMainSceneObserver.onNext(())
            
            case let passwordCredential as ASPasswordCredential:
            
                let username = passwordCredential.user
                let password = passwordCredential.password
                
                DispatchQueue.main.async {
                    self.showPasswordCredentialAlert(username: username, password: password)
                }
                
            default:
                break
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
//    private func saveUserInKeychain(_ userIdentifier: String) {
//        do {
//            try KeychainItem(service: "com.example.apple-samplecode.juice",
//                             account: "userIdentifier").saveItem(userIdentifier)
//        } catch {
//            print("Unable to save userIdentifier to keychain.")
//        }
//    }
    
//    private func showResultViewController(userIdentifier: String,
//                                          fullName: PersonNameComponents?,
//                                          email: String?) {
//        guard let viewController = self.presentingViewController as? DailySceneViewController
//            else { return }
//
//        DispatchQueue.main.async {
//            viewController.userIdentifierLabel.text = userIdentifier
//            if let givenName = fullName?.givenName {
//                viewController.givenNameLabel.text = givenName
//            }
//            if let familyName = fullName?.familyName {
//                viewController.familyNameLabel.text = familyName
//            }
//            if let email = email {
//                viewController.emailLabel.text = email
//            }
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension SignInSceneViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
