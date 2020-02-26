//  
//  DailySceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DailySceneCoordinator: BaseTabBarSceneCoordinator<DailySceneViewModel> {
    
    override func controller() -> BaseViewController<DailySceneViewModel> {
        let viewModel = DailySceneViewModel(dependencies: dependencies)
        
        viewModel.splashObserver.subscribe(onNext: { _ in
            self.presenQuestionsScene()
        }).disposed(by: disposeBag)
        
        viewModel.splashHomeObserver.subscribe(onNext: { _ in
            self.presenHomeScene()
        }).disposed(by: disposeBag)
        
        return DailySceneViewController.instantiate(with: viewModel)
    }
    
    @discardableResult private func presenQuestionsScene() -> Observable<Void> {
        let questionsCoordinator = QuestionsSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: questionsCoordinator)
    }
    
    @discardableResult private func presenHomeScene() -> Observable<Void> {
        let homeCoordinator = HomeSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: homeCoordinator)
    }
}
