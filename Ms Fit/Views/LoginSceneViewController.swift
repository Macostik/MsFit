//  
//  LoginSceneViewController.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 20.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginSceneViewController: BaseViewController<LoginSceneViewModel> {
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: mediumConfiguration)?
            .withTintColor(UIColor(named: "closeButton")!, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let emailImageView = specify(UIImageView(), {
        $0.image = #imageLiteral(resourceName: "login_email")
    })
    
    private let verTFStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
    })
    
    private let verForButtonStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    })
    
    private let containerLoginView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
    })
    
    private let containerPasswordView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
    })
    
    private let loginTextField = specify(TextField(), {
        $0.placeholder = "Login"
        $0.placeholderTextColor = UIColor(named: "placeholderTextFieldColor")
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.keyboardType = .emailAddress
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.returnKeyType = .next
        $0.highlightedStrokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    })
    
    private let passwordTextField = specify(TextField(), {
        $0.placeholder = "Password"
        $0.placeholderTextColor = UIColor(named: "placeholderTextFieldColor")
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.autocorrectionType = .no
        $0.returnKeyType = .done
        $0.autocapitalizationType = .none
        $0.isSecureTextEntry.toggle()
        $0.highlightedStrokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    })
    
    private let startWorkoutButton = specify(UIButton(type: .roundedRect), {
        $0.imageEdgeInsets = .init(top: 0, left: -16, bottom: 0, right: 0)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "Start Workout", cornerR: 66/2, font: 20, weight: .regular,
                        shadowColor: UIColor(named: "purpleColor1")!, bgColor: UIColor(named: "purpleColor1")!)
    })
    
    private let forgotPasswordButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.setTitle("Forgot your password?", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismiss)
            .disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = .systemBackground
    }
    
    fileprivate func addConstraints() {
        view.add(closeButton, layoutBlock: {$0.top(Constants.screenHeight812 ? 33 : 20).leading(16).size(44) })
        view.add(emailImageView, layoutBlock: {
            $0.top(Constants.screenHeight812 ? 120 : 60).centerX().width(100).height(85)
        })
        containerLoginView.add(loginTextField, layoutBlock: { $0.edges() })
        containerPasswordView.add(passwordTextField, layoutBlock: { $0.edges() })
        verTFStackView.addArrangedSubview(containerLoginView)
        verTFStackView.addArrangedSubview(passwordTextField)
        containerLoginView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        containerPasswordView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        view.add(verTFStackView, layoutBlock: { $0.leading(20).trailing(20).topBottom(30, to: emailImageView) })
        verForButtonStackView.addArrangedSubview(startWorkoutButton)
        verForButtonStackView.addArrangedSubview(forgotPasswordButton)
        startWorkoutButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
        view.add(verForButtonStackView, layoutBlock: {
            $0.centerX().leading(20).trailing(20).topBottom(30, to: verTFStackView)
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
}
