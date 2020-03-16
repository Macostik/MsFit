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
        return SettingsSceneViewController
            .instantiate(with: SettingsSceneViewModel(dependencies: dependencies))
    }
}
