//
//  MealHeaderView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MealHeaderView: UICollectionReusableView, CellIdentifierable {
    
    fileprivate let disposeBag = DisposeBag()
    
    static var identifier: String = "MealHeaderView"
    public var tapPresentSearchHanper: (() -> Void)?
    public var tapPresentLikeMealsHanper: (() -> Void)?
    public var tapHighProteinHanper: ((UIView) -> Void)?
    
    private let searchLabel = Label(icon: "بحث", font: .systemFont(ofSize: 12, weight: .regular),
                                    size: 12, textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), isTranform: true)
    private let highProtein = Label(icon: "بروتين", font: .systemFont(ofSize: 12, weight: .regular),
                                  size: 12, textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), isTranform: true)
    private let favoriteLabel = Label(icon: "المفضلة", font: .systemFont(ofSize: 12, weight: .regular),
                                      size: 12, textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), isTranform: true)
    
    private let configuration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var searchButton = specify(Button(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: configuration)?
            .withTintColor(#colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
        $0.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.backgroundColor = .systemBackground
        $0.circled = true
    })
    
    private lazy var likeMealsButton = specify(Button(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "suit.heart", withConfiguration: configuration)?
            .withTintColor(#colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
        $0.backgroundColor = .systemBackground
        $0.circled = true
    })
    
    private let highProteinButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "snack2"), for: .normal)
        $0.tintColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1)
        $0.backgroundColor = .systemBackground
        $0.circled = true
    })
    
    public let checkmarkView = specify(UIView(), {
        let image = UIImageView(image: UIImage(named: "chackmark_icon"))
        $0.backgroundColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1).withAlphaComponent(0.8)
        $0.layer.cornerRadius = (Constants.sW / 7.5) / 2
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = false
        $0.alpha = 0
        $0.add(image, layoutBlock: { $0.center().width(19).height(14) })
    })
    
    public func setup() {
        setupUI()
        setupBindings()
        addConstraint()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .clear
        searchLabel.textAlignment = .center
        highProtein.textAlignment = .center
        favoriteLabel.textAlignment = .center
    }
    
    fileprivate func setupBindings() {
        highProteinButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.tapHighProteinHanper?(self.checkmarkView)
            }).disposed(by: disposeBag)
        likeMealsButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.tapPresentLikeMealsHanper?()
            }).disposed(by: disposeBag)
        searchButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.tapPresentSearchHanper?()
            }).disposed(by: disposeBag)
    }
    
    fileprivate func addConstraint() {
        highProteinButton.widthAnchor.constraint(equalToConstant: Constants.sW / 6.5).isActive = true
        highProteinButton.heightAnchor.constraint(equalToConstant: Constants.sW / 6.5).isActive = true
        
        let hStackViewForButtons = HStackView(arrangedSubviews: [
            VStackView(arrangedSubviews: [highProteinButton, highProtein], spacing: 5),
            VStackView(arrangedSubviews: [likeMealsButton, favoriteLabel], spacing: 5),
            VStackView(arrangedSubviews: [searchButton, searchLabel], spacing: 5)
        ], spacing: 25)
        hStackViewForButtons.distribution = .fillEqually

        add(hStackViewForButtons, layoutBlock: { $0.centerX().top(15) })
        highProteinButton.add(checkmarkView, layoutBlock: {
            $0.center().height(Constants.sW / 7.5).width(Constants.sW / 7.5)
        })
    }
}
