//  
//  SignInSceneCoordinator.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 19.02.2020.
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
        navigationController?.pushViewController(viewController, animated: false)
        return Observable.just(())
    }
    
//    @discardableResult private func present<#Class#>Scene() -> Observable<Void> {
//        let <#Class#>Coordinator = <#Class#>SceneCoordinator(window: window, dependencies: dependencies)
//        return coordinate(to: <#Class#>Coordinator)
//    }
}