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
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    override func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        view.add(splashIconImageView, layoutBlock: { $0.center() })
    }
}
