//
//  HomeCell.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 26.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import UIKit
import FSPagerView

class HomeCell: FSPagerViewCell {
    
    static let identifier = "HomeCell"
    
    private let topImageView = specify(UIImageView(), {
        $0.contentMode = .scaleToFill
    })
    
    private let topLabel = specify(UILabel(), {
        $0.textColor = UIColor.systemBackground
        $0.font = .systemFont(ofSize: 22, weight: .medium)
    })
    
    private let bottomLabel = specify(UILabel(), {
        $0.textColor = UIColor.systemBackground
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    })
    
    private let verticalStackView = specify(UIStackView(), {
        $0.spacing = 20
        $0.alignment = .center
        $0.axis = .vertical
    })
    
    public func setup(entry: HomeImageList) {
        add(topImageView, layoutBlock: { $0.top(0).centerX() })
        verticalStackView.addArrangedSubview(topLabel)
        verticalStackView.addArrangedSubview(bottomLabel)
        add(verticalStackView, layoutBlock: {
            $0.leading(30).trailing(30).topBottom(30, to: topImageView)
        })
        topImageView.image = UIImage(named: entry.rawValue)
        topLabel.text = entry.description().0.capitalized
        bottomLabel.text = entry.description().1.capitalized
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) { fatalError() }
}
