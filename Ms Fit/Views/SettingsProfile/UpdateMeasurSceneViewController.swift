//  
//  UpdateMeasurSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 21.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UpdateMeasurSceneViewController: BaseViewController<UpdateMeasurSceneViewModel> {
    
    private let clearPopupView = ClearPopupView()
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "Update Results"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let resultLabel = Label(icon: "RESULT", font: .systemFont(ofSize: 13, weight: .regular),
                                    textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1))
    
    private let clearResultButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(#colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), for: .normal)
        $0.setTitle("Clear Result", for: .normal)
    })
    
    private let tableView = specify(UITableView(), {
        $0.isScrollEnabled = false
        $0.allowsSelection = false
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.register(UpdateMeasurementCell.self, forCellReuseIdentifier: UpdateMeasurementCell.identifier)
    })
    
    private let updateButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.isUserInteractionEnabled = false
        $0.alpha = 0.4
        $0.customButton(text: "Update", font: 20, weight: .medium,
                        shadowColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), bgColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), isCircled: true)
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
        
        Observable.just(UpdateMeasurementModel.allCases).bind(to: tableView.rx.items(cellIdentifier:
            UpdateMeasurementCell.identifier, cellType: UpdateMeasurementCell.self)) { _, model, cell in
                cell.setup(model)
        }.disposed(by: disposeBag)
        
        clearResultButton.rx.tap
            .subscribe(onNext: { _ in
                rootViewController?.add(self.clearPopupView, layoutBlock: { $0.edges() })
                self.clearPopupView.alpha = 0
                self.clearPopupView.containerView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.clearPopupView.alpha = 1
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5,
                               initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                                self.clearPopupView.containerView.transform = CGAffineTransform(scaleX: 1.0,
                                                                                                y: 1.0)
                })
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navTextLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 5) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navTextLabel).leading(4).size(44)})
        view.add(clearResultButton, layoutBlock: { $0.topBottom(16, to: navigationView).trailing(16) })
        view.add(resultLabel, layoutBlock: { $0.topBottom(25, to: navigationView).leading(16) })
        view.add(updateButton, layoutBlock: {
            $0.bottom(25).leading(16).trailing(16).height(Constants.sW / 6.5)
        })
        view.add(tableView, layoutBlock: {
            $0.topBottom(60, to: navigationView).leading().trailing().height(240)
        })
    }
}