//
//  TomorrowWorkoutCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class TomorrowWorkoutCell: UICollectionViewCell, CellIdentifierable {
    
    static var identifier: String = "TomorrowWorkoutCell"
    
    private let exercisesImageView = specify(UIImageView(), {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    })
    
    private let containerForTextView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.shadowColor = #colorLiteral(red: 0.4309999943, green: 0.4309999943, blue: 0.474999994, alpha: 1)
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = .init(width: 0, height: 2)
        $0.clipsToBounds = false
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    })
    
    private let exerciseTextLabel = specify(UILabel(), {
        $0.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.168627451, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    })
    
    private let sets_RepsTextLabel = specify(UILabel(), {
        $0.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6666666667, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    })
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        handleUI()
    }
    
    private func handleUI() {
        let vContainerStackView = VStackView(arrangedSubviews: [exercisesImageView, containerForTextView])
        let vForTextStackView = VStackView(arrangedSubviews: [exerciseTextLabel, sets_RepsTextLabel])
        
        containerForTextView.add(vForTextStackView, layoutBlock: { $0.leading(10).trailing(10).centerY() })
        add(vContainerStackView, layoutBlock: { $0.edges() })
    }
    
    public func setup(exercise: TomorrowWorkoutList) {
        exercisesImageView.image =  UIImage(named: exercise.rawValue)
        exerciseTextLabel.text = exercise.description().0
        sets_RepsTextLabel.text = exercise.description().1
    }
    
    required init?(coder: NSCoder) { fatalError("not implemented tomorrow workout cell") }
}
