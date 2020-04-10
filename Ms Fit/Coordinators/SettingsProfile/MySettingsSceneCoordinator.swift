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
        
        viewModel.heightSceneObserver.subscribe(onNext: { [weak self] model in
            self?.presentNewRegistScene(model: model)
        }).disposed(by: disposeBag)
        
        viewModel.presentLevelSelectionObserver.subscribe(onNext: { [weak self] _ in
            self?.presentLevelSelectionScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentAccountSettingsObserver.subscribe(onNext: { [weak self] _ in
            self?.presentAccountSettingsScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentNewRegistScene(model: SettingsStorageSceneModel) ->
        Observable<Void> {
        let newRegistCoordinator = NewRegistSceneCoordinator(window: window, dependencies: dependencies)
        switch model {
        case .heigth:
            newRegistCoordinator.pickerElement = .height
        case .dateOfBirthday:
            newRegistCoordinator.pickerElement = .weight
        case .goal:
            newRegistCoordinator.pickerElement = .age
        default:
            break
        }
        newRegistCoordinator.isProceed = true
        return coordinate(to: newRegistCoordinator)
    }
    
    @discardableResult private func presentLevelSelectionScene() -> Observable<Void> {
        let levelCoordinator = LevelSelectionSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: levelCoordinator)
    }
    
    @discardableResult private func presentAccountSettingsScene() -> Observable<Void> {
        let accountCoordinator = AccountSettingsSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: accountCoordinator)
    }
}
