//  
//  PreviewStartSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 16.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PreviewStartSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = PreviewStartSceneViewModel(dependencies: dependencies)
        let viewController = PreviewStartSceneViewController.instantiate(with: viewModel)
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
