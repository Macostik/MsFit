//  
//  MainSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = MainSceneViewModel(dependencies: dependencies)
        let viewController = MainSceneViewController.instantiate(with: viewModel)
        let rootViewController = UINavigationController(rootViewController: viewController)
        rootViewController.isNavigationBarHidden = true
//        viewModel.pushObservable.subscribe(onNext: { [weak self] _ in
//            self?.presentOnboardScene()
//        }).disposed(by: disposeBag)
        viewModel.item = configure()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        return Observable.just(())
    }
}

extension MainSceneCoordinator {
    public func configure() -> Observable<UIViewController> {
        return coordinate(to: MainSceneModel.main.coordinator(window: window, dependencies: dependencies))
    }
}

extension MainSceneModel {
    func coordinator(window: UIWindow, dependencies: Dependency) -> BaseCoordinator<UIViewController> {
        return TabBarSceneCoordinator(window: window, dependencies: dependencies)
    }
}
