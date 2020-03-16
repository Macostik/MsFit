//
//  SubscriptionView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 27.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SubscriptionView: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    
    private let mealTableView = specify(UITableView(), {
        $0.allowsSelection = false
        $0.register(QuestionSubscriptionCell.self,
                    forCellReuseIdentifier: QuestionSubscriptionCell.identifier)
        $0.rowHeight = 40
        $0.contentInset = .init(top: 15, left: 0, bottom: 0, right: 0)
        $0.separatorInset = .zero
        $0.separatorColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9137254902, alpha: 1)
    })
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        addConstraint()
    }
    
    fileprivate func setupUI() {
        Observable.just(QuestionSubscriptionModels.allCases).bind(to: mealTableView.rx
            .items(cellIdentifier: QuestionSubscriptionCell.identifier,
                   cellType: QuestionSubscriptionCell.self)) { _, model, cell in
                    cell.setup(meals: model)
        }.disposed(by: disposeBag)
    }
    
    fileprivate func addConstraint() {
        add(mealTableView, layoutBlock: { $0.edges() })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

class QuestionSubscriptionCell: UITableViewCell, CellIdentifierable {
    
    static var identifier: String = "QuestionExerciseCell"
    
    private lazy var  plusImageView = specify(UIImageView(), {
        $0.image = UIImage(systemName: "plus", withConfiguration:
            UIImage.SymbolConfiguration(weight: .bold))?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal)
        $0.tintColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
    })
    
    private let titleLabel = specify(UILabel(), {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    })
    
    private let discriptionLabel = specify(UILabel(), {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    })
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addConstraint()
    }
    
    public func setup(meals: QuestionSubscriptionModels) {
        plusImageView.image = UIImage(systemName: "plus")
        titleLabel.text = meals.description().0
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func addConstraint() {
        add(plusImageView, layoutBlock: { $0.leading(16).centerY().size(18) })
        add(titleLabel, layoutBlock: { $0.trailing(16).leadingTrailing(10, to: plusImageView).centerY() })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
