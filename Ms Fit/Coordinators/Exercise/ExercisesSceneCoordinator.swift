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

class ExercisesSceneCoordinator: BaseTabBarSceneCoordinator<ExercisesSceneViewModel> {
    
    override func controller() -> BaseViewController<ExercisesSceneViewModel> {
        let viewModel = ExercisesSceneViewModel(dependencies: dependencies)
        
        viewModel.presentWorkoutObserver.subscribe(onNext: { _ in
            self.presenWorkoutScene()
        }).disposed(by: disposeBag)
        
        return ExercisesSceneViewController.instantiate(with: viewModel)
    }
    
    @discardableResult private func presenWorkoutScene() -> Observable<Void> {
        let workoutCoordinator = WorkOutSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: workoutCoordinator)
    }
}
