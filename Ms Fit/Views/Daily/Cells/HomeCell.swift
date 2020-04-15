//
//  HomeCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 26.02.2020.
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
        $0.textAlignment = .center
    })
    
    private let bottomLabel = specify(UILabel(), {
        $0.textColor = UIColor.systemBackground
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    })
    
    public func setup(entry: HomeImageList) {
        let verticalStackView = VStackView(arrangedSubviews: [topLabel, bottomLabel], spacing: 20)
        
        add(topImageView, layoutBlock: { $0.top(0).centerX() })
        add(verticalStackView, layoutBlock: { $0.leading(16).trailing(16).bottom(100) })
        
        topImageView.image = UIImage(named: entry.rawValue)
        topLabel.text = entry.description().0.capitalized
        bottomLabel.text = entry.description().1.capitalized
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) { fatalError() }
}
