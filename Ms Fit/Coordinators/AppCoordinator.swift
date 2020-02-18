//
//  AppCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import RxSwift
import Foundation

class AppCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let splashCoordinator = SplashSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: splashCoordinator)
    }
}
