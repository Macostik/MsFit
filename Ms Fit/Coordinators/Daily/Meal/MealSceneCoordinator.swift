//  
//  MealSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MealSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = MealSceneViewModel(dependencies: dependencies)
        let viewController = MealSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: { _ in
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.presentMealsStorege.subscribe(onNext: { [weak self] _ in
            self?.presentMealsStoregeScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentMealsStoregeScene() -> Observable<Void> {
        let storageCoordinator = MealsStorageSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: storageCoordinator)
    }
}
