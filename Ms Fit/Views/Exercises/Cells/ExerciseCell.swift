//
//  ExerciseCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 24.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class ExerciseCell: UICollectionViewCell, CellIdentifierable {
    
    private let exerciseImageView = UIImageView()
    private let lockImageView = UIImageView(image: UIImage(named: "lock"))
    
    public let lockContainerView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.1450980392, blue: 0.4862745098, alpha: 0.6020173373)
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.isHidden = true
    })
    
    private let baseContainerView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.shadowColor = #colorLiteral(red: 0.4309999943, green: 0.4309999943, blue: 0.474999994, alpha: 1)
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowOffset = .init(width: 0, height: 2)
        $0.layer.cornerRadius = 6
    })
    
    private let onlyGeneralLabel = Label(icon: "فقط عام", font: .systemFont(ofSize: 15, weight: .medium),
                                         textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), isTranform: false, textAlignment: .center)
    private let exerciseTextBlack = Label(icon: "", font: .systemFont(ofSize: 16, weight: .regular),
                                          textColor: #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.168627451, alpha: 1), isTranform: false, textAlignment: .center)
    private let exerciseTextWhite = Label(icon: "", font: .systemFont(ofSize: 16, weight: .regular),
                                          textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), isTranform: false, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        handleUI()
    }
    
    private func handleUI() {
        let vContainerStackView = VStackView(arrangedSubviews: [exerciseImageView, exerciseTextBlack],
                                             spacing: 10)
        
        add(baseContainerView, layoutBlock: { $0.edges() })
        baseContainerView.add(vContainerStackView, layoutBlock: { $0.center() })
        baseContainerView.add(lockContainerView, layoutBlock: { $0.edges() })
        lockContainerView.add(lockImageView, layoutBlock: { $0.centerY(-30).centerX() })
        lockContainerView.add(onlyGeneralLabel, layoutBlock: {$0.centerX().centerY() })
        lockContainerView.add(exerciseTextWhite, layoutBlock: { $0.center(exerciseTextBlack) })
    }
    
    public func setup(exercise: ExercisesList) {
        exerciseImageView.image =  UIImage(named: exercise.rawValue)
        exerciseTextBlack.text = exercise.rawValue
        exerciseTextWhite.text = exercise.rawValue
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
