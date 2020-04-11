//  
//  AccountSettingsSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AccountSettingsSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = AccountSettingsSceneViewModel(dependencies: dependencies)
        let viewController = AccountSettingsSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: {
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.presentEditPasswordObserver.subscribe(onNext: { [weak self] _ in
            self?.presentEditPasswordScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentEditPasswordScene() -> Observable<Void> {
        let editPasswordCoordinator = EditPasswordSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: editPasswordCoordinator)
    }
}
