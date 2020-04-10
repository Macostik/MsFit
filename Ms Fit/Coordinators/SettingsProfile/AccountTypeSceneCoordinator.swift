//  
//  AccountTypeSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AccountTypeSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = AccountTypeSceneViewModel(dependencies: dependencies)
        let viewController = AccountTypeSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: {
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
}
