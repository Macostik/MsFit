//  
//  TipsSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TipsSceneCoordinator: BaseTabBarController<TipsSceneViewModel> {
    
    override func controller() -> BaseViewController<TipsSceneViewModel> {
        return TipsSceneViewController.instantiate(with: TipsSceneViewModel(dependencies: dependencies))
    }
}
