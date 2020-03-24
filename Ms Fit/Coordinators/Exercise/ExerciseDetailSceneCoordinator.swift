//  
//  ExerciseDetailSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 24.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExerciseDetailSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = ExerciseDetailSceneViewModel(dependencies: dependencies)
        let viewController = ExerciseDetailSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.present(viewController, animated: true, completion: nil)
        
        viewModel.dismissObserver.subscribe(onNext: {
            navigationController?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
//    @discardableResult private func present<#Class#>Scene() -> Observable<Void> {
//        let <#Class#>Coordinator = <#Class#>SceneCoordinator(window: window, dependencies: dependencies)
//        return coordinate(to: <#Class#>Coordinator)
//    }
}
