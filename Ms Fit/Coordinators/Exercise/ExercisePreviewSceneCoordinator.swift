//  
//  ExercisePreviewSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 24.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExercisePreviewSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = ExercisePreviewSceneViewModel(dependencies: dependencies)
        let viewController = ExercisePreviewSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.presentWorkoutObserver.subscribe(onNext: { _ in
            self.presenWorkoutScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentDetailObserver.subscribe(onNext: { _ in
            self.presenDetailScene()
        }).disposed(by: disposeBag)
        
        viewModel.dismissObserver.subscribe(onNext: {
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presenWorkoutScene() -> Observable<Void> {
        let workoutCoordinator = WorkOutSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: workoutCoordinator)
    }
    
    @discardableResult private func presenDetailScene() -> Observable<Void> {
        let detailCoordinator = ExerciseDetailSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: detailCoordinator)
    }
}
