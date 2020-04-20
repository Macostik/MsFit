//  
//  AllVideosSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AllVideosSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = AllVideosSceneViewModel(dependencies: dependencies)
        let viewController = AllVideosSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: { _ in
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
}
