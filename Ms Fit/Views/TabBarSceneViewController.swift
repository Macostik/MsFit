//  
//  TabBarSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TabBarSceneViewController<T>: UITabBarController, ViewModelBased, BaseInstance {
    typealias ViewModel = T
    var viewModel: T?
}
