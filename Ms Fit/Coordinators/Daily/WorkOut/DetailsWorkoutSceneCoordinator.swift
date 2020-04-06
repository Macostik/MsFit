//  
//  DetailsWorkoutSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsWorkoutSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = DetailsWorkoutSceneViewModel(dependencies: dependencies)
        let viewController = DetailsWorkoutSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: {
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.presentStartWorkoutObserver.subscribe(onNext: { [weak self] _ in
            self?.presentStartWorkoutScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentStartWorkoutScene() -> Observable<Void> {
        let startWorkoutCoordinator = StartWorkoutSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: startWorkoutCoordinator)
    }
}
