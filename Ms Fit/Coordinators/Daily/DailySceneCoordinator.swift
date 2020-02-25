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
            self.presenWorkOutScene()
        }).disposed(by: disposeBag)
        return DailySceneViewController.instantiate(with: viewModel)
    }
    
    @discardableResult private func presenWorkOutScene() -> Observable<Void> {
        let workoutCoordinator = WorkOutSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: workoutCoordinator)
    }
}
