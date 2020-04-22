//
//  WarningPopupView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class WarningPopupView: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    
    public let containerView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    })
    
    private let warningImageView = specify(UIImageView(), {
        $0.image = UIImage(named: "offline_image")
    })
    
    private let warningLabel = specify(UILabel(), {
        $0.text = "Warning !"
        $0.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.662745098, alpha: 1)
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 13, weight: .bold)
    })
    
    private let descriptionLabel = specify(UILabel(), {
        $0.text = "تأكدي من اتصالك بالإنترنت"
        $0.textColor = #colorLiteral(red: 0.2, green: 0.2352941176, blue: 0.3058823529, alpha: 1)
        $0.font = .systemFont(ofSize: 22, weight: .medium)
    })
    
    private let doneButton = specify(UIButton(), {
        $0.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.setTitle("رجوع", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .black)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        handleUI()
        setupBindings()
        addConstraints()
    }
    
    fileprivate func handleUI() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.8)
    }
    
    fileprivate func setupBindings() {
        doneButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
                    self?.containerView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    self?.alpha = 0
                }, completion: { _ in
                    self?.removeFromSuperview()
                })
            }).disposed(by: disposeBag)
    }
    
    fileprivate func addConstraints() {
        let vStackView = VStackView(arrangedSubviews: [warningLabel, descriptionLabel], spacing: 15)
        
        add(containerView, layoutBlock: { $0.center().leading(20).trailing(20) })
        containerView.add(warningImageView, layoutBlock: {
            $0.width(Constants.sW * 0.37).height(Constants.sW * 0.3).centerX()
                .top(Constants.sH_812 ? 60 : 40)
        })
        containerView.add(vStackView, layoutBlock: { $0.topBottom(35, to: warningImageView).centerX() })
        containerView.add(doneButton, layoutBlock: {
            $0.bottom().leading().trailing().height(60).topBottom(Constants.sH_812 ? 60 : 40, to: vStackView)
        })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
