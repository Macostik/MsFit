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
    
    private let searchLabel = Label(icon: "All meals", font: .systemFont(ofSize: 12, weight: .regular),
                                    size: 12, textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1))
    private let highProtein = Label(icon: "High protein", font: .systemFont(ofSize: 12, weight: .regular),
                                  size: 12, textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1))
    private let favoriteLabel = Label(icon: "Favorites", font: .systemFont(ofSize: 12, weight: .regular),
                                      size: 12, textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1))
    
    private let searchButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "search_icon.pdf"), for: .normal)
        $0.tintColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1)
        $0.backgroundColor = .systemBackground
        $0.circled = true
    })
    
    private let favoriteButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "heart_icon.pdf"), for: .normal)
        $0.tintColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1)
        $0.backgroundColor = .systemBackground
        $0.circled = true
    })
    
    private let highProteinButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "snack2"), for: .normal)
        $0.tintColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1)
        $0.backgroundColor = .systemBackground
        $0.circled = true
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
            .subscribe(onNext: { _ in
                print("tap highProteinButton")
            }).disposed(by: disposeBag)
        favoriteButton.rx.tap
            .subscribe(onNext: { _ in
                print("tap favoriteButton")
            }).disposed(by: disposeBag)
        searchButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.tapPresentSearchHanper?()
            }).disposed(by: disposeBag)
    }
    
    fileprivate func addConstraint() {
        highProteinButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        highProteinButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 56).isActive = true

        let searchStackView = VStackView(arrangedSubviews: [highProteinButton, highProtein], spacing: 5)
        let dietStackView = VStackView(arrangedSubviews: [favoriteButton, favoriteLabel], spacing: 5)
        let favoriteStackView = VStackView(arrangedSubviews: [searchButton, searchLabel], spacing: 5)
        let hStackView = HStackView(arrangedSubviews: [searchStackView, dietStackView, favoriteStackView],
            spacing: 25)

        add(hStackView, layoutBlock: { $0.centerX().top(15) })
    }
}
