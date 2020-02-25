//
//  ExerciseCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 24.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class ExerciseCell: UICollectionViewCell {
    
    static let reuseId = "ExerciseCell"
    
    private let exerciseImageView = UIImageView()
    
    private let vContainerStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.spacing = 10
    })
    
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
        
        vContainerStackView.addArrangedSubview(exerciseImageView)
        vContainerStackView.addArrangedSubview(exerciseText)
        add(vContainerStackView, layoutBlock: { $0.center() })
    }
    
    public func setup(exercise: Exercises) {
        exerciseImageView.image =  UIImage(named: exercise.image)
        exerciseText.text = exercise.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented exercise cell")
    }
}
