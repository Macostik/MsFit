//
//  MealsCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 01.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MealsCell: UITableViewCell, CellIdentifierable {
    
    fileprivate let disposeBag = DisposeBag()
    public var tapHalper: (() -> Void)?
    
    private let iconImageView = UIImageView()
    
    private let nameLabel = specify(UILabel(), {
        $0.font = UIFont.boldSystemFont(ofSize: 12.0)
    })
    
    private let addMealsButton = specify(UIButton(type: .roundedRect), {
        $0.layer.borderColor = #colorLiteral(red: 0.4309999943, green: 0.4309999943, blue: 0.474999994, alpha: 1)
        $0.layer.borderWidth = 0.3
        $0.setTitleColor(#colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), for: .normal)
        $0.customButton(text: "أضف وجبات +", font: 14, weight: .regular, shadowColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1),
                        bgColor: .systemBackground, isCircled: true)
    })
    
    private let topView = specify(UIView(), { $0.backgroundColor = .clear })
    private let middleView = specify(UIView(), { $0.backgroundColor = .white })
    private let bottomView = specify(UIView(), { $0.backgroundColor = .white })
    private let separatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9369999766, green: 0.9369999766, blue: 0.9369999766, alpha: 1) })
    
    public func setup(data: MealsStorageSceneModel) {
        backgroundColor = .clear
        iconImageView.image = data.getImage()
        nameLabel.text = data.rawValue.capitalized
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupBindings()
        addConstraints()
    }
    
    fileprivate func setupUI() {
        selectionStyle = .none
    }
    
    fileprivate func setupBindings() {
//        addMealsButton.rx.tap
//            .subscribe(onNext: { _ in
//                tapHalper?()
//            }).disposed(by: disposeBag)
    }
    
    fileprivate func addConstraints() {
        add(topView, layoutBlock: { $0.leading().top().trailing().height(16) })
        add(middleView, layoutBlock: { $0.leading().topBottom(to: topView).trailing().height(41) })
        middleView.add(iconImageView, layoutBlock: { $0.leading(20).centerY() })
        middleView.add(nameLabel, layoutBlock: { $0.leadingTrailing(10, to: iconImageView).centerY() })
        add(separatorView, layoutBlock: { $0.leading().topBottom(to: middleView).trailing().height(1) })
        add(bottomView, layoutBlock: {
            $0.leading().topBottom(to: separatorView).trailing().height(60).bottom()
        })
        bottomView.add(addMealsButton, layoutBlock: { $0.center().width(114).height(34) })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
