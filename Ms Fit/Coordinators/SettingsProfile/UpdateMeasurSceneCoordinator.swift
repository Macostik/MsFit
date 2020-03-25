//  
//  UpdateMeasurSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 21.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UpdateMeasurSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = UpdateMeasurSceneViewModel(dependencies: dependencies)
        let viewController = UpdateMeasurSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: {
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.presentUpdateObserver.subscribe(onNext: { _ in
            self.presentUpdateExerciseScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentUpdateExerciseScene() -> Observable<Void> {
        let updateExerciseCoordinator = UpdateExerciseSceneCoordinator(window: window,
                                                                       dependencies: dependencies)
        return coordinate(to: updateExerciseCoordinator)
    }
}
