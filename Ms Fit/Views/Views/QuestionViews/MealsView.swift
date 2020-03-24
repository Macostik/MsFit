//
//  MealsView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 27.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MealsView: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    
    var selectedIndex = IndexPath(row: 0, section: 0)
    
    private let mealTableView = specify(UITableView(), {
        $0.register(QuestionMealCell.self, forCellReuseIdentifier: QuestionMealCell.identifier)
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
        Observable.just(QuestionMealModels.allCases).bind(to: mealTableView.rx
            .items(cellIdentifier: QuestionMealCell.identifier,
                   cellType: QuestionMealCell.self)) { _, model, cell in
                    cell.setup(meals: model)
        }.disposed(by: disposeBag)
        
        mealTableView.delegate = self
        mealTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0,
                                                             width: mealTableView.frame.size.width,
                                                             height: 1))
    }
    
    fileprivate func addConstraint() {
        add(mealTableView, layoutBlock: { $0.top().leading().trailing().bottom() })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

extension  MealsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex.row == indexPath.row {
            return UITableView.automaticDimension
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex.row == indexPath.row {
            selectedIndex.row = 0
        } else {
            selectedIndex.row = indexPath.row
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

class QuestionMealCell: UITableViewCell, CellIdentifierable {
    
    static var identifier: String = "QuestionMealCell"
    
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
        $0.numberOfLines = 0
    })
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addConstraint()
    }
    
    public func setup(meals: QuestionMealModels) {
        plusImageView.image = UIImage(systemName: "plus")
        titleLabel.text = meals.description().0
        discriptionLabel.text = meals.description().1
    }
    
    fileprivate func setupUI() {
        selectionStyle = .none
    }
    
    fileprivate func addConstraint() {
        add(plusImageView, layoutBlock: { $0.leading(16).top(10).size(18) })
        add(titleLabel, layoutBlock: { $0.leadingTrailing(16, to: plusImageView).top(10).trailing(16) })
        add(discriptionLabel, layoutBlock: { $0.leading(16).trailing(16).top(40).bottom() })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
