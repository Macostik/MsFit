//  
//  SettingsSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 16.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsSceneCoordinator: BaseTabBarSceneCoordinator<SettingsSceneViewModel> {
    
    override func controller() -> BaseViewController<SettingsSceneViewModel> {
        let viewModel = SettingsSceneViewModel(dependencies: dependencies)
        
        viewModel.presentContactUsObserver.subscribe(onNext: { _ in
            self.presentContactUsScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentMySettingsObserver.subscribe(onNext: { _ in
            self.presentMySettingsScene()
        }).disposed(by: disposeBag)
        
        return SettingsSceneViewController.instantiate(with: viewModel)
    }
    
    @discardableResult private func presentContactUsScene() -> Observable<Void> {
        let contactUsCoordinator = ContactUsSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: contactUsCoordinator)
    }
    
    @discardableResult private func presentMySettingsScene() -> Observable<Void> {
        let mySettingsCoordinator = MySettingsSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: mySettingsCoordinator)
    }
}
