//  
//  LikeMealsSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 02.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LikeMealsSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = LikeMealsSceneViewModel(dependencies: dependencies)
        let viewController = LikeMealsSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: { _ in
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.presentMealDetailObserver.subscribe(onNext: { [weak self] _ in
            self?.presentMealDetailScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentMealsStoregeObserver.subscribe(onNext: { [weak self] _ in
            self?.presentMealsStoregeScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentMealDetailScene() -> Observable<Void> {
        let mealDetailCoordinator = MealDetailSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: mealDetailCoordinator)
    }
    
    @discardableResult private func presentMealsStoregeScene() -> Observable<Void> {
        let storageCoordinator = MealsStorageSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: storageCoordinator)
    }
}
