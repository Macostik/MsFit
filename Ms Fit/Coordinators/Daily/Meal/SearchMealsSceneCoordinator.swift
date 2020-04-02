//  
//  SearchMealsSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 13.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchMealsSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = SearchMealsSceneViewModel(dependencies: dependencies)
        let viewController = SearchMealsSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: { _ in
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.presentMealsStoregeObserver.subscribe(onNext: { _ in
            self.presentMealsStoregeScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentDetailFoodObserver.subscribe(onNext: { _ in
            self.presentDetailFoodStoregeScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentMealsStoregeScene() -> Observable<Void> {
        let storageCoordinator = MealsStorageSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: storageCoordinator)
    }
    
    @discardableResult private func presentDetailFoodStoregeScene() -> Observable<Void> {
        let detailFoodCoordinator = DetailFoodSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: detailFoodCoordinator)
    }
}
