//  
//  WorkOutSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WorkOutSceneViewController: BaseViewController<WorkOutSceneViewModel> {
    
    override func setupUI() {
        view.backgroundColor = .white
    }
    
    override func setupBindings() {
//        viewModel?.indicatorViewAnimating.drive(<#drive#>),
//        viewModel?.elements.drive(<#drive#>),
//        viewModel?.loadError.drive(onNext: {<#drive#>}),
    }
}
