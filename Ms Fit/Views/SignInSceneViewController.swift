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

class SignInSceneViewController: BaseViewController<SignInSceneViewModel> {
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: mediumConfiguration)?
            .withTintColor(UIColor(named: "closeButton")!, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let verStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.spacing = 34
        $0.distribution = .fillEqually
    })
    
    private let horStackView = specify(UIStackView(), {
        $0.axis = .horizontal
        $0.spacing = 6
    })
    
    private let smileImage = UIImageView(image: UIImage(named: "smile_icon"))
    
    private let topLabel = specify(UILabel(), {
        $0.text = "Nice to see you again"
        $0.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.168627451, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    })
    
    private let instagramButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        $0.imageEdgeInsets = .init(top: 0, left: -16, bottom: 0, right: 0)
        $0.setImage(UIImage(named: "instagram"), for: .normal)
        $0.tintColor = .systemBackground
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "Sign in with Instagram", cornerR: 64/2, font: 20, weight: .regular,
                        shadowColor: UIColor(named: "instagramColor")!, bgColor: UIColor(named: "instagramColor")!)
    })
    
    private let twitterButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        $0.imageEdgeInsets = .init(top: 0, left: -16, bottom: 0, right: 0)
        $0.setImage(UIImage(named: "twitter"), for: .normal)
        $0.tintColor = .systemBackground
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "Sign in with Twitter", cornerR: 64/2, font: 20, weight: .regular,
                        shadowColor: UIColor(named: "twitterColor")!, bgColor: UIColor(named: "twitterColor")!)
    })
    
    private let emailButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        $0.imageEdgeInsets = .init(top: 0, left: -16, bottom: 0, right: 0)
        $0.setImage(UIImage(named: "email"), for: .normal)
        $0.tintColor = .systemBackground
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "Sign in with Email", cornerR: 64/2, font: 20, weight: .regular,
                        shadowColor: UIColor(named: "purpleColor1")!, bgColor: UIColor(named: "purpleColor1")!)
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
        verStackView.addArrangedSubview(instagramButton)
        verStackView.addArrangedSubview(twitterButton)
        verStackView.addArrangedSubview(emailButton)
        horStackView.addArrangedSubview(smileImage)
        horStackView.addArrangedSubview(topLabel)
    }
    
    fileprivate func addConstraints() {
        view.add(closeButton, layoutBlock: { $0.top(33).leading(16).size(44) })
        view.add(verStackView, layoutBlock: { $0.center().leading(20).trailing(20) })
        view.add(horStackView, layoutBlock: { $0.centerX().bottomTop(-20, to: verStackView) })
        instagramButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        twitterButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        emailButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
}
