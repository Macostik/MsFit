//  
//  DailySceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DailySceneCoordinator: BaseTabBarController<DailySceneViewModel> {
    
    override func controller() -> BaseViewController<DailySceneViewModel> {
           return DailySceneViewController.instantiate(with: DailySceneViewModel(dependencies: dependencies))
       }
}
