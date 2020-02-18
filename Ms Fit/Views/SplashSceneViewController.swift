//  
//  SplashSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SplashSceneViewController: BaseViewController<SplashSceneViewModel> {
    
    private let splashIconImageView = specify(UIImageView()) {
        $0.image = UIImage(named: "splash_icon")
    }
    
    override func setupUI() {
        view.backgroundColor = .systemBackground
        view.add(splashIconImageView, layoutBlock: { $0.center() })
    }
}
