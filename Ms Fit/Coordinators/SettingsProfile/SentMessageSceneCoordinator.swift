//  
//  SentMessageSceneCoordinator.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 09.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SentMessageSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = SentMessageSceneViewModel(dependencies: dependencies)
        let viewController = SentMessageSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: {
            navigationController?.popToRootViewController(animated: true)
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
}
