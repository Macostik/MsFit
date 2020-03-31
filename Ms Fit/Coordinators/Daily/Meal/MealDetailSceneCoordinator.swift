//  
//  MealDetailSceneCoordinator.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 27.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MealDetailSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = MealDetailSceneViewModel(dependencies: dependencies)
        let viewController = MealDetailSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: { _ in
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
//    @discardableResult private func presentDetailFoodStoregeScene() -> Observable<Void> {
//        let storageCoordinator = MealsStorageSceneCoordinator(window: window, dependencies: dependencies)
//        return coordinate(to: storageCoordinator)
//    }
}
