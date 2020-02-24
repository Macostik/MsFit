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
    
    private let verTFStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
    })
    
    private let verForButtonStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.spacing = 10
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
        $0.placeholderTextColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
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
        $0.placeholderTextColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
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
        $0.customButton(text: "Start Workout", font: 20, weight: .regular, shadowColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), bgColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1))
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
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
        
        startWorkoutButton.animateWhenPressed(disposeBag: disposeBag)
        startWorkoutButton.rx.tap
            .subscribe(onNext: {
                //do something
            }).disposed(by: disposeBag)
        
        forgotPasswordButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel!.presentForgotPassObserver.onNext(())
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        view.add(closeButton, layoutBlock: {$0.top(Constants.sH_812 ? 40 : 20).leading(6).size(44) })
        view.add(emailImageView, layoutBlock: {
            $0.top(Constants.sH_812 ? 100 : 40).centerX().width(Constants.sH / 7).height(Constants.sH / 9)
        })
        containerLoginView.add(loginTextField, layoutBlock: { $0.edges() })
        containerPasswordView.add(passwordTextField, layoutBlock: { $0.edges() })
        verTFStackView.addArrangedSubview(containerLoginView)
        verTFStackView.addArrangedSubview(passwordTextField)
        containerLoginView.heightAnchor.constraint(equalToConstant: Constants.sW / 6).isActive = true
        view.add(verTFStackView, layoutBlock: {
            $0.topBottom(Constants.sH_812 ? 25 : Constants.sH_667 ? 20 : 0, to: emailImageView)
                .leading(16).trailing(20)
        })
        verForButtonStackView.addArrangedSubview(startWorkoutButton)
        verForButtonStackView.addArrangedSubview(forgotPasswordButton)
        startWorkoutButton.heightAnchor.constraint(equalToConstant: Constants.sW / 5.5).isActive = true
        view.add(verForButtonStackView, layoutBlock: {
            $0.leading(16).trailing(16).bottom(Constants.sH_812 ? 280 : 200)
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
}
