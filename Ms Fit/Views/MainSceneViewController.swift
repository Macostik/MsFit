//  
//  MainSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainSceneViewController: BaseViewController<MainSceneViewModel> {
    
    override func setupUI() {}
    
    override func setupBindings() {
        viewModel?.item?.asObservable()
            .subscribe(onNext: { [unowned self] viewController in
                self.view.add(viewController.view, layoutBlock: { $0.edges() })
            }).disposed(by: disposeBag)
    }
}
