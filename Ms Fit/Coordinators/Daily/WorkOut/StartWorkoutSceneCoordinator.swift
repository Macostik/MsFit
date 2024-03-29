//  
//  StartWorkoutSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StartWorkoutSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = StartWorkoutSceneViewModel(dependencies: dependencies)
        let viewController = StartWorkoutSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: {
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.dismissDailySceneObserver.subscribe(onNext: {
            navigationController?.popToRootViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.presentRestWorkoutObserver.subscribe(onNext: {
            self.presentRestWorkoutScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentRestWorkoutScene() -> Observable<Void> {
        let restWorkoutCoordinator = RestWorkoutSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: restWorkoutCoordinator)
    }
}
