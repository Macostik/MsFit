//  
//  OnboardSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OnboardSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = OnboardSceneViewModel(dependencies: dependencies)
        let viewController = OnboardSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: false)
        
        viewModel.signInObserver.subscribe(onNext: { [weak self] _ in
            self?.presentSignInScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentSignInScene() -> Observable<Void> {
        let signInCoordinator = SignInSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: signInCoordinator)
    }
}
