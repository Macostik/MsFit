//
//  UpdateMeasurementCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 21.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class UpdateMeasurementCell: UITableViewCell, CellIdentifierable {
    
    static var identifier: String = "UpdateMeasurementCell"
    
    private let exercisesImageView = specify(UIImageView(), {
        $0.contentMode = .scaleAspectFit
    })
    
    private let exercisesLabel = Label(icon: "Chest", font: .systemFont(ofSize: 16, weight: .regular),
                                       textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let resultLabel = Label(icon: "60.0", font: .systemFont(ofSize: 16, weight: .regular),
                                    textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let separatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1) })
    
    public func setup(_ entry: UpdateMeasurementModel) {
        exercisesImageView.image = UIImage(named: entry.rawValue)
        exercisesLabel.text = entry.description().0
        resultLabel.text = entry.description().1
        
        resultLabel.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        exercisesImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        exercisesImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        let hStackView = HStackView(arrangedSubviews: [exercisesImageView, exercisesLabel], spacing: 10)
        
        add(hStackView, layoutBlock: { $0.leading(16).centerY() })
        add(resultLabel, layoutBlock: { $0.trailing(16).top(20).bottom(20) })
        add(separatorView, layoutBlock: { $0.leading().trailing().bottom().height(1) })
    }
}