//  
//  ProfileSceneCoordinator.swift
//  
//
//  Created by Yura Granchenko on 22.02.2020.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileSceneCoordinator: BaseTabBarController<ProfileSceneViewModel> {
    
    override func controller() -> BaseViewController<ProfileSceneViewModel> {
        return ProfileSceneViewController.instantiate(with: ProfileSceneViewModel(dependencies: dependencies))
    }
}
