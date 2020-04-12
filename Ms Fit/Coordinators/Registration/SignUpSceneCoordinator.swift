//  
//  SignUpSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 21.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpSceneCoordinator: BaseSceneCoordinator<Void> {
    
    public var userParams = [String: String]()
    
    override func start() -> Observable<Void> {
        let viewModel = SignUpSceneViewModel(dependencies: dependencies)
        let viewController = SignUpSceneViewController.instantiate(with: viewModel)
        viewController.userParams = userParams
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObservable.subscribe(onNext: { _ in
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.presentMainSceneObservale.subscribe(onNext: { [weak self] _ in
            self?.presentMainScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentMainScene() -> Observable<Void> {
        let mainCoordinator = MainSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: mainCoordinator)
    }
}
