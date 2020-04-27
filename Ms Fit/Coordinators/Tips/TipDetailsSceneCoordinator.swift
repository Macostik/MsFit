//  
//  TipDetailsSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 23.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TipDetailsSceneCoordinator: BaseSceneCoordinator<Void> {
    public var tipsID = ""
    
    override func start() -> Observable<Void> {
        let viewModel = TipDetailsSceneViewModel(dependencies: dependencies)
        let viewController = TipDetailsSceneViewController.instantiate(with: viewModel)
        viewController.tipsID = tipsID
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: {
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
//    @discardableResult private func present<#Class#>Scene() -> Observable<Void> {
//        let <#Class#>Coordinator = <#Class#>SceneCoordinator(window: window, dependencies: dependencies)
//        return coordinate(to: <#Class#>Coordinator)
//    }
}
