//
//  YesterdayWorkoutView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 05.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class YesterdayWorkoutView: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    
    private let containerForButton = specify(UIView(), {
        $0.backgroundColor = .systemBackground
    })
    
    private let containerForExercisesView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowOffset = .init(width: 0, height: 2)
    })
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .thin)
    private lazy var startWorkoutButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "play.fill", withConfiguration: mediumConfiguration)?
            .withTintColor(#colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
        $0.customButton(text: "Start Workout", font: 20, weight: .bold, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), bgColor: #colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.6274509804, alpha: 1))
        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 16)
    })
    
    private let hExercisesStackView = specify(UIStackView(), {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 5
    })
    
    private let minutesLabel = specify(UILabel(), {
        $0.text = "minutes"
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    })
    
    private let timeLabel = specify(UILabel(), {
        $0.text = "0"
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    })
    
    private let clockImageView = specify(UIImageView(), {
        $0.image = UIImage(systemName: "clock",
                           withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        $0.tintColor = #colorLiteral(red: 0.4079999924, green: 0.2980000079, blue: 0.8159999847, alpha: 1)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
//    
//    private let mealTableView = specify(UITableView(), {
//        $0.allowsSelection = false
//        $0.register(QuestionMealCell.self, forCellReuseIdentifier: QuestionMealCell.identifier)
//        $0.rowHeight = 40
//        $0.contentInset = .init(top: 15, left: 0, bottom: 0, right: 0)
//        $0.separatorInset = .zero
//        $0.separatorColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9137254902, alpha: 1)
//    })
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        addConstraint()
    }
    
    fileprivate func setupUI() {
//        Observable.just(QuestionMealModels.allCases).bind(to: mealTableView.rx
//            .items(cellIdentifier: QuestionMealCell.identifier,
//                   cellType: QuestionMealCell.self)) { _, model, cell in
//                    cell.setup(meals: model)
//        }.disposed(by: disposeBag)
        
        startWorkoutButton.animateWhenPressed(disposeBag: disposeBag)
        startWorkoutButton.rx.tap
            .subscribe(onNext: {
                // do something
            }).disposed(by: disposeBag)
    }
    
    fileprivate func addConstraint() {
        clockImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        clockImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        hExercisesStackView.addArrangedSubview(minutesLabel)
        hExercisesStackView.addArrangedSubview(timeLabel)
        hExercisesStackView.addArrangedSubview(clockImageView)
        add(containerForButton, layoutBlock: {
            $0.bottom().leading().trailing().height(Constants.sH_812 ? 110 : 100)
        })
        containerForButton.add(startWorkoutButton, layoutBlock: {
            $0.top(15).leading(16).trailing(16).height(Constants.sW / 6.5)
        })
        add(containerForExercisesView, layoutBlock: {
            $0.top(10).leading().trailing().height(Constants.sW / 5)
        })
        containerForExercisesView.add(hExercisesStackView, layoutBlock: { $0.center() })
    }
    
    required init?(coder: NSCoder) { fatalError("has not been implemented meals table view") }
}

class YesterdayCell: UITableViewCell, CellIdentifierable {
    
    static var identifier: String = "YesterdayCell"
    
//    private lazy var  plusImageView = specify(UIImageView(), {
//        $0.image = UIImage(systemName: "plus", withConfiguration:
//            UIImage.SymbolConfiguration(weight: .bold))?
//            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal)
//        $0.tintColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
//    })
//
//    private let titleLabel = specify(UILabel(), {
//        $0.font = .systemFont(ofSize: 16, weight: .regular)
//    })
//
//    private let discriptionLabel = specify(UILabel(), {
//        $0.font = .systemFont(ofSize: 12, weight: .regular)
//    })
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//        addConstraint()
//    }
//
//    public func setup(meals: QuestionMealModels) {
//        plusImageView.image = UIImage(systemName: "plus")
//        titleLabel.text = meals.description().0
//    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func addConstraint() {
//        add(plusImageView, layoutBlock: { $0.leading(16).centerY().size(18) })
//        add(titleLabel, layoutBlock: { $0.trailing(16).leadingTrailing(10, to: plusImageView).centerY() })
    }
    
    required init?(coder: NSCoder) { fatalError("has not been implemented meal cell") }
}
