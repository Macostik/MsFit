//  
//  TabBarSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TabBarSceneCoordinator: BaseSceneCoordinator<UIViewController> {
    
    override func start() -> Observable<UIViewController> {
        let viewModel = TabBarSceneViewModel(dependencies: dependencies)
        let viewController = TabBarSceneViewController.instantiate(with: viewModel)
        Observable.combineLatest(configure())
            .subscribe(onNext: { viewControllers in
                viewController.viewControllers = viewControllers
            }).disposed(by: disposeBag)
        return Observable.just(viewController)
    }
}

extension TabBarSceneCoordinator {
    public func configure() -> [Observable<UINavigationController>] {
        return TabBarSceneModel.allCases
            .map { coordinate(to: $0.coordinator(window: window, dependencies: dependencies)) }
    }
}

extension TabBarSceneModel {
    
    func coordinator(window: UIWindow, dependencies: Dependency) -> BaseCoordinator<UINavigationController> {
           switch self {
           case .daily:
               let coordinator = DailySceneCoordinator(window: window, dependencies: dependencies)
               coordinator.tabBarIcon = rawValue
               return coordinator
           case .exercises:
               let coordinator = ExercisesSceneCoordinator(window: window, dependencies: dependencies)
               coordinator.tabBarIcon = rawValue
               return coordinator
           case .tips:
               let coordinator = TipsSceneCoordinator(window: window, dependencies: dependencies)
               coordinator.tabBarIcon = rawValue
               return coordinator
           case .profile:
               let coordinator = SettingsSceneCoordinator(window: window, dependencies: dependencies)
               coordinator.tabBarIcon = rawValue
               return coordinator
           }
       }
}
