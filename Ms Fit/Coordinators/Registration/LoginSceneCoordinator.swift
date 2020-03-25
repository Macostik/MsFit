//  
//  LoginSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = LoginSceneViewModel(dependencies: dependencies)
        let viewController = LoginSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.presentForgotPassObserver.subscribe(onNext: { [weak self] _ in
            self?.presentForgotPassScene()
        }).disposed(by: disposeBag)
        
        viewModel.dismissObserver.subscribe(onNext: {_ in
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.presentMainScene.subscribe(onNext: { [weak self] in
            self?.presentMainScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentForgotPassScene() -> Observable<Void> {
        let forgotCoordinator = ForgotPassSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: forgotCoordinator)
    }
    
    @discardableResult private func presentMainScene() -> Observable<Void> {
           let mainCoordinator = MainSceneCoordinator(window: window, dependencies: dependencies)
           return coordinate(to: mainCoordinator)
       }
}
