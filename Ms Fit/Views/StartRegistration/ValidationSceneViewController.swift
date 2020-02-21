//  
//  ValidationSceneViewController.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 21.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ValidationSceneViewController: BaseViewController<ValidationSceneViewModel> {
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        view.backgroundColor = UIColor(named: "#8F5CE8")
    }
    
    fileprivate func handleUI() {
        
    }
    
    fileprivate func addConstraints() {
        
    }
}
