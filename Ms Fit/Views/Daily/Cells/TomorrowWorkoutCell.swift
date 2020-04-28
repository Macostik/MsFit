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
        $0.contentMode = .scaleAspectFill
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
    
    private let exerciseText = specify(UILabel(), {
        $0.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.168627451, alpha: 1)
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: Constants.sH_812 ? 11 : 10, weight: .regular)
    })
    
    private let descriptionText = specify(UILabel(), {
        $0.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6666666667, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: Constants.sH_812 ? 13 : 8, weight: .regular)
    })
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        handleUI()
    }
    
    private func handleUI() {
        let vForTextStackView = VStackView(arrangedSubviews: [exerciseText, descriptionText])
        
        add(exercisesImageView, layoutBlock: { $0.top().leading().trailing().height(90) })
        add(containerForTextView, layoutBlock: {
            $0.leading().bottom().trailing().topBottom(to: exercisesImageView)
        })
        containerForTextView.add(vForTextStackView, layoutBlock: { $0.leading(10).trailing(10).centerY() })
    }
    
    public func setup(exercise: ExerciseItem) {
        exercisesImageView.sd_setImage(with: URL(string: exercise.pictures.first ?? ""),
                                       placeholderImage: UIImage(named: "splash_icon"),
                                       options: [.continueInBackground, .highPriority, .retryFailed])
        exerciseText.text = "\(exercise.title.count). \(exercise.title)"
        descriptionText.text =
            "\(exercise.sets)" + " \(exercise.sets.applyToCount()) | " + "\(exercise.set_time ?? "") دقيقة"
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
