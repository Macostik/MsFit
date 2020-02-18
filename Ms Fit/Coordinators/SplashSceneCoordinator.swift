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
           window.rootViewController = rootViewController
           window.makeKeyAndVisible()
           
           return Observable.empty()
       }
    
//    @discardableResult private func present<#Class#>Scene() -> Observable<Void> {
//        let <#Class#>Coordinator = <#Class#>SceneCoordinator(window: window, dependencies: dependencies)
//        return coordinate(to: <#Class#>Coordinator)
//    }
}
