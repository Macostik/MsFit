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
    
    private let exerciseText = specify(UILabel(), {
        $0.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.168627451, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textAlignment = .center
    })
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        handleUI()
    }
    
    private func handleUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        clipsToBounds = true
        
        let vContainerStackView = VStackView(arrangedSubviews: [exerciseImageView, exerciseText], spacing: 10)

        add(vContainerStackView, layoutBlock: { $0.center() })
    }
    
    public func setup(exercise: ExercisesList) {
        exerciseImageView.image =  UIImage(named: exercise.rawValue)
        exerciseText.text = exercise.rawValue
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
