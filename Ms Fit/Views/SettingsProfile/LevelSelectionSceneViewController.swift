//  
//  LevelSelectionSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LevelSelectionSceneViewController: BaseViewController<LevelSelectionSceneViewModel> {
    
    override func setupUI() {
        view.backgroundColor = .red
    }
    
    override func setupBindings() {
//        viewModel?.indicatorViewAnimating.drive(<#drive#>),
//        viewModel?.elements.drive(<#drive#>),
//        viewModel?.loadError.drive(onNext: {<#drive#>}),
    }
}
