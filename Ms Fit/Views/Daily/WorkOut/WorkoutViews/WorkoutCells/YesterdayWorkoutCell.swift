//
//  YesterdayWorkoutCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 05.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class YesterdayWorkoutCell: UICollectionViewCell, CellIdentifierable {
    
    static var identifier: String = "YesterdayWorkoutCell"
    
    private let exercisesImageView = specify(UIImageView(), {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    })
    
    private let vContainerStackView = specify(UIStackView(), {
        $0.axis = .vertical
    })
    
    private let vForTextStackView = specify(UIStackView(), {
        $0.axis = .vertical
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
    
    private let exerciseText = specify(UILabel(), {
        $0.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.168627451, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    })
    
    private let descriptionText = specify(UILabel(), {
        $0.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6666666667, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    })
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        handleUI()
    }
    
    private func handleUI() {
        vContainerStackView.addArrangedSubview(exercisesImageView)
        vContainerStackView.addArrangedSubview(containerForTextView)
        vForTextStackView.addArrangedSubview(exerciseText)
        vForTextStackView.addArrangedSubview(descriptionText)
        containerForTextView.add(vForTextStackView, layoutBlock: { $0.leading(10).trailing(10).centerY() })
        add(vContainerStackView, layoutBlock: { $0.edges() })
    }
    
    public func setup(exercise: YesterdayWorkoutList) {
        exercisesImageView.image =  UIImage(named: exercise.rawValue)
        exerciseText.text = exercise.description().0
        descriptionText.text = exercise.description().1
    }
    
    required init?(coder: NSCoder) { fatalError("not implemented yesterday workout cell") }
}
