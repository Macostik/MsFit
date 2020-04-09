//  
//  HistoryResultSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryResultSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = HistoryResultSceneViewModel(dependencies: dependencies)
        let viewController = HistoryResultSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: {
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.presentUpdateObserver.subscribe(onNext: { _ in
            self.presentUpdateWeightMeasureScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentUpdateWeightMeasureScene() -> Observable<Void> {
        let updateWeightCoordinator = UpdateWeightSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: updateWeightCoordinator)
    }
}
