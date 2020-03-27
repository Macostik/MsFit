//
//  AddFeedsPopupView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 27.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddFeedsPopupView: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    
    public let containerView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    })

    private let titleLabel = specify(UILabel(), {
        $0.text = "Fruits"
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
        $0.textAlignment = .center
    })

    private let addSupplementsButton = specify(UIButton(type: .roundedRect), {
        $0.setTitle("Add supplements", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupBindings()
        addConstraints()
    }
    
    func setupUI() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.8)
    }
    
    func setupBindings() {
        addSupplementsButton.rx.tap
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
        add(containerView, layoutBlock: { $0.width(Constants.sW - 32).height(Constants.sH * 0.8).center() })
        containerView.add(titleLabel, layoutBlock: {
            $0.top().leading().trailing().height(Constants.sW / 5.5)
        })
        containerView.add(addSupplementsButton, layoutBlock: {
            $0.leading().trailing().bottom().height(Constants.sW / 6.5)
        })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
