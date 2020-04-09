//  
//  HistoryResultSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryResultSceneViewController: BaseViewController<HistoryResultSceneViewModel> {
    
    private let historyGraphView = HistoryGraphView()
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "History Results"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let tableView = specify(UITableView(), {
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.separatorStyle = .none
        $0.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.identifier)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
        
        Observable.just(HistoryModel.allCases).bind(to: tableView.rx.items(cellIdentifier:
            HistoryCell.identifier, cellType: HistoryCell.self)) { _, model, cell in
                cell.setup(model)
        }.disposed(by: disposeBag)
        
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(HistoryModel.self))
            .bind { indexPath, model in
                self.viewModel?.presentUpdateObserver.onNext((indexPath.row, model.rawValue))
        }.disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navTextLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 5) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navTextLabel).leading(4).size(44)})
        view.add(historyGraphView, layoutBlock: { $0.topBottom(to: navigationView).leading().trailing() })
        view.add(tableView, layoutBlock: {
            $0.topBottom(25, to: historyGraphView).leading().trailing().height(240)
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
