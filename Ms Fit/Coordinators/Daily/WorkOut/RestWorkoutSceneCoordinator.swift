//  
//  RestWorkoutSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 08.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RestWorkoutSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = RestWorkoutSceneViewModel(dependencies: dependencies)
        let viewController = RestWorkoutSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: { _ in
            navigationController?.popToViewController(navigationController!.viewControllers[1],
                                                      animated: true)
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
}
