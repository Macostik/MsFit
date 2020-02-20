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
    
    private let emailImageView = UIImageView(image: #imageLiteral(resourceName: "login_email"))
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: mediumConfiguration)?
            .withTintColor(UIColor(named: "closeButton")!, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let sendRecoverInfoButton = specify(UIButton(type: .roundedRect), {
        $0.imageEdgeInsets = .init(top: 0, left: -16, bottom: 0, right: 0)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "Send Recover Info", font: 20, weight: .regular,
                        shadowColor: UIColor(named: "purpleColor1"), bgColor: UIColor(named: "purpleColor1"))
    })
    
    private let emailTextField = specify(TextField(), {
        $0.placeholder = "Email "
        $0.placeholderTextColor = UIColor(named: "placeholderTextFieldColor")
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.keyboardType = .emailAddress
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.returnKeyType = .done
        $0.highlightedStrokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    })
    
    private let verStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = Constants.screenHeight667 ? 80 : 60
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
    }
    
    fileprivate func addConstraints() {
        view.add(closeButton, layoutBlock: {
            $0.top(Constants.screenHeight812 ? 40 : 20).leading(6).size(44)
        })
        view.add(emailImageView, layoutBlock: {
            $0.top(Constants.screenHeight812 ? 100 : 40).centerX()
                .width(Constants.screenHeight / 7).height(Constants.screenHeight / 9)
        })
        verStackView.addArrangedSubview(emailTextField)
        verStackView.addArrangedSubview(sendRecoverInfoButton)
        sendRecoverInfoButton.heightAnchor.constraint(equalToConstant:
            Constants.screenWidth / 5.5).isActive = true
        view.add(verStackView, layoutBlock: {
            $0.leading(20).trailing(20).bottom(Constants.screenHeight812 ? 350 : 250)
        })
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = .systemBackground
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
}
