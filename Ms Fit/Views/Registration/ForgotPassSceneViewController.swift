//  
//  ForgotPassSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ForgotPassSceneViewController: BaseViewController<ForgotPassSceneViewModel> {
    
    private var loginCenterYConstr: NSLayoutConstraint!
    private let emailImageView = UIImageView(image: #imageLiteral(resourceName: "login_email"))

    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: mediumConfiguration)?
            .withTintColor(UIColor(named: "closeButton")!, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let contLoginView = specify(UIView(), {
        $0.backgroundColor = .clear
    })
    
    private let sendRecoverInfoButton = specify(UIButton(type: .roundedRect), {
        $0.imageEdgeInsets = .init(top: 0, left: -16, bottom: 0, right: 0)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "استعادة كلمة المرور", font: 20, weight: .regular, shadowColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), bgColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1))
    })
    
    private let emailLabel = specify(UILabel(), {
        $0.text = "البريد الإلكتروني"
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
    })
    
    private let emailTextField = specify(TextField(), {
        $0.placeholderTextColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.keyboardType = .emailAddress
        $0.textAlignment = .right
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.returnKeyType = .done
        $0.highlightedStrokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
        
        sendRecoverInfoButton.animateWhenPressed(disposeBag: disposeBag)
        sendRecoverInfoButton.rx.tap
            .subscribe(onNext: { _ in
                //do something
            }).disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [unowned self] _ in
                self.isAnimationPlaceholder(isAnimation: true, nameLabel: self.emailLabel,
                                            constr: self.loginCenterYConstr, view: self.contLoginView)
            }).disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [unowned self] _ in
                self.emailTextField.becomeFirstResponder()
                self.isAnimationPlaceholder(isAnimation: false, nameLabel: self.emailLabel,
                                            constr: self.loginCenterYConstr, view: self.contLoginView)
            }).disposed(by: disposeBag)
    }
    
    fileprivate func addConstraints() {
        let verStackView = VStackView(arrangedSubviews: [contLoginView, sendRecoverInfoButton],
                                      spacing: Constants.sW * 0.2)
        verStackView.distribution = .fillEqually
        
        view.add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 50 : Constants.sH_667 ? 30 : 20).leading(6).size(44)
        })
        view.add(emailImageView, layoutBlock: {
            $0.top(Constants.sH * 0.15).centerX().width(Constants.sH / 7).height(Constants.sH / 9)
        })
        sendRecoverInfoButton.heightAnchor.constraint(equalToConstant: Constants.sW / 5.5).isActive = true
        view.add(verStackView, layoutBlock: {
            $0.topBottom(Constants.sW * 0.1, to: emailImageView).leading(16).trailing(20)
        })
        
        contLoginView.add(emailTextField, layoutBlock: { $0.top(20).leading().trailing().bottom() })
        contLoginView.add(emailLabel, layoutBlock: { $0.leading(5).trailing(5) })
        
        loginCenterYConstr = emailLabel.centerYAnchor.constraint(equalTo: contLoginView.centerYAnchor)
        loginCenterYConstr.isActive = true
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        
        let dismissTapGestureRecognized = UITapGestureRecognizer(target: self.view,
                                                                 action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(dismissTapGestureRecognized)
    }
    
    fileprivate func isAnimationPlaceholder(isAnimation: Bool, nameLabel: UILabel,
                                            constr: NSLayoutConstraint, view: UIView) {
        UIView.animate(withDuration: 0.3) {
            nameLabel.textColor = isAnimation ? #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1) : #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
            constr.constant = isAnimation ? -20 : 0
            constr.isActive = !isAnimation
            nameLabel.font = isAnimation ? .systemFont(ofSize: 16, weight: .regular) :
                .systemFont(ofSize: 18, weight: .regular)
            view.layoutIfNeeded()
        }
    }
}
