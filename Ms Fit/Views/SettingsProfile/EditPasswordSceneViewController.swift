//  
//  EditPasswordSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditPasswordSceneViewController: BaseViewController<EditPasswordSceneViewModel> {
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "Edit Password"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let tableView = specify(UITableView(), {
        $0.separatorStyle = .none
        $0.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        $0.rowHeight = 60
        $0.contentInset = .init(top: 25, left: 0, bottom: 0, right: 0)
        $0.isScrollEnabled = false
        $0.register(EditPasswordCell.self, forCellReuseIdentifier: EditPasswordCell.identifier)
    })
        
    private let doneButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "Done", font: 20, weight: .bold, shadowColor: #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1), bgColor: #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1), isCircled: true)
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
        
        view.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [unowned self] _ in
                self.view.endEditing(true)
            }).disposed(by: disposeBag)
        
        Observable.just(EditPasswordModel.allCases)
            .bind(to: tableView.rx.items(cellIdentifier: EditPasswordCell.identifier,
                                         cellType: EditPasswordCell.self)) { _, model, cell in
                                            cell.setup(with: model)
        }.disposed(by: disposeBag)
        
        doneButton.animateWhenPressed(disposeBag: disposeBag)
        doneButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.handleAlert()
            }).disposed(by: disposeBag)        
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navTextLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 5) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navTextLabel).leading(4).size(44) })
        view.add(tableView, layoutBlock: { $0.topBottom(to: navigationView).leading().trailing().bottom() })
        view.add(doneButton, layoutBlock: {
            $0.leading(16).trailing(16).bottom(25).height(Constants.sW * 0.2)
        })
    }
    
    fileprivate func handleAlert() {
        let alertController = UIAlertController(title: "Error",
                                                message: "Please enter a valid password",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
