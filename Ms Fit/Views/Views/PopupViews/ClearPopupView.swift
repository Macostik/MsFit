//
//  ClearPopupView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 11.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ClearPopupView: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    
    public let containerView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    })
    
    private let textLabel = specify(UILabel(), {
        $0.setLineHeight("Are you sure that you want to clear all meals?", lineHeight: 6.0)
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 22 : 18, weight: .medium)
        $0.textAlignment = .center
        $0.numberOfLines = 2
    })
    
    private let clearButton = specify(UIButton(type: .roundedRect), {
        $0.setTitle("Clear", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1)
    })
    
    private let cancelButton = specify(UIButton(type: .roundedRect), {
        $0.setTitle("Cancel", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupBindings()
        addConstraints()
    }
    
    func setupUI() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.8)
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    func setupBindings() {
        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
                    self?.containerView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    self?.alpha = 0
                }, completion: { _ in
                    self?.removeFromSuperview()
                })
            }).disposed(by: disposeBag)
    }
    
    func addConstraints() {
        
        clearButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let hStackView = HStackView(arrangedSubviews: [clearButton, cancelButton])
        hStackView.distribution = .fillEqually
        
        add(containerView, layoutBlock: { $0.center().width(Constants.sW - 40) })
        containerView.add(hStackView, layoutBlock: { $0.bottom().leading().trailing() })
        containerView.add(textLabel, layoutBlock: {
            $0.bottomTop(-40, to: hStackView).top(40).leading(30).trailing(30)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented ClearPopupView")
    }
}
