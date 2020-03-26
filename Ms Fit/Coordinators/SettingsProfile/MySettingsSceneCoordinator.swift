//  
//  MySettingsSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MySettingsSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = MySettingsSceneViewModel(dependencies: dependencies)
        let viewController = MySettingsSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: {
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.heightSceneObserver.subscribe(onNext: { [weak self] in
            self?.presentNewRegistScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentNewRegistScene() -> Observable<Void> {
        let newRegistCoordinator = NewRegistSceneCoordinator(window: window, dependencies: dependencies)
        newRegistCoordinator.pickerElement = .height
        newRegistCoordinator.isProceed = true
        return coordinate(to: newRegistCoordinator)
    }
}
