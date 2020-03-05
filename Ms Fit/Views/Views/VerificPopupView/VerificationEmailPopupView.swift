//
//  VereficationEmailPopupView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 28.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class VerificationEmailPopupView: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    
    private var centerYContainerView: NSLayoutConstraint!
    
    private let emailImageView = UIImageView(image: UIImage(named: "login_email"))
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    public let containerView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    })
    
    private let vContainerStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = Constants.sH_667 ? 15 : 10
    })
    
    private let topLabel = specify(UILabel(), {
        $0.setLineHeight("Hi, Elsa! Increasing prosperity in our lives can be.",
                         lineHeight: Constants.sH_667 ? 5 : 3)
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 20 : Constants.sH_667 ? 17 : 15, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = 2
    })
    
    private let emailTextField = specify(UITextField(), {
        $0.placeholder = "test.user@yopmail.com"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: Constants.sH_667 ? 16 : 14, weight: .regular)
        $0.autocorrectionType = .no
        $0.returnKeyType = .done
        $0.autocapitalizationType = .none
        $0.borderStyle = .none
        $0.textAlignment = .center
        $0.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 0.7
        $0.circled = true
    })
    
    private let bottomLabel = specify(UILabel(), {
        $0.setLineHeight("Increasing prosperity in our lives can be accomplished.",
                         lineHeight: Constants.sH_667 ? 4 : 2)
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 17 : Constants.sH_667 ? 14 : 12, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = 2
    })
    
    private let verificationButton = specify(UIButton(type: .roundedRect), {
        $0.setTitle("Verification Email", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.titleLabel?.font = .systemFont(ofSize: Constants.sH_812 ? 30 : Constants.sH_667 ? 26 : 22,
                                          weight: .bold)
        $0.tintColor = .systemBackground
    })
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        addConstraints()
    }
    
    func setupUI() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.8)
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        closeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
                    self?.containerView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    self?.alpha = 0
                }, completion: { _ in
                    self?.removeFromSuperview()
                })
            }).disposed(by: disposeBag)
        
//        RxKeyboard.instance.visibleHeight
//            .drive(onNext: { [weak centerXContainerView, weak self] _ in
//                self?.centerYContainerView?.constant -= 110
//                self?.layoutIfNeeded()
//            }).disposed(by: disposeBag)
//
//        emailTextField.rx.controlEvent(.editingDidEndOnExit)
//            .subscribe(onNext: { [weak self] _ in
//                self?.centerYContainerView.constant += 110
//                self?.layoutIfNeeded()
//            }).disposed(by: disposeBag)
    }

    func addConstraints() {
        add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 50 : Constants.sH_667 ? 30 : 20).trailing(4).size(44)
        })
        add(containerView, layoutBlock: { $0.centerX().width(Constants.sW - 40) })
        centerYContainerView = containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        centerYContainerView.isActive = true
        vContainerStackView.addArrangedSubview(topLabel)
        vContainerStackView.addArrangedSubview(bottomLabel)
        containerView.add(emailImageView, layoutBlock: {
            $0.top(Constants.sH_667 ? 40 : 20).centerX()
                .width(Constants.sH_667 ? 86 : 66).height(Constants.sH_667 ? 70 : 50)
        })
        containerView.add(vContainerStackView, layoutBlock: {
            $0.topBottom(30, to: emailImageView).leading(40).trailing(40)
        })
        containerView.add(emailTextField, layoutBlock: {
            $0.height(Constants.sH_667 ? 50 : 40).leading(16)
                .trailing(16).topBottom(30, to: vContainerStackView)
        })
        containerView.add(verificationButton, layoutBlock: {
            $0.topBottom(Constants.sH_667 ? 30 : 15, to: emailTextField)
                .leading().trailing().bottom().height(60)
        })
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
