//  
//  ValidationSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 21.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class SignUpSceneViewController: BaseViewController<SignUpSceneViewModel> {
    
    public var userParams = [String: String]()
    var safariVC: SFSafariViewController?
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let baseImageView = specify(UIImageView(), {
        $0.image = UIImage(named: "start_Ramadan_Image")
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let userView = specify(UIView(), { $0.backgroundColor = .clear })
    private let emailView = specify(UIView(), { $0.backgroundColor = .clear })
    private let passwordView = specify(UIView(), { $0.backgroundColor = .clear })
    
    private let userLabel = specify(UILabel(), {
        $0.text = "الاسم"
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    })
    
    private let emailLabel = specify(UILabel(), {
        $0.text = "البريد الإلكتروني:"
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    })
    
    private let passLabel = specify(UILabel(), {
        $0.text = "كلمة المرور"
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    })
    
    private let userTF = specify(UITextField(), {
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 17 : Constants.sH_667 ? 16 : 14, weight: .light)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.textAlignment = .right
        $0.textColor = .systemBackground
        $0.autocorrectionType = .no
        $0.returnKeyType = .next
        $0.autocapitalizationType = .none
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 7
        $0.layer.borderColor = #colorLiteral(red: 0.6196078431, green: 0.4588235294, blue: 0.9333333333, alpha: 1)
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
    })
    
    private let emailTF = specify(UITextField(), {
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 17 : Constants.sH_667 ? 16 : 14, weight: .light)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.textAlignment = .right
        $0.textColor = .systemBackground
        $0.autocorrectionType = .no
        $0.returnKeyType = .next
        $0.autocapitalizationType = .none
        $0.keyboardType = .emailAddress
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 7
        $0.layer.borderColor = #colorLiteral(red: 0.6196078431, green: 0.4588235294, blue: 0.9333333333, alpha: 1)
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
    })
    
    private let passwordTF = specify(UITextField(), {
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 18 : Constants.sH_667 ? 16 : 14, weight: .light)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.textAlignment = .right
        $0.textColor = .systemBackground
        $0.autocorrectionType = .no
        $0.returnKeyType = .go
        $0.autocapitalizationType = .none
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 7
        $0.layer.borderColor = #colorLiteral(red: 0.6196078431, green: 0.4588235294, blue: 0.9333333333, alpha: 1)
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
    })
    
    private let contarForButtonsView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1) })
    private let containerView = UIView()
    private let rectangelImage = UIImageView(image: #imageLiteral(resourceName: "StartGiftRamadan"))
    private var textFieldList = [UITextField]()
    
    private let scrollView = specify(UIScrollView(), {
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
    })
    
    private let TFContainerView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 0.14)
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    })
    
    private let twitterButton = specify(UIButton(type: .roundedRect), {
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.setImage(UIImage(named: "twitter"), for: .normal)
        $0.layer.shadowOffset = .init(width: 0, height: 4)
        $0.tintColor = .systemBackground
        $0.layer.shadowOpacity = 0.4
        $0.layer.cornerRadius = 17
        $0.layer.shadowRadius = 4
        $0.layer.shadowColor = #colorLiteral(red: 0.1570000052, green: 0.6819999814, blue: 0.9570000172, alpha: 1)
        $0.backgroundColor = #colorLiteral(red: 0.1570000052, green: 0.6819999814, blue: 0.9570000172, alpha: 1)
    })
    
    private let instagramButton = specify(UIButton(type: .roundedRect), {
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.setImage(UIImage(named: "instagram"), for: .normal)
        $0.layer.shadowOffset = .init(width: 0, height: 4)
        $0.tintColor = .systemBackground
        $0.layer.shadowOpacity = 0.4
        $0.layer.cornerRadius = 17
        $0.layer.shadowRadius = 4
        $0.layer.shadowColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
    })
    
    private let signUpButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.black, for: .normal)
        $0.customButton(text: "Sign Up", font: 20, weight: .medium,
                        shadowColor: .clear, bgColor: .systemBackground)
    })
    
    private let textLabel = specify(UILabel(), {
        $0.text = "التسجيل باستخدام :"
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.font = .systemFont(ofSize: 19, weight: .regular)
        $0.textAlignment = .center
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
       
        //        NotificationCenter.default.addObserver(self, selector: #selector(safariLogin(_:)),
        //                                               name: kSafariViewControllerCloseNotification,
        //                                               object: nil)
    }
    
    func safariLogin(notification: NSNotification) {
        print("Safari Login call")
        // get the url form the auth callback
        let url = notification.object as! NSURL
        print(url)
        self.safariVC!.dismiss(animated: true, completion: nil)
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObservable)
            .disposed(by: disposeBag)
        
        passwordTF.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [unowned self] _ in
                self.passwordTF.resignFirstResponder()
            }).disposed(by: disposeBag)
        
        userTF.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [unowned self] _ in
                self.emailTF.becomeFirstResponder()
            }).disposed(by: disposeBag)
        
        emailTF.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [unowned self] _ in
                self.passwordTF.becomeFirstResponder()
            }).disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .map({[unowned self] _ in
                self.userParams["name"] = self.userTF.text
                self.userParams["email"] = self.emailTF.text
                self.userParams["password"] = self.passwordTF.text
                return self.userParams
            })
            .bind(to: viewModel!.signUpObservable)
            .disposed(by: disposeBag)
        
        instagramButton.rx.tap
            .subscribe(onNext: { _ in
                print("tap instagram")
            }).disposed(by: disposeBag)
        
        twitterButton.rx.tap
            .subscribe(onNext: { _ in
                guard let twitterURL = URL(string: "http://msfit-sa.com/login/twitter") else { return }
                self.safariVC = SFSafariViewController(url: twitterURL)
                self.safariVC?.delegate = self
                self.present(self.safariVC!, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [scrollView] keyboardVisibleHeight in
                scrollView.contentInset.bottom = keyboardVisibleHeight
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        instagramButton.heightAnchor.constraint(equalToConstant:
            Constants.sH_812 ? Constants.sW / 6.5 : Constants.sW / 8).isActive = true
        
        let hForButtonStackView = HStackView(arrangedSubviews: [instagramButton, twitterButton], spacing: 15)
        hForButtonStackView.distribution = .fillEqually
        
        let vStackView = VStackView(arrangedSubviews: [textLabel, hForButtonStackView], spacing: 15)
        let textFieldVStackView = VStackView(arrangedSubviews: [userView, emailView, passwordView],
                                             spacing: 10)
        textFieldVStackView.distribution = .fillEqually
        
        view.add(baseImageView, layoutBlock: {
            $0.top().leading().trailing().height(Constants.sH * 0.83)
        })
        view.add(scrollView, layoutBlock: { $0.top().width(Constants.sW).centerX().bottom() })
        
        userView.add(userLabel, layoutBlock: { $0.top().leading() })
        userView.add(userTF, layoutBlock: { $0.leading().bottom().trailing().topBottom(4, to: userLabel) })
        emailView.add(emailLabel, layoutBlock: { $0.top().leading() })
        emailView.add(emailTF, layoutBlock: { $0.leading().bottom().trailing().topBottom(4, to: emailLabel) })
        passwordView.add(passLabel, layoutBlock: { $0.top().leading() })
        passwordView.add(passwordTF, layoutBlock: {
            $0.leading().bottom().trailing().topBottom(4, to: passLabel)
        })
        
        passwordView.heightAnchor.constraint(equalToConstant: Constants.sH * 0.09).isActive = true
        
        contarForButtonsView.add(vStackView, layoutBlock: {
            $0.width(Constants.sW - 32).centerX().bottom(16).top(20)
        })
        scrollView.add(contarForButtonsView, layoutBlock: { $0.width(Constants.sW).centerX().bottom() })
        scrollView.add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 50 : Constants.sH_667 ? 30 : 20).size(44).leading(6, to: view)
        })
        scrollView.add(signUpButton, layoutBlock: {
            $0.width(Constants.sW - 32).bottomTop(-20, to: contarForButtonsView)
                .height(Constants.sW / 5.5).centerX()
        })
        scrollView.add(containerView, layoutBlock: {
            $0.bottomTop(-15, to: signUpButton).width(Constants.sW - 32).centerX()
                .topBottom(Constants.sH_812 ? Constants.sH * 0.2 : Constants.sH_667 ?
                    Constants.sH * 0.16 : Constants.sH * 0.1, to: closeButton)
        })
        containerView.add(rectangelImage, layoutBlock: { $0.top().centerX().width(52).height(14) })
        containerView.add(TFContainerView, layoutBlock: {
            $0.topBottom(to: rectangelImage).leading().trailing().bottom()
        })
        TFContainerView.add(textFieldVStackView, layoutBlock: {
            $0.leading(24).trailing(24).bottom(16).top(30)
        })
    }
}

extension SignUpSceneViewController: SFSafariViewControllerDelegate {
    
    private func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismiss(animated: true) { () -> Void in
               print("You just dismissed the login view.")
           }
       }

    private func safariViewController(controller: SFSafariViewController,
                                      didCompleteInitialLoad didLoadSuccessfully: Bool) {
           print("didLoadSuccessfully: \(didLoadSuccessfully)")

       }
}
