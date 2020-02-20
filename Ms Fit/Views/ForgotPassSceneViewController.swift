//  
//  ForgotPassSceneViewController.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 20.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ForgotPassSceneViewController: BaseViewController<ForgotPassSceneViewModel> {
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: mediumConfiguration)?
            .withTintColor(UIColor(named: "closeButton")!, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismiss)
            .disposed(by: disposeBag)
    }
    
    fileprivate func addConstraints() {
        view.add(closeButton, layoutBlock: {$0.top(Constants.screenHeight812 ? 33 : 20).leading(20).size(44) })
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = .systemBackground
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
}
