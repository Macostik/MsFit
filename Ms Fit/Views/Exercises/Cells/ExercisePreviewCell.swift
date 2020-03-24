//
//  ExercisePreviewCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 24.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class ExercisePreviewCell: UICollectionViewCell, CellIdentifierable {
    
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
        $0.layer.cornerRadius = 5
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    })
    
    private let exerciseText = specify(UILabel(), {
        $0.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.168627451, alpha: 1)
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    })
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        handleUI()
    }
    
    private func handleUI() {
        let vContainerStackView = VStackView(arrangedSubviews: [exercisesImageView, containerForTextView])
        
        containerForTextView.add(exerciseText, layoutBlock: {
            $0.leading(16).trailing(16).top(16).bottom(16).height(20)
        })
        add(vContainerStackView, layoutBlock: { $0.edges() })
    }
    
    public func setup(exercise: ExercisePreviewList) {
        exercisesImageView.image =  UIImage(named: exercise.rawValue)
        exerciseText.text = exercise.description()
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
