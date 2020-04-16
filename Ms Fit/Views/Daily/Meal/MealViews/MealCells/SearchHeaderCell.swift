//
//  SearchHeaderCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 03.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class SearchHeaderCell: UICollectionViewCell, CellIdentifierable {
    
    private let fruitImageView = UIImageView()
    
    private let checkmarkView = specify(UIView(), {
        let image = UIImageView(image: UIImage(named: "chackmark_icon"))
        $0.backgroundColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1).withAlphaComponent(0.8)
        $0.isUserInteractionEnabled = false
        $0.alpha = 0
        $0.circled = true
        $0.add(image, layoutBlock: { $0.center().width(18).height(13) })
    })
    
    private let containerView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.shadowColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.layer.shadowOffset = .init(width: 0, height: 0.3)
        $0.layer.shadowOpacity = 0.5
        $0.circled = true
    })
    
    private let nameLabel = specify(UILabel(), {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.textAlignment = .center
    })
    
    public func setup(with model: HeaderModel) {
        fruitImageView.image = UIImage(named: model.rawValue)
        nameLabel.text = model.rawValue.capitalized
        
        add(containerView, layoutBlock: { $0.top(5).leading(5).trailing(5).height(Constants.sW * 0.17 - 10) })
        containerView.add(fruitImageView, layoutBlock: { $0.edges(8) })
        containerView.add(checkmarkView, layoutBlock: { $0.edges() })
        add(nameLabel, layoutBlock: { $0.topBottom(2, to: containerView).leading().trailing().bottom() })
    }
    
    override var isSelected: Bool {
        didSet {
            checkmarkView.alpha = isSelected ? 1.0 : 0.0
        }
    }
}
