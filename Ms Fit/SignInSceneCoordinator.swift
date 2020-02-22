//  
//  SignInSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 19.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignInSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = SignInSceneViewModel(dependencies: dependencies)
        let viewController = SignInSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: { _ in
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.presentLoginScreenObserver.subscribe(onNext: { [weak self] _ in
            self?.presentLoginScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentValidationObserver.subscribe(onNext: { [weak self] _ in
            self?.presentValidationScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentLoginScene() -> Observable<Void> {
        let loginCoordinator = LoginSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: loginCoordinator)
    }
    
    @discardableResult private func presentValidationScene() -> Observable<Void> {
        let validationCoordinator = ValidationSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: validationCoordinator)
    }
}