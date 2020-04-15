//
//  StartWorkoutCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 07.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class StartWorkoutCell: UICollectionViewCell, CellIdentifierable {
        
    private let containerView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.layer.cornerRadius = 19
        $0.clipsToBounds = true
    })
    
    private let separatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1) })
    
    private let numberLabel = specify(UILabel(), {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .systemBackground
        $0.textAlignment = .center
    })
    
    public func setup(_ entry: Int) {
        numberLabel.text = "\(entry)"
        
        add(containerView, layoutBlock: { $0.leading().centerY().size(38) })
        containerView.add(numberLabel, layoutBlock: { $0.center() })
        add(separatorView, layoutBlock: {
            $0.leadingTrailing(to: containerView).trailing().centerY().height(2)
        })
    }
}
