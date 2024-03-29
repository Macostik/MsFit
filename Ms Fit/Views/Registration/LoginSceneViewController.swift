//  
//  LoginSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginSceneViewController: BaseViewController<LoginSceneViewModel> {
    
    private let emailImageView = UIImageView(image: #imageLiteral(resourceName: "login_email"))
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: mediumConfiguration)?
            .withTintColor(UIColor(named: "closeButton")!, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private var loginCenterYConstr: NSLayoutConstraint!
    private var passCenterYConstr: NSLayoutConstraint!
    
    private let spinnerView = specify(UIActivityIndicatorView(), {
        $0.color = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.startAnimating()
        $0.isHidden = true
    })
    
    private let contLoginView = specify(UIView(), {
        $0.backgroundColor = .clear
    })
    
    private let contPasswordView = specify(UIView(), {
        $0.backgroundColor = .clear
    })
    
    private let loginLabel = specify(UILabel(), {
        $0.text = "البريد الإلكتروني"
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
    })
    
    private let passwordLabel = specify(UILabel(), {
        $0.text = "كلمة المرور"
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
    })
    
    private let loginTextField = specify(TextField(), {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        $0.keyboardType = .emailAddress
        $0.textAlignment = .right
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.returnKeyType = .next
        $0.highlightedStrokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    })
    
    private let passwordTextField = specify(TextField(), {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        $0.autocorrectionType = .no
        $0.textAlignment = .right
        $0.returnKeyType = .done
        $0.autocapitalizationType = .none
        $0.isSecureTextEntry.toggle()
        $0.highlightedStrokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    })
    
    private let startWorkoutButton = specify(UIButton(type: .roundedRect), {
        $0.imageEdgeInsets = .init(top: 0, left: -16, bottom: 0, right: 0)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "دخول", font: 20, weight: .bold, shadowColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), bgColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1))
    })
    
    private let forgotPasswordButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.setTitle("نسيت كلمة المرور", for: .normal)
        $0.setTitleColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), for: .normal)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
        
        startWorkoutButton.animateWhenPressed(disposeBag: disposeBag)
        startWorkoutButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                if self.loginTextField.text?.isEmpty ?? false ||
                    self.passwordTextField.text?.isEmpty ?? false {
                    self.createAlertController()
                } else {
                    self.spinnerView.isHidden = false
                    Observable.zip(self.loginTextField.rx.text.asObservable(),
                                   self.passwordTextField.rx.text.asObservable())
                        .subscribe(onNext: { (email, password) in
                            self.viewModel?.tryLoginObserver = .just((email, password))
                        }).disposed(by: self.disposeBag)
                }
            }).disposed(by: disposeBag)
        
        forgotPasswordButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel!.presentForgotPassObserver.onNext(())
            }).disposed(by: disposeBag)
        
        loginTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [unowned self] _ in
                self.isAnimationPlaceholder(isAnimation: true, nameLabel: self.loginLabel,
                                            constr: self.loginCenterYConstr, view: self.contLoginView,
                                            orEmpty: !(self.loginTextField.text?.isEmpty ?? false))
            }).disposed(by: disposeBag)
        
        loginTextField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [unowned self] _ in
                self.isAnimationPlaceholder(isAnimation: false, nameLabel: self.loginLabel,
                                            constr: self.loginCenterYConstr, view: self.contLoginView,
                                            orEmpty: !(self.loginTextField.text?.isEmpty ?? false))
            }).disposed(by: disposeBag)
        
        loginTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [unowned self] _ in
                self.passwordTextField.becomeFirstResponder()
            }).disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [unowned self] _ in
                self.isAnimationPlaceholder(isAnimation: true, nameLabel: self.passwordLabel,
                                            constr: self.passCenterYConstr, view: self.contPasswordView,
                                            orEmpty: !(self.passwordTextField.text?.isEmpty ?? false))
            }).disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [unowned self] _ in
                self.isAnimationPlaceholder(isAnimation: false, nameLabel: self.passwordLabel,
                                            constr: self.passCenterYConstr, view: self.contPasswordView,
                                            orEmpty: !(self.passwordTextField.text?.isEmpty ?? false))
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        
        let dismissTapGestureRecognized = UITapGestureRecognizer(target: self.view,
                                                                 action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(dismissTapGestureRecognized)
    }
    
    fileprivate func addConstraints() {
        contLoginView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let verTFStackView = VStackView(arrangedSubviews: [contLoginView, contPasswordView],
                                        spacing: 25)
        verTFStackView.distribution = .fillEqually
        
        view.add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 50 : Constants.sH_667 ? 30 : 20).leading(6).size(44)
        })
        view.add(emailImageView, layoutBlock: {
            $0.top(Constants.sH_812 ? 100 : 40).centerX().width(Constants.sH / 7).height(Constants.sH / 9)
        })
        contLoginView.add(loginTextField, layoutBlock: { $0.top(20).leading().trailing().bottom() })
        contLoginView.add(loginLabel, layoutBlock: { $0.trailing(5).leading(5) })
        contPasswordView.add(passwordTextField, layoutBlock: { $0.top(20).leading().trailing().bottom() })
        contPasswordView.add(passwordLabel, layoutBlock: { $0.trailing(5).leading(5) })
        view.add(verTFStackView, layoutBlock: {
            $0.topBottom(Constants.sH_812 ? 25 : Constants.sH_667 ? 20 : 0, to: emailImageView)
                .leading(16).trailing(20)
        })
        view.add(startWorkoutButton, layoutBlock: {
            $0.leading(16).trailing(16).topBottom(50, to: verTFStackView).height(Constants.sW / 5.5)
        })
        view.add(forgotPasswordButton, layoutBlock: { $0.topBottom(10, to: startWorkoutButton).centerX() })
        view.add(spinnerView, layoutBlock: { $0.centerX().centerY(-20) })
        
        loginCenterYConstr = loginLabel.centerYAnchor.constraint(equalTo: contLoginView.centerYAnchor)
        loginCenterYConstr.isActive = true
        passCenterYConstr = passwordLabel.centerYAnchor.constraint(equalTo: contPasswordView.centerYAnchor)
        passCenterYConstr.isActive = true
    }
    
    fileprivate func createAlertController() {
        let alertController = UIAlertController(title: "تحذير!",
                                                message: "أدخل تسجيل الدخول وكلمة المرور الصحيحة!",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "حسنا", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func isAnimationPlaceholder(isAnimation: Bool, nameLabel: UILabel,
                                            constr: NSLayoutConstraint, view: UIView, orEmpty: Bool) {
        UIView.animate(withDuration: 0.3) {
            constr.constant = orEmpty ? -20 : 0
            nameLabel.textColor = isAnimation ? #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1) : #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
            constr.isActive = !isAnimation
            nameLabel.font = isAnimation ? .systemFont(ofSize: 16, weight: .regular) :
                .systemFont(ofSize: 16, weight: .regular)
            view.layoutIfNeeded()
        }
    }
}
