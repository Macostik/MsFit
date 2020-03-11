//
//  MealHeaderView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class MealHeaderView: UICollectionReusableView, CellIdentifierable {
    
    static var identifier: String = "MealHeaderView"
    
    private let searchLabel = Label(icon: "search", font: .systemFont(ofSize: 12, weight: .regular),
                                    size: 12, textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1))
    private let dietLabel = Label(icon: "diet", font: .systemFont(ofSize: 12, weight: .regular),
                                  size: 12, textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1))
    private let favoriteLabel = Label(icon: "favorite", font: .systemFont(ofSize: 12, weight: .regular),
                                      size: 12, textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1))
    
    private let favoriteConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var favoriteButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "heart", withConfiguration: favoriteConfiguration)?
            .withTintColor(#colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let searchConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var searchButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "heart", withConfiguration: searchConfiguration)?
            .withTintColor(#colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let dietsButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "daily_Meals_Icon"), for: .normal)
        $0.setTitleColor(#colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1), for: .normal)
    })
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        addConstraint()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addConstraint()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .red
    }
    
    fileprivate func setupBindings() {
        
    }
    
    fileprivate func addConstraint() {
        let searchStackView = VStackView(arrangedSubviews: [searchButton, searchLabel], spacing: 5)
        let dietStackView = VStackView(arrangedSubviews: [dietsButton, dietLabel], spacing: 5)
        let favoriteStackView = VStackView(arrangedSubviews: [favoriteButton, favoriteLabel], spacing: 5)
        let hStackView = HStackView(arrangedSubviews: [searchStackView, dietStackView, favoriteStackView],
                                    spacing: 20)
        
        add(hStackView, layoutBlock: { $0.center() })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented MealHeaderView")
    }
    
}
