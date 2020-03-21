//  
//  SplashSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SplashSceneCoordinator: BaseSceneCoordinator<Void> {
    
     override func start() -> Observable<Void> {
        let viewModel = SplashSceneViewModel(dependencies: dependencies)
        let viewController = SplashSceneViewController.instantiate(with: viewModel)
        let rootViewController = UINavigationController(rootViewController: viewController)
        rootViewController.isNavigationBarHidden = true
        viewModel.pushObservable.subscribe(onNext: { [weak self] _ in
//            self?.presentOnboardScene()
            self?.presentMainScene()
        }).disposed(by: disposeBag)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        return Observable.empty()
    }
    
    @discardableResult private func presentOnboardScene() -> Observable<Void> {
        let onboardCoordinator = OnboardSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: onboardCoordinator)
    }
    @discardableResult private func presentMainScene() -> Observable<Void> {
        let mainCoordinator = MainSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: mainCoordinator)
    }
}
