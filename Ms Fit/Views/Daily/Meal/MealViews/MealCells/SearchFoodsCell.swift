//
//  SearchFoodsCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 02.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchFoodsCell: UITableViewCell, CellIdentifierable {
    
    fileprivate let disposeBag = DisposeBag()
    public var tapHalper: (() -> Void)?
    
    private let iconImageView = specify(UIImageView(), {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    })
    
    private let titleLabel = specify(UILabel(), {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    private let kcalLabel = specify(UILabel(), {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
    })
    
    private let separatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9369999766, green: 0.9369999766, blue: 0.9369999766, alpha: 1) })
    
    public let addFoodButton = specify(Button(type: .roundedRect), {
        $0.setTitle("أضف", for: .normal)
        $0.tintColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1)
        $0.layer.borderColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 30 / 2
        $0.clipsToBounds = true
        $0.touchArea.width = 70
        $0.touchArea.height = 70
    })
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupBindings()
        addConstraints()
    }
    
    public func setup(_ entry: AddFoodsModel) {
        iconImageView.image = UIImage(named: entry.rawValue)
        titleLabel.text = entry.rawValue
        kcalLabel.text = entry.description()
    }
    
    fileprivate func setupUI() {
        selectionStyle = .none
    }
    
    fileprivate func setupBindings() {
        addFoodButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.tapHalper?()
            }).disposed(by: disposeBag)
    }
    
    fileprivate func addConstraints() {
        iconImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        let hStackView = HStackView(arrangedSubviews: [
            iconImageView, VStackView(arrangedSubviews: [titleLabel, kcalLabel])
        ], spacing: 8)

        add(hStackView, layoutBlock: { $0.leading(16).top(10).bottom(10) })
        add(addFoodButton, layoutBlock: { $0.trailing(16).centerY().width(50).height(30) })
        add(separatorView, layoutBlock: { $0.leading().bottom().trailing().height(1) })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
