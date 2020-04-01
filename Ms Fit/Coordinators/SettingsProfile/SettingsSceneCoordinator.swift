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
        
        viewModel.presentUpdateMeasurementObserver.subscribe(onNext: { _ in
            self.presentUpdateMeasureScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentHistoryObserver.subscribe(onNext: { _ in
            self.presentHistoryMeasureScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentHistoryExerciseObserver.subscribe(onNext: { _ in
            self.presentHistoryMeasureScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentUpdateWeightObserver.subscribe(onNext: { _ in
            self.presentUpdateWeightMeasureScene()
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
    
    @discardableResult private func presentUpdateMeasureScene() -> Observable<Void> {
        let updateCoordinator = UpdateMeasurSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: updateCoordinator)
    }
    
    @discardableResult private func presentHistoryMeasureScene() -> Observable<Void> {
        let historyCoordinator = HistoryResultSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: historyCoordinator)
    }
    
    @discardableResult private func presentUpdateWeightMeasureScene() -> Observable<Void> {
        let updateWeightCoordinator = UpdateWeightSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: updateWeightCoordinator)
    }
}
