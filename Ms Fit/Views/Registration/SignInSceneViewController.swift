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
    
    private let smileImage = UIImageView(image: UIImage(named: "smile_icon"))
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: mediumConfiguration)?
            .withTintColor(UIColor(named: "closeButton")!, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let topLabel = specify(UILabel(), {
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.text = "أهلا فيك"
        $0.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.168627451, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    })
    
    private let instagramButton = specify(UIButton(type: .roundedRect), {
        $0.imageEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        $0.semanticContentAttribute = .forceLeftToRight
        $0.contentHorizontalAlignment = .left
        $0.setImage(UIImage(named: "instagram"), for: .normal)
        $0.customButton(text: "تسجيل الدخول بـ الانستقرام", font: 20, weight: .regular,
                        shadowColor: #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1), bgColor: #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1))
    })
    
    private let twitterButton = specify(UIButton(type: .roundedRect), {
        $0.imageEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        $0.semanticContentAttribute = .forceLeftToRight
        $0.contentHorizontalAlignment = .left
        $0.setImage(UIImage(named: "twitter"), for: .normal)
        $0.customButton(text: "تسجيل الدخول بـ تويتر",font: 20, weight: .regular,
                        shadowColor: #colorLiteral(red: 0.1568627451, green: 0.6823529412, blue: 0.9568627451, alpha: 1), bgColor: #colorLiteral(red: 0.1568627451, green: 0.6823529412, blue: 0.9568627451, alpha: 1))
    })
    
    private let emailButton = specify(UIButton(type: .roundedRect), {
        $0.imageEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        $0.semanticContentAttribute = .forceLeftToRight
        $0.contentHorizontalAlignment = .left
        $0.setImage(UIImage(named: "email"), for: .normal)
        $0.customButton(text: "تسجيل الدخول بـ البريد الإلكتروني", font: 20, weight: .regular,
                        shadowColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1),  bgColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1))
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
        let verStackView = VStackView(arrangedSubviews: [instagramButton, twitterButton, emailButton],
                                      spacing: 35)
        verStackView.distribution = .fillEqually
        
        let horStackView = HStackView(arrangedSubviews: [smileImage, topLabel], spacing: 6)
        
        view.add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 51 : 20).leading(6).size(44)
        })
        view.add(verStackView, layoutBlock: { $0.centerX().centerY(15).leading(16).trailing(16) })
        view.add(horStackView, layoutBlock: { $0.centerX().bottomTop(-35, to: verStackView) })
        instagramButton.heightAnchor.constraint(equalToConstant: Constants.sW / 5.5).isActive = true
    }
}
