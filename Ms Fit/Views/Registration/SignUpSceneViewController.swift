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

class SignUpSceneViewController: BaseViewController<SignUpSceneViewModel> {
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let baseContainerView = UIView()
    private let containerView = UIView()
    private let rectangelImage = UIImageView(image: #imageLiteral(resourceName: "StartGiftRamadan"))
    private let giftImage = UIImageView(image: #imageLiteral(resourceName: "startGift_icon"))
    
    private let congratulationsLabel = specify(UILabel(), {
        $0.text = "CONGRATULATIONS!"
        $0.textColor = #colorLiteral(red: 0.9843137255, green: 0.8509803922, blue: 0.4431372549, alpha: 1)
        $0.font = .systemFont(ofSize: 13, weight: .bold)
        $0.textAlignment = .center
    })
    
    private let memberShipLabel = specify(UILabel(), {
        $0.text = "Sign up and get free General \nMembership for 3 days"
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 22 : 18, weight: .regular)
        $0.textColor = .systemBackground
        $0.textAlignment = .center
        $0.numberOfLines = 0
    })
    
    private let vTFStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.spacing = 10
    })
    
    private let TFContainerView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 0.14)
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    })
    
    private let twitterButton = specify(UIButton(type: .roundedRect), {
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
        $0.text = "Or use social media"
        $0.font = .systemFont(ofSize: 19, weight: .regular)
        $0.textAlignment = .center
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObservable)
            .disposed(by: disposeBag)
        signUpButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.signUpObservable)
            .disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        baseContainerView.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.3215686275, blue: 0.8509803922, alpha: 1)
        twitterButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        instagramButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        let textFieldList = titleList.map({ [unowned self] title in self.createTFView(title: title) })
        textFieldList.forEach({ [unowned self] tf in self.vTFStackView.addArrangedSubview(tf) })
    }
    
    fileprivate func addConstraints() {
        let hForButtonStackView = HStackView(arrangedSubviews: [instagramButton, twitterButton], spacing: 15)
        hForButtonStackView.distribution = .fillEqually
        
        let vStackView = VStackView(arrangedSubviews: [textLabel, hForButtonStackView], spacing: 15)
        let vTopStackView = VStackView(arrangedSubviews: [congratulationsLabel, memberShipLabel],
                                       spacing: Constants.sH_812 ? 10 : 7)
        
        instagramButton.heightAnchor.constraint(equalToConstant:
            Constants.sH_812 ? Constants.sW / 6.5 : Constants.sW / 8 ).isActive = true
        view.add(vStackView, layoutBlock: { $0.bottom(Constants.sH_812 ? 18 : 8).leading(16).trailing(16) })
        view.add(baseContainerView, layoutBlock: {
            $0.top().trailing().leading().bottomTop(-10, to: vStackView)
        })
        baseContainerView.add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 50 : Constants.sH_667 ? 30 : 20).leading(4).size(44)
        })
        baseContainerView.add(signUpButton, layoutBlock: {
            $0.leading(16).trailing(16).bottom(Constants.sH_812 ? 30 : 20).height(Constants.sW / 5.5)
        })
        baseContainerView.add(containerView, layoutBlock: {
            $0.bottomTop(-15, to: signUpButton).leading(16).trailing(16)
        })
        containerView.add(rectangelImage, layoutBlock: { $0.top().centerX().width(52).height(14) })
        containerView.add(TFContainerView, layoutBlock: {
            $0.topBottom(to: rectangelImage).leading().trailing().bottom()
        })
        baseContainerView.add(giftImage, layoutBlock: {
            $0.top(Constants.sH_812 ? 50 : 30).centerX()
                .width(Constants.sH_812 ? Constants.sH * 0.1 : Constants.sH * 0.07)
                .height(Constants.sH_812 ? Constants.sH * 0.1 : Constants.sH * 0.07)
        })
        baseContainerView.add(vTopStackView, layoutBlock: {
            $0.topBottom(Constants.sH_812 ? 30 : 15, to: giftImage).leading(16).trailing(16)
        })
        TFContainerView.add(vTFStackView, layoutBlock: { $0.leading(24).trailing(24).bottom(16).top(30) })
    }
    
    private let titleList = ["User", "Email", "Password"]
    
    fileprivate func createTFView(title: String) -> UIView {
        let view = UIView()
        let textView = UITextField()
        textView.textColor = .systemBackground
        textView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        textView.font = UIFont.systemFont(ofSize: 17, weight: .light)
        textView.autocorrectionType = .no
        textView.returnKeyType = .done
        textView.autocapitalizationType = .none
        textView.borderStyle = .roundedRect
        textView.layer.cornerRadius = 7
        textView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7446222175)
        textView.backgroundColor = .clear
        textView.layer.borderWidth = 0.7
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemBackground
        view.backgroundColor = .clear
        view.add(label, layoutBlock: { $0.leading().top() })
        view.add(textView, layoutBlock: { $0.leading().bottom().trailing().topBottom(4, to: label) })
        view.heightAnchor.constraint(equalToConstant: Constants.sH * 0.09).isActive = true
        return view
    }
}
