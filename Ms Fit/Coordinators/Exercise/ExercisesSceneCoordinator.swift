//  
//  ExercisesSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExercisesSceneCoordinator: BaseTabBarController<ExercisesSceneViewModel> {
    
    override func controller() -> BaseViewController<ExercisesSceneViewModel> {
        return ExercisesSceneViewController
            .instantiate(with: ExercisesSceneViewModel(dependencies: dependencies))
    }
}
