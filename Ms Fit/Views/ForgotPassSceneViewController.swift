//  
//  ForgotPassSceneViewController.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 20.02.2020.
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
        $0.customButton(text: "Send Recover Info", cornerR: 66/2, font: 20, weight: .regular,
                        shadowColor: UIColor(named: "purpleColor1")!, bgColor: UIColor(named: "purpleColor1")!)
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
        $0.spacing = 40
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
        
        sendRecoverInfoButton.animateWhenPressed(disposeBag: disposeBag)
    }
    
    fileprivate func addConstraints() {
        view.add(closeButton, layoutBlock: { $0.top(Constants.screenHeight812 ? 33 : 20).leading(20).size(44) })
        view.add(emailImageView, layoutBlock: {
            $0.top(Constants.screenHeight812 ? 140 : 100).centerX().width(100).height(85)
        })
        verStackView.addArrangedSubview(emailTextField)
        verStackView.addArrangedSubview(sendRecoverInfoButton)
        sendRecoverInfoButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
        view.add(verStackView, layoutBlock: { $0.leading(20).trailing(20).topBottom(45, to: emailImageView) })
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = .systemBackground
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
}
