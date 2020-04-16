//
//  ExercisePreviewCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 24.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class ExercisePreviewCell: UICollectionViewCell, CellIdentifierable {
    
    private let lockImageView = UIImageView(image: UIImage(named: "lock"))
    
    public let lockContainerView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.1450980392, blue: 0.4862745098, alpha: 0.6020173373)
        $0.isHidden = true
    })
    
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
    
    private let onlyGeneralLabel = Label(icon: "فقط عام", font: .systemFont(ofSize: 15, weight: .medium),
                                         textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), isTranform: false, textAlignment: .center)
    private let exerciseText = Label(icon: "", font: .systemFont(ofSize: 14, weight: .regular),
                                     textColor: #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.168627451, alpha: 1), isTranform: true, textAlignment: .center)
    
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
        exercisesImageView.add(lockContainerView, layoutBlock: { $0.edges() })
        lockContainerView.add(lockImageView, layoutBlock: { $0.centerY(-15).centerX() })
        lockContainerView.add(onlyGeneralLabel, layoutBlock: { $0.centerY(15).centerX() })
    }
    
    public func setup(exercise: ExercisePreviewList) {
        exercisesImageView.image =  UIImage(named: exercise.rawValue)
        exerciseText.text = exercise.description()
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
